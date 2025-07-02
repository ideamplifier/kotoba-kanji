import SwiftUI

// MARK: - Card Back View
struct CardBackView: View {
    let phrase: JapanesePhrase
    let onFlipCard: () -> Void
    
    var body: some View {
        VStack(spacing: StyleConstants.Spacing.large) {
            if let conversation = ConversationManager.shared.getConversationScenario(for: phrase.id) {
                conversationContent(conversation)
            } else {
                emptyStateView
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, StyleConstants.Card.verticalPadding)
        .padding(.bottom, 40)
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
            onFlipCard()
        }
    }
    
    // MARK: - Private Views
    private func conversationContent(_ conversation: [ConversationData]) -> some View {
        ScrollView {
            VStack(spacing: StyleConstants.Spacing.large) {
                ForEach(Array(conversation.enumerated()), id: \.offset) { index, line in
                    ConversationBubbleView(line: line)
                }
            }
            .padding(.horizontal, StyleConstants.Spacing.small)
            .padding(.top, 0)       // 상단 여백 제거
            .padding(.bottom, 40)   // 하단 여백 (카드 뒤집기 영역 확보)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: StyleConstants.Spacing.large) {
            Text("💬")
                .font(.system(size: 48))
            
            Text("대화 시나리오 준비 중")
                .font(StyleConstants.Typography.koreanDynamic(.title3))
                .foregroundColor(StyleConstants.Colors.textSecondary)
            
            Text("더 많은 대화가 곧 추가될 예정입니다!")
                .font(StyleConstants.Typography.koreanDynamic(.body))
                .foregroundColor(StyleConstants.Colors.textTertiary)
                .multilineTextAlignment(.center)
        }
    }
} 