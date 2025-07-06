import SwiftUI
import SwiftData

// MARK: - Home View
struct HomeView: View {
    @Query private var kanjiList: [Kanji]
    @State private var currentKanjiIndex = 0
    @State private var navigateToKanji: Int?
    @State private var isRandomMode = false
    @AppStorage("lastViewedKanjiIndex") private var lastViewedKanjiIndex = 0
    @AppStorage("isKanjiRandomMode") private var savedRandomMode = false
    @Environment(\.colorScheme) private var colorScheme
    
    private let autoSlideManager = AutoSlideManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                // Content
                if kanjiList.isEmpty {
                    emptyStateView
                } else {
                    kanjiContentView
                }
            }
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
            .navigationBarHidden(true)
            .onAppear {
                loadSettings()
            }
            .onDisappear {
                saveSettings()
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ScrollToKanji"))) { notification in
                if let kanjiId = notification.userInfo?["kanjiId"] as? Int {
                    scrollToKanji(kanjiId)
                }
            }
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("한자 학습")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                
                if !kanjiList.isEmpty {
                    Text("\(currentKanjiIndex + 1) / \(kanjiList.count)")
                        .font(.system(size: 14))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                }
            }
            
            Spacer()
            
            // Shuffle Button
            Button(action: toggleRandomMode) {
                Image(systemName: isRandomMode ? "shuffle.circle.fill" : "shuffle.circle")
                    .font(.system(size: 24))
                    .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                    .animation(.easeInOut(duration: 0.2), value: isRandomMode)
            }
            .accessibilityLabel(isRandomMode ? "랜덤 모드 켜짐" : "랜덤 모드 꺼짐")
            .accessibilityHint("탭하여 랜덤 모드 전환")
        }
        .frame(height: 44)
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.safeAreaInsets.top ?? 0)
    }
    
    // MARK: - Empty State View
    private var emptyStateView: some View {
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
    }
    
    // MARK: - Kanji Content View
    private var kanjiContentView: some View {
        VStack(spacing: 0) {
            // Kanji Cards
            GeometryReader { geometry in
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(Array(kanjiList.enumerated()), id: \.element.id) { index, kanji in
                                KanjiCardView(kanji: kanji)
                                    .frame(width: geometry.size.width)
                                    .id(index)
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .onChange(of: currentKanjiIndex) { oldValue, newValue in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            scrollProxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                    .onChange(of: navigateToKanji) { oldValue, newValue in
                        if let kanjiId = newValue,
                           let index = kanjiList.firstIndex(where: { $0.id == kanjiId }) {
                            currentKanjiIndex = index
                            navigateToKanji = nil
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            
            // Navigation Controls
            navigationControls
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
        }
    }
    
    // MARK: - Navigation Controls
    private var navigationControls: some View {
        HStack(spacing: 30) {
            // Previous Button
            Button(action: previousKanji) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("이전")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(currentKanjiIndex > 0 ? StyleConstants.Colors.adaptiveTextPrimary(colorScheme) : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .frame(width: 100, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                )
                .opacity(currentKanjiIndex > 0 ? 1.0 : 0.5)
            }
            .disabled(currentKanjiIndex == 0)
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        autoSlideManager.startAutoSlide(
                            direction: .previous,
                            currentIndex: currentKanjiIndex,
                            maxIndex: kanjiList.count - 1
                        ) { slideDirection in
                            switch slideDirection {
                            case .previous:
                                previousKanji()
                            case .next:
                                break
                            }
                        }
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        autoSlideManager.stopAutoSlide()
                    }
            )
            
            Spacer()
            
            // Next Button
            Button(action: nextKanji) {
                HStack(spacing: 8) {
                    Text("다음")
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(currentKanjiIndex < kanjiList.count - 1 ? StyleConstants.Colors.adaptiveTextPrimary(colorScheme) : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .frame(width: 100, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                )
                .opacity(currentKanjiIndex < kanjiList.count - 1 ? 1.0 : 0.5)
            }
            .disabled(currentKanjiIndex == kanjiList.count - 1)
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        autoSlideManager.startAutoSlide(
                            direction: .next,
                            currentIndex: currentKanjiIndex,
                            maxIndex: kanjiList.count - 1
                        ) { slideDirection in
                            switch slideDirection {
                            case .next:
                                nextKanji()
                            case .previous:
                                break
                            }
                        }
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        autoSlideManager.stopAutoSlide()
                    }
            )
        }
    }
    
    // MARK: - Helper Methods
    private func previousKanji() {
        HapticManager.shared.impact(.light, intensity: 0.6)
        if isRandomMode {
            var newIndex: Int
            repeat {
                newIndex = Int.random(in: 0..<kanjiList.count)
            } while newIndex == currentKanjiIndex && kanjiList.count > 1
            currentKanjiIndex = newIndex
        } else if currentKanjiIndex > 0 {
            currentKanjiIndex -= 1
        }
    }
    
    private func nextKanji() {
        HapticManager.shared.impact(.light, intensity: 0.6)
        if isRandomMode {
            var newIndex: Int
            repeat {
                newIndex = Int.random(in: 0..<kanjiList.count)
            } while newIndex == currentKanjiIndex && kanjiList.count > 1
            currentKanjiIndex = newIndex
        } else if currentKanjiIndex < kanjiList.count - 1 {
            currentKanjiIndex += 1
        }
    }
    
    private func toggleRandomMode() {
        isRandomMode.toggle()
        HapticManager.shared.impact(.medium, intensity: 0.7)
        savedRandomMode = isRandomMode
    }
    
    private func scrollToKanji(_ kanjiId: Int) {
        if let index = kanjiList.firstIndex(where: { $0.id == kanjiId }) {
            currentKanjiIndex = index
            HapticManager.shared.notification(.success)
        }
    }
    
    // MARK: - Settings Management
    private func loadSettings() {
        isRandomMode = savedRandomMode
        
        if !isRandomMode {
            let savedIndex = lastViewedKanjiIndex
            if savedIndex >= 0 && savedIndex < kanjiList.count {
                currentKanjiIndex = savedIndex
            }
        }
    }
    
    private func saveSettings() {
        savedRandomMode = isRandomMode
        if !isRandomMode {
            lastViewedKanjiIndex = currentKanjiIndex
        }
    }
}