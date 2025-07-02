import SwiftUI

// MARK: - Conversation Bubble View
struct ConversationBubbleView: View {
    let line: ConversationData
    @StateObject private var ttsManager = TTSManager.shared
    
    var body: some View {
        HStack {
            if line.isUserLine {
                Spacer()
            }
            
            VStack(alignment: line.isUserLine ? .trailing : .leading, spacing: StyleConstants.Spacing.medium) {
                conversationContent
            }
            
            if !line.isUserLine {
                Spacer()
            }
        }
        .padding(.leading, line.isUserLine ? 10 : 0)   // 나의 대화창: 오른쪽으로 10픽셀
        .padding(.trailing, line.isUserLine ? 0 : 10)  // 상대방 대화창: 왼쪽으로 10픽셀
    }
    
    // MARK: - Private Views
    private var conversationContent: some View {
        VStack(alignment: line.isUserLine ? .trailing : .leading, spacing: StyleConstants.Spacing.tiny) {
            mainText
            romajiText
            translationText
        }
        .padding(.vertical, StyleConstants.Spacing.medium)
        .padding(.horizontal, StyleConstants.Spacing.large)
        .background(bubbleBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Button.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: StyleConstants.Button.cornerRadius)
                .stroke(
                    ttsManager.isSpeaking && ttsManager.currentSpeakingText == line.text 
                    ? Color.blue.opacity(0.5) 
                    : Color.clear, 
                    lineWidth: 2
                )
                .animation(.easeInOut(duration: 0.3), value: ttsManager.isSpeaking)
        )
        .onTapGesture {
            // 햅틱 피드백
            HapticManager.shared.impact(.light)
            
            // 일본어 텍스트를 TTS로 재생
            ttsManager.speak(line.text)
        }
    }
    
    private var mainText: some View {
        Text(line.text)
            .font(.system(size: StyleConstants.Typography.conversationMainSize, weight: .medium))
            .foregroundColor(mainTextColor)
    }
    

    

    
    private var romajiText: some View {
        Text(line.romaji)
            .font(.system(size: StyleConstants.Typography.conversationSubSize - 1, weight: .medium))
            .foregroundColor(romajiTextColor)
            .italic()
            .multilineTextAlignment(line.isUserLine ? .trailing : .leading)
    }
    
    private var translationText: some View {
        Text(line.translation)
            .font(.system(size: StyleConstants.Typography.conversationSubSize, weight: .regular))
            .foregroundColor(translationTextColor)
            .multilineTextAlignment(line.isUserLine ? .trailing : .leading)
    }
    
    // MARK: - Computed Properties
    private var bubbleBackgroundColor: Color {
        line.isUserLine ? StyleConstants.Colors.userBubble : StyleConstants.Colors.systemBubble
    }
    
    private var mainTextColor: Color {
        line.isUserLine ? .white.opacity(0.9) : Color.naturalTextColor.opacity(0.9)
    }
    
    private var romajiTextColor: Color {
        line.isUserLine ? .white.opacity(0.45) : .blue.opacity(0.9)
    }
    
    private var translationTextColor: Color {
        line.isUserLine ? .white.opacity(0.72) : StyleConstants.Colors.textSecondary.opacity(0.9)
    }
    

} 