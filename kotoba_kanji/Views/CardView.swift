import SwiftUI
import SwiftData

// MARK: - Card View
struct CardView: View {
    let phrase: JapanesePhrase
    let isInModal: Bool
    @State private var isFlipped = false
    @State private var rotationAngle: Double = 0
    
    init(phrase: JapanesePhrase, isInModal: Bool = false) {
        self.phrase = phrase
        self.isInModal = isInModal
    }
    
    var body: some View {
        ZStack {
            if !isFlipped {
                frontView
                    .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                    .opacity(rotationAngle > 90 ? 0 : 1)
            } else {
                backView
                    .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
                    .opacity(rotationAngle < 90 ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: StyleConstants.Card.height)
        .padding(.horizontal, StyleConstants.Card.horizontalPadding)
        .padding(.top, 30)
        .padding(.bottom, StyleConstants.Card.bottomPadding)
    }
    
    // MARK: - Private Views
    private var frontView: some View {
        CardFrontView(
            phrase: phrase,
            isInModal: isInModal,
            onFlipCard: flipCard
        )
    }
    
    private var backView: some View {
        CardBackView(
            phrase: phrase,
            onFlipCard: flipCard
        )
    }
    
    // MARK: - Private Methods
    private func flipCard() {
        TTSManager.shared.stop()
        
        withAnimation(.easeInOut(duration: StyleConstants.Animation.cardFlipDuration)) {
            if isFlipped {
                rotationAngle = 0
            } else {
                rotationAngle = 180
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (StyleConstants.Animation.cardFlipDuration / 2)) {
            isFlipped.toggle()
        }
        
        HapticManager.shared.impact(.light)
    }
}

// MARK: - Card Placeholder
struct CardPlaceholderView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: StyleConstants.Card.cornerRadius)
            .fill(StyleConstants.Colors.buttonBackground)
            .frame(height: StyleConstants.Card.height)
            .overlay(
                Text("카드를 불러오는 중...")
                    .font(.system(size: StyleConstants.Spacing.large, weight: .regular))
                    .foregroundColor(StyleConstants.Colors.textSecondary)
            )
            .padding(.horizontal, StyleConstants.Card.horizontalPadding)
            .padding(.vertical, StyleConstants.Card.bottomPadding)
    }
} 