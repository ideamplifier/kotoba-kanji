import SwiftUI
import AVFoundation

// MARK: - Settings View
struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedVoice = UserDefaults.standard.string(forKey: "selectedJapaneseVoice") ?? "Hattori"
    @State private var availableVoices: [(String, String, String)] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header with App Info
                VStack(spacing: 12) {
                    Image("splash_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .accessibilityLabel("코토바 칸지 로고")
                    
                    VStack(spacing: 4) {
                        Text("KOTOBA KANJI")
                            .font(StyleConstants.Typography.title2)
                            .fontWeight(.bold)
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                            .accessibilityLabel("코토바 칸지")
                        
                        Text("버전 1.0.0")
                            .font(StyleConstants.Typography.subheadline)
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                
                // Voice Selection Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("음성 선택")
                        .font(StyleConstants.Typography.title2)
                        .fontWeight(.bold)
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 8) {
                        ForEach(Array(availableVoices.enumerated()), id: \.offset) { index, voice in
                            let (name, gender, quality) = voice
                            let isAvailable = quality != "다운로드 필요"
                            
                            VoiceSelectionRow(
                                name: name,
                                gender: gender,
                                quality: quality,
                                isSelected: selectedVoice == name,
                                isAvailable: isAvailable,
                                onSelect: {
                                    if isAvailable {
                                        selectedVoice = name
                                        UserDefaults.standard.set(name, forKey: "selectedJapaneseVoice")
                                        HapticManager.shared.impact(.light, intensity: 0.6)
                                        // Voice selected
                                    }
                                }
                            )
                        }
                    }
                    
                    // Voice Instructions
                    VStack(alignment: .leading, spacing: 8) {
                        Text("✓ 표시가 있는 음성은 고품질로 다운로드되어 있습니다.")
                            .font(StyleConstants.Typography.caption)
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        
                        Button(action: {
                            // Open Accessibility > Spoken Content > Voices settings
                            if let url = URL(string: "App-prefs:root=General&path=ACCESSIBILITY/SPEECH") {
                                UIApplication.shared.open(url) { success in
                                    if !success {
                                        // Fallback to general accessibility settings
                                        if let fallbackUrl = URL(string: "App-prefs:root=General&path=ACCESSIBILITY") {
                                            UIApplication.shared.open(fallbackUrl)
                                        }
                                    }
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "gear")
                                    .font(.system(size: 12))
                                Text("음성 다운로드 설정으로 이동")
                                    .font(StyleConstants.Typography.caption)
                            }
                            .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .onAppear {
            loadAvailableVoices()
            validateSelectedVoice()
            debugVoiceInfo()
        }
    }
    
    private func loadAvailableVoices() {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let japaneseVoices = allVoices.filter { $0.language.hasPrefix("ja") }
        
        // Define base voices with their gender
        let baseVoices = [
            ("Hattori", "남성"),
            ("Otoya", "남성"),
            ("O-ren", "여성"),
            ("Kyoko", "여성")
        ]
        
        availableVoices = baseVoices.map { (name, gender) in
            // Check if enhanced version exists
            let hasEnhanced = japaneseVoices.contains { voice in
                voice.name.contains(name) && voice.quality == .enhanced
            }
            
            // Check if any version exists
            let hasAnyVersion = japaneseVoices.contains { voice in
                voice.name.contains(name)
            }
            
            let quality: String
            if hasEnhanced {
                quality = "고품질 다운로드됨 ✓"
            } else if hasAnyVersion {
                quality = "기본 음성"
            } else {
                quality = "다운로드 필요"
            }
            
            return (name, gender, quality)
        }
        
        // Voice status updated
    }
    
    private func validateSelectedVoice() {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let japaneseVoices = allVoices.filter { $0.language.hasPrefix("ja") }
        
        // Check if currently selected voice is available
        let hasSelectedVoice = japaneseVoices.contains { voice in
            voice.name.contains(selectedVoice)
        }
        
        if !hasSelectedVoice {
            // Find the first available voice
            let defaultVoices = ["Hattori", "O-ren", "Kyoko", "Otoya"]
            for voiceName in defaultVoices {
                if japaneseVoices.contains(where: { $0.name.contains(voiceName) }) {
                    selectedVoice = voiceName
                    UserDefaults.standard.set(voiceName, forKey: "selectedJapaneseVoice")
                    break
                }
            }
        }
    }
    
    private func debugVoiceInfo() {
        let currentSelection = UserDefaults.standard.string(forKey: "selectedJapaneseVoice") ?? "Hattori"
        // Current voice selection
        
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        let japaneseVoices = allVoices.filter { $0.language.hasPrefix("ja") }
        
        // Available Japanese voices checked
        
        let hattoriVoices = japaneseVoices.filter { $0.name.contains("Hattori") }
        // Hattori voices checked
    }
}

// MARK: - Voice Selection Row
struct VoiceSelectionRow: View {
    let name: String
    let gender: String
    let quality: String
    let isSelected: Bool
    let isAvailable: Bool
    let onSelect: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(name)
                            .font(StyleConstants.Typography.body)
                            .fontWeight(.medium)
                            .foregroundColor(isAvailable ? StyleConstants.Colors.adaptiveTextPrimary(colorScheme) : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        
                        Text("(\(gender))")
                            .font(StyleConstants.Typography.caption)
                            .foregroundColor(isAvailable ? StyleConstants.Colors.adaptiveTextSecondary(colorScheme) : StyleConstants.Colors.adaptiveTextSecondary(colorScheme).opacity(0.8))
                        
                        Spacer()
                    }
                    
                    Text(quality)
                        .font(StyleConstants.Typography.caption)
                        .foregroundColor(isAvailable ? StyleConstants.Colors.adaptiveTextSecondary(colorScheme) : StyleConstants.Colors.adaptiveTextSecondary(colorScheme).opacity(0.7))
                }
                
                if isSelected && isAvailable {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(hex: "2e4a8b"))
                        .font(.system(size: 18))
                } else if !isAvailable {
                    Image(systemName: "arrow.down.circle")
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme).opacity(0.6))
                        .font(.system(size: 18))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected && isAvailable ? StyleConstants.Colors.adaptiveButtonBackground(colorScheme) : Color.clear)
            .cornerRadius(12)
            .contentShape(Rectangle())
            .opacity(isAvailable ? 1.0 : 0.7)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isAvailable)
        .accessibilityLabel("\(name) \(gender) \(quality)")
        .accessibilityHint(isAvailable ? (isSelected ? "현재 선택됨" : "탭하여 이 음성을 선택합니다") : "다운로드가 필요합니다")
        .accessibilityAddTraits(isSelected && isAvailable ? [.isSelected] : [])
    }
} 