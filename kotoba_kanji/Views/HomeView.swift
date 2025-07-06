import SwiftUI
import SwiftData

// MARK: - Home View
struct HomeView: View {
    @Query private var kanjiList: [Kanji]
    @State private var currentKanjiIndex = 0
    @State private var isRandomMode = false
    @StateObject private var autoSlideManager = AutoSlideManager()
    @AppStorage("lastViewedKanjiIndex") private var lastViewedKanjiIndex = 0
    @AppStorage("isKanjiRandomMode") private var savedRandomMode = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                // Card Page View
                VStack {
                    if kanjiList.isEmpty {
                        CardPlaceholderView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal, 20)
                            .accessibilityLabel("한자가 없습니다")
                    } else {
                        TabView(selection: $currentKanjiIndex) {
                            ForEach(Array(kanjiList.enumerated()), id: \.offset) { index, kanji in
                                KanjiCardView(kanji: kanji)
                                    .tag(index)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .offset(x: autoSlideManager.shakeOffset)
                        .onChange(of: currentKanjiIndex) { oldValue, newValue in
                            if !autoSlideManager.isAutoSliding {
                                HapticManager.shared.impact(.light, intensity: 0.6)
                            }
                            // 마지막 카드 위치 저장
                            saveLastCardIndex()
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.vertical, 20)
                
                Spacer()
                
                // Bottom Controls (스크린샷과 동일한 스타일)
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        // Previous Button
                        Button(action: previousKanji) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected.opacity(0.6), dark: .tabBarSelectedDark.opacity(0.6), for: colorScheme))
                                .frame(width: 44, height: 44)
                        }
                        .offset(x: 10)
                        .accessibilityLabel("이전 카드")
                        .accessibilityHint("이전 한자로 이동")
                        .scaleEffect(autoSlideManager.isAutoSliding ? 0.95 : 1.0)
                        .onLongPressGesture(minimumDuration: 0.5, perform: {}, onPressingChanged: { pressing in
                            if pressing {
                                startAutoSlide(direction: .previous)
                            } else {
                                autoSlideManager.stopAutoSlide()
                            }
                        })
                        
                        // View Mode Toggle (순서대로)
                        Button(action: toggleViewMode) {
                            Text("순서대로")
                                .font(.system(size: 14))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                .frame(width: 80)
                        }
                        .accessibilityLabel("보기 모드: 순서대로")
                        .accessibilityHint("탭하여 보기 모드 전환")
                        
                        // Next Button  
                        Button(action: nextKanji) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected.opacity(0.6), dark: .tabBarSelectedDark.opacity(0.6), for: colorScheme))
                                .frame(width: 44, height: 44)
                        }
                        .offset(x: -10)
                        .accessibilityLabel("다음 카드")
                        .accessibilityHint("다음 한자로 이동")
                        .scaleEffect(autoSlideManager.isAutoSliding ? 0.95 : 1.0)
                        .onLongPressGesture(minimumDuration: 0.5, perform: {}, onPressingChanged: { pressing in
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
        }
        .onDisappear {
            autoSlideManager.stopAutoSlide()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ScrollToKanji"))) { notification in
            if let kanjiId = notification.userInfo?["kanjiId"] as? Int {
                // Switch to sequential mode if in random mode
                if isRandomMode {
                    isRandomMode = false
                }
                
                // Find the index of the kanji
                if let index = kanjiList.firstIndex(where: { $0.id == kanjiId }) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                        currentKanjiIndex = index
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
    private func nextKanji() {
        guard currentKanjiIndex < kanjiList.count - 1 else { 
            if !autoSlideManager.isAutoSliding {
                autoSlideManager.shakeCard()
            }
            return 
        }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
            currentKanjiIndex += 1
        }
    }
    
    private func previousKanji() {
        guard currentKanjiIndex > 0 else { 
            if !autoSlideManager.isAutoSliding {
                autoSlideManager.shakeCard()
            }
            return 
        }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
            currentKanjiIndex -= 1
        }
    }
    
    private func startAutoSlide(direction: AutoSlideManager.SlideDirection) {
        autoSlideManager.startAutoSlide(
            direction: direction,
            currentIndex: currentKanjiIndex,
            maxIndex: kanjiList.count - 1
        ) { slideDirection in
            switch slideDirection {
            case .next:
                nextKanji()
            case .previous:
                previousKanji()
            }
        }
    }
    
    private func toggleViewMode() {
        isRandomMode.toggle()
        HapticManager.shared.impact(.light, intensity: 0.6)
        savedRandomMode = isRandomMode
    }
    
    // MARK: - Session Management
    private func loadLastCardIndex() {
        // 저장된 모드 불러오기
        isRandomMode = savedRandomMode
        
        // 저장된 카드 인덱스 불러오기 (순서대로 모드에서만)
        if !isRandomMode {
            let savedIndex = lastViewedKanjiIndex
            if savedIndex > 0 && savedIndex < kanjiList.count {
                currentKanjiIndex = savedIndex
            } else {
                currentKanjiIndex = 0
            }
        } else {
            currentKanjiIndex = 0
        }
    }
    
    private func saveLastCardIndex() {
        // 마지막 카드 위치 저장
        lastViewedKanjiIndex = currentKanjiIndex
    }
}

// MARK: - Card Placeholder View
struct CardPlaceholderView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "character.textbox")
                .font(.system(size: 80))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .opacity(0.5)
            
            Text("한자가 없습니다")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
            
            Text("곧 한자가 추가될 예정입니다")
                .font(.system(size: 16))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .opacity(0.8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}