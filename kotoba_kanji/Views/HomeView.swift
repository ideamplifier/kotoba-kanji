import SwiftUI
import SwiftData

// MARK: - Home View
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var phrases: [JapanesePhrase]
    @State private var currentIndex = 0
    @State private var viewMode: ViewMode = .sequential
    @State private var randomizedPhrases: [JapanesePhrase] = []
    @StateObject private var autoSlideManager = AutoSlideManager()
    
    // MARK: - UserDefaults Keys
    private let lastCardIndexKey = "lastCardIndex"
    private let lastViewModeKey = "lastViewMode"
    
    // MARK: - Enums
    enum ViewMode: String, CaseIterable {
        case sequential = "순서대로"
        case random = "랜덤"
        
        var icon: String {
            switch self {
            case .sequential: return "list.number"
            case .random: return "shuffle"
            }
        }
    }
    

    
    // MARK: - Computed Properties
    private var displayPhrases: [JapanesePhrase] {
        switch viewMode {
        case .sequential:
            return phrases.sorted { $0.id < $1.id }
        case .random:
            return randomizedPhrases.isEmpty ? phrases.sorted { $0.id < $1.id } : randomizedPhrases
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                // Card Page View
                VStack {
                    if displayPhrases.isEmpty {
                        CardPlaceholderView()
                            .frame(height: 590)
                            .accessibilityLabel("카드가 비어있습니다")
                    } else {
                        TabView(selection: $currentIndex) {
                            ForEach(Array(displayPhrases.enumerated()), id: \.offset) { index, phrase in
                                CardView(phrase: phrase)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 590)
                        .offset(x: autoSlideManager.shakeOffset)
                        .onChange(of: currentIndex) { oldValue, newValue in
                            TTSManager.shared.stop()
                            if !autoSlideManager.isAutoSliding {
                                HapticManager.shared.impact(.light, intensity: StyleConstants.Haptic.maxIntensity)
                            }
                            // 마지막 카드 위치 저장
                            saveLastCardIndex()
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
                
                // Bottom Controls
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        // Previous Button
                        Button(action: previousCard) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected.opacity(0.6), dark: .tabBarSelectedDark.opacity(0.6), for: colorScheme))
                                .frame(width: StyleConstants.Button.navigationSize, height: StyleConstants.Button.navigationSize)
                        }
                        .offset(x: 10)
                        .accessibilityLabel("이전 카드")
                        .accessibilityHint("이전 카드로 이동합니다. 길게 누르면 자동으로 넘깁니다.")
                        .scaleEffect(autoSlideManager.isAutoSliding ? 0.95 : 1.0)
                        .onLongPressGesture(minimumDuration: StyleConstants.Animation.standardDuration, perform: {}, onPressingChanged: { pressing in
                            if pressing {
                                startAutoSlide(direction: .previous)
                            } else {
                                autoSlideManager.stopAutoSlide()
                            }
                        })
                        
                        // View Mode Toggle
                        Button(action: toggleViewMode) {
                            Text(viewMode.rawValue)
                                .font(StyleConstants.Typography.koreanDynamic(.footnote))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                .frame(width: 80)
                        }
                        .accessibilityLabel("보기 모드: \(viewMode.rawValue)")
                        .accessibilityHint("탭하여 보기 모드를 변경합니다")
                        
                        // Next Button
                        Button(action: nextCard) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected.opacity(0.6), dark: .tabBarSelectedDark.opacity(0.6), for: colorScheme))
                                .frame(width: StyleConstants.Button.navigationSize, height: StyleConstants.Button.navigationSize)
                        }
                        .offset(x: -10)
                        .accessibilityLabel("다음 카드")
                        .accessibilityHint("다음 카드로 이동합니다. 길게 누르면 자동으로 넘깁니다.")
                        .scaleEffect(autoSlideManager.isAutoSliding ? 0.95 : 1.0)
                        .onLongPressGesture(minimumDuration: StyleConstants.Animation.standardDuration, perform: {}, onPressingChanged: { pressing in
                            if pressing {
                                startAutoSlide(direction: .next)
                            } else {
                                autoSlideManager.stopAutoSlide()
                            }
                        })
                    }
                }
                .padding(.bottom, 45)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .onAppear {
            loadLastCardIndex()
            TTSManager.shared.stop()
            // Cards loaded
        }
        .onDisappear {
            autoSlideManager.stopAutoSlide()
            TTSManager.shared.stop()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ScrollToCard"))) { notification in
            if let cardNumber = notification.userInfo?["cardNumber"] as? Int {
                // Switch to sequential mode if in random mode
                if viewMode != .sequential {
                    viewMode = .sequential
                    randomizedPhrases = []
                }
                
                // Find the index of the card
                if let index = displayPhrases.firstIndex(where: { $0.id == cardNumber }) {
                    withAnimation(.spring(
                        response: StyleConstants.Animation.springResponse,
                        dampingFraction: 0.85,
                        blendDuration: StyleConstants.Animation.snappyDuration
                    )) {
                        currentIndex = index
                    }
                    
                    // Save the position
                    saveLastCardIndex()
                    
                    // Haptic feedback
                    HapticManager.shared.impact(.medium, intensity: 0.8)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func nextCard() {
        guard currentIndex < displayPhrases.count - 1 else { 
            if !autoSlideManager.isAutoSliding {
                autoSlideManager.shakeCard()
            }
            return 
        }
        withAnimation(.spring(
            response: StyleConstants.Animation.springResponse,
            dampingFraction: 0.85,
            blendDuration: StyleConstants.Animation.snappyDuration
        )) {
            currentIndex += 1
        }
    }
    
    private func previousCard() {
        guard currentIndex > 0 else { 
            if !autoSlideManager.isAutoSliding {
                autoSlideManager.shakeCard()
            }
            return 
        }
        withAnimation(.spring(
            response: StyleConstants.Animation.springResponse,
            dampingFraction: 0.85,
            blendDuration: StyleConstants.Animation.snappyDuration
        )) {
            currentIndex -= 1
        }
    }
    
    private func startAutoSlide(direction: AutoSlideManager.SlideDirection) {
        autoSlideManager.startAutoSlide(
            direction: direction,
            currentIndex: currentIndex,
            maxIndex: displayPhrases.count - 1
        ) { slideDirection in
            switch slideDirection {
            case .next:
                nextCard()
            case .previous:
                previousCard()
            }
        }
    }
    
    private func changeViewMode(to mode: ViewMode) {
        viewMode = mode
        currentIndex = 0
        
        if mode == .random {
            randomizedPhrases = phrases.shuffled()
        }
        
        HapticManager.shared.impact(.light, intensity: StyleConstants.Haptic.maxIntensity)
    }
    
    private func toggleViewMode() {
        let allModes = ViewMode.allCases
        if let currentModeIndex = allModes.firstIndex(of: viewMode) {
            let nextIndex = (currentModeIndex + 1) % allModes.count
            changeViewMode(to: allModes[nextIndex])
        }
    }

    private func resetCurrentIndex() {
        currentIndex = 0
        if !phrases.isEmpty {
            randomizedPhrases = phrases.shuffled()
        }
    }
    
    // MARK: - Session Management
    private func loadLastCardIndex() {
        // 먼저 랜덤 배열 초기화
        if !phrases.isEmpty {
            randomizedPhrases = phrases.shuffled()
        }
        
        // 저장된 카드 인덱스 불러오기 (순서대로 모드에서만)
        if viewMode == .sequential {
            let savedIndex = UserDefaults.standard.integer(forKey: lastCardIndexKey)
            if savedIndex > 0 && savedIndex < phrases.count {
                currentIndex = savedIndex
                // Last card position restored
            } else {
                currentIndex = 0
            }
        } else {
            currentIndex = 0
        }
    }
    
    private func saveLastCardIndex() {
        // 마지막 카드 위치 저장
        UserDefaults.standard.set(currentIndex, forKey: lastCardIndexKey)
    }
} 