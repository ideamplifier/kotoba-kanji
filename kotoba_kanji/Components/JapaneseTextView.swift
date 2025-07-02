import SwiftUI

// MARK: - Japanese Text View
struct JapaneseTextView: View {
    let phrase: JapanesePhrase
    @ObservedObject private var ttsManager = TTSManager.shared
    
    var body: some View {
        VStack(spacing: StyleConstants.Spacing.small) {
            highlightedJapaneseText
                .font(.system(size: StyleConstants.Typography.japaneseMainSize, weight: .medium))
                .minimumScaleFactor(StyleConstants.Typography.minimumScaleFactor)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, minHeight: 32)
            
            hiraganaText
                .font(.system(size: StyleConstants.Typography.japaneseSubSize, weight: .regular))
                .minimumScaleFactor(0.7)
                .lineLimit(2)
                .foregroundColor(StyleConstants.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Private Views
    private var hiraganaText: some View {
        Text(phrase.hiragana)
    }
    
    private var highlightedJapaneseText: Text {
        if ttsManager.currentSpeakingText == phrase.japaneseSentence && 
           ttsManager.isSpeaking,
           let speakingRange = ttsManager.currentSpeakingRange {
            return createSpeakingHighlightText(speakingRange: speakingRange)
        }
        
        return Text(phrase.japaneseSentence).foregroundColor(Color.naturalTextColor.opacity(0.90))
    }
    
    // MARK: - Private Methods
    private func createSpeakingHighlightText(speakingRange: NSRange) -> Text {
        let text = phrase.japaneseSentence
        let nsString = NSString(string: text)
        let textLength = nsString.length
        
        guard speakingRange.location >= 0 && 
              speakingRange.location + speakingRange.length <= textLength else {
            return Text(phrase.japaneseSentence).foregroundColor(Color.naturalTextColor.opacity(0.90))
        }
        
        var result = Text("")
        
        // Before current word
        if speakingRange.location > 0 {
            let beforeRange = NSRange(location: 0, length: speakingRange.location)
            let beforeText = nsString.substring(with: beforeRange)
            result = result + Text(beforeText).foregroundColor(Color.naturalTextColor.opacity(0.90))
        }
        
        // Current word (highlighted)
        let speakingText = nsString.substring(with: speakingRange)
        result = result + Text(speakingText).foregroundColor(StyleConstants.Colors.speakerActive)
        
        // After current word
        let afterStart = speakingRange.location + speakingRange.length
        if afterStart < textLength {
            let afterRange = NSRange(location: afterStart, length: textLength - afterStart)
            let afterText = nsString.substring(with: afterRange)
            result = result + Text(afterText).foregroundColor(Color.naturalTextColor.opacity(0.90))
        }
        
        return result
    }
} 