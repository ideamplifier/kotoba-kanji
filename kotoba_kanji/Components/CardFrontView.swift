import SwiftUI
import SwiftData

// MARK: - Card Front View
struct CardFrontView: View {
    let phrase: JapanesePhrase
    let isInModal: Bool
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject private var ttsManager = TTSManager.shared
    
    let onFlipCard: () -> Void
    
    init(phrase: JapanesePhrase, isInModal: Bool = false, onFlipCard: @escaping () -> Void) {
        self.phrase = phrase
        self.isInModal = isInModal
        self.onFlipCard = onFlipCard
    }
    
    var body: some View {
        ZStack {
            cardContent
            cardNumber
        }
    }
    
    // MARK: - Private Views
    private var cardContent: some View {
        VStack(spacing: StyleConstants.Spacing.large) {
            japaneseSection
            koreanSection
            romajiSection
            grammarSection
            
            Spacer()
            
            bottomControls
        }
        .padding(.top, StyleConstants.Card.topPadding)
        .padding(StyleConstants.Card.verticalPadding)
        .background(
            ZStack {
                // 메인 카드 배경
                RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius)
                    .fill(StyleConstants.Colors.cardBackground)
                
                // 종이 텍스처 노이즈 효과
                RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.08),
                                Color.black.opacity(0.04),
                                Color.white.opacity(0.06),
                                Color.black.opacity(0.03),
                                Color.white.opacity(0.07)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blendMode(.overlay)
                
                // 미세한 점 패턴 (노이즈 시뮬레이션)
                Canvas { context, size in
                    for _ in 0..<Int(size.width * size.height / 400) {
                        let x = Double.random(in: 0...size.width)
                        let y = Double.random(in: 0...size.height)
                        let opacity = Double.random(in: 0.01...0.04)
                        let dotSize = Double.random(in: 0.4...1.0)
                        
                        context.fill(
                            Path(ellipseIn: CGRect(x: x, y: y, width: dotSize, height: dotSize)),
                            with: .color(.black.opacity(opacity))
                        )
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius))
                
                // 카드 두께감을 위한 미묘한 보더
                RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius)
                    .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius))
        // 여러 레이어 그림자로 깊이감 표현
        .shadow(color: Color.black.opacity(0.08), radius: 1, x: 0, y: 1)  // 근접 그림자
        .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 2)  // 중간 그림자
        .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 3) // 원거리 그림자
        .onTapGesture {
            // 대화가 있는 카드만 뒷면으로 전환
            if ConversationManager.shared.hasConversation(for: phrase.id) {
                onFlipCard()
            }
        }
    }
    
    private var japaneseSection: some View {
        VStack(spacing: StyleConstants.Spacing.large) {
            JapaneseTextView(phrase: phrase)
                .multilineTextAlignment(.center)
            
            divider
        }
    }
    
    private var koreanSection: some View {
        VStack(spacing: StyleConstants.Spacing.small) {
            Text(phrase.koreanSentence)
                .font(.system(size: StyleConstants.Typography.koreanMainSize, weight: .regular))
                .foregroundColor(Color.naturalTextColor.opacity(0.90))
                .multilineTextAlignment(.center)
            
            Text(phrase.koreanPronunciation)
                .font(.system(size: StyleConstants.Typography.koreanSubSize, weight: .regular))
                .foregroundColor(StyleConstants.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 15)
        }
        .padding(.top, 5)
    }
    
    private var romajiSection: some View {
        Text(phrase.romaji)
            .font(.system(size: StyleConstants.Typography.romajiSize, weight: .regular))
            .foregroundColor(StyleConstants.Colors.textTertiary)
            .multilineTextAlignment(.center)
            .padding(.top, -13)
    }
    
    private var grammarSection: some View {
        VStack(spacing: StyleConstants.Spacing.large) {
            divider
                .padding(.top, 14)
            
            Text(phrase.grammar)
                .font(.system(size: StyleConstants.Typography.grammarSize, weight: .regular))
                .lineSpacing(StyleConstants.Typography.lineSpacing)
                .foregroundColor(Color.naturalTextColor.opacity(0.90))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, StyleConstants.Spacing.small)
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(StyleConstants.Colors.dividerColor)
            .frame(height: 1)
            .frame(maxWidth: StyleConstants.Card.maxWidth)
    }
    
    private var bottomControls: some View {
        HStack(spacing: StyleConstants.Spacing.large) {
            ttsButton
            
            Spacer()
            
            bookmarkButton
        }
        .padding(.top, StyleConstants.Spacing.medium)
    }
    

    
    private var ttsButton: some View {
        ActionButton(
            icon: ttsManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.2",
            color: ttsManager.isSpeaking ? StyleConstants.Colors.speakerActive : StyleConstants.Colors.speakerInactive,
            action: speakJapanese
        )
    }
    
    private var bookmarkButton: some View {
        ActionButton(
            icon: phrase.isFavorite ? "bookmark.fill" : "bookmark",
            color: phrase.isFavorite ? StyleConstants.Colors.favoriteActive : StyleConstants.Colors.favoriteInactive,
            action: toggleFavorite
        )
    }
    
    private var cardNumber: some View {
        VStack {
            HStack {
                Spacer()
                if isInModal {
                    Button(action: {
                        // Navigate to main tab and specific card
                        NotificationCenter.default.post(
                            name: Notification.Name("NavigateToCard"),
                            object: nil,
                            userInfo: ["cardNumber": phrase.id]
                        )
                        HapticManager.shared.impact(.light)
                    }) {
                        HStack(spacing: 2) {
                            Text("\(phrase.id)")
                                .font(.system(size: StyleConstants.Card.numberFontSize, weight: .medium))
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        .opacity(0.7)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme).opacity(0.1))
                        )
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: -8, y: 8)
                } else {
                    Text("\(phrase.id)")
                        .font(.system(size: StyleConstants.Card.numberFontSize, weight: .medium))
                        .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        .opacity(0.7)
                        .offset(x: -8, y: 8)
                }
            }
            Spacer()
        }
        .padding(.top, 7)
        .padding(.trailing, 7)
    }
    
    // MARK: - Private Methods
    private func toggleFavorite() {
        withAnimation(.spring(
            response: StyleConstants.Animation.springResponse,
            dampingFraction: StyleConstants.Animation.springDampingFraction,
            blendDuration: StyleConstants.Animation.springBlendDuration
        )) {
            phrase.isFavorite.toggle()
        }
        
        // SwiftData 저장 강화
        DispatchQueue.main.async {
            do {
                try modelContext.save()
                // Favorite saved
            } catch {
                // Favorite save failed
                // 실패 시 원래 상태로 되돌리기
                phrase.isFavorite.toggle()
            }
        }
        
        HapticManager.shared.impact(.light, intensity: StyleConstants.Haptic.strongIntensity)
    }
    
    private func speakJapanese() {
        ttsManager.speak(phrase.japaneseSentence)
        HapticManager.shared.impact(.light, intensity: StyleConstants.Haptic.lightIntensity)
    }
}

// MARK: - Action Button Component
struct ActionButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    let onLongPress: (() -> Void)?
    
    @State private var isPressed = false
    
    init(icon: String, color: Color, action: @escaping () -> Void, onLongPress: (() -> Void)? = nil) {
        self.icon = icon
        self.color = color
        self.action = action
        self.onLongPress = onLongPress
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: StyleConstants.Button.iconSize, weight: .medium))
                .foregroundColor(color)
                .frame(
                    width: StyleConstants.Button.frameSize,
                    height: StyleConstants.Button.frameSize
                )
                .background(color.opacity(StyleConstants.Button.backgroundOpacity))
                .clipShape(Circle())
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(.spring(
            response: 0.3,
            dampingFraction: 0.6,
            blendDuration: 0.1
        ), value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: onLongPress ?? {}, onPressingChanged: { pressing in
            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                isPressed = pressing
            }
        })
    }
} 