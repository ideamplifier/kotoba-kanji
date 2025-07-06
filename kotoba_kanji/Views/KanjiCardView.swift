import SwiftUI
import SwiftData

struct KanjiCardView: View {
    let kanji: Kanji
    @State private var isFlipped = false
    @State private var rotation: Double = 0
    @Environment(\.modelContext) private var modelContext
    @Query private var examples: [KanjiExample]
    @Environment(\.colorScheme) private var colorScheme
    
    private var kanjiExamples: [KanjiExample] {
        examples.filter { $0.kanjiId == kanji.id }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 20)
                    .fill(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
                    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 5)
                
                // Front side
                KanjiFrontView(kanji: kanji, examples: kanjiExamples, geometry: geometry)
                    .opacity(rotation.truncatingRemainder(dividingBy: 360) < 90 || rotation.truncatingRemainder(dividingBy: 360) > 270 ? 1 : 0)
                    .rotation3DEffect(
                        Angle(degrees: rotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                // Back side
                KanjiBackView(kanji: kanji, examples: kanjiExamples, geometry: geometry)
                    .opacity(rotation.truncatingRemainder(dividingBy: 360) > 90 && rotation.truncatingRemainder(dividingBy: 360) < 270 ? 1 : 0)
                    .rotation3DEffect(
                        Angle(degrees: rotation + 180),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                flipCard()
            }
        }
    }
    
    private func flipCard() {
        HapticManager.shared.impact(.medium, intensity: 0.7)
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            rotation += 180
            isFlipped.toggle()
        }
    }
}

// MARK: - Kanji Front View
struct KanjiFrontView: View {
    let kanji: Kanji
    let examples: [KanjiExample]
    let geometry: GeometryProxy
    @Environment(\.colorScheme) private var colorScheme
    @State private var isFavoriteAnimating = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with card number
            HStack {
                Spacer()
                Text("\(kanji.id)")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme).opacity(0.5))
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer(minLength: 20)
            
            // Main Content
            VStack(spacing: 20) {
                // Japanese phrase or kanji usage
                Text(kanji.meanings.first ?? kanji.character)
                    .font(.system(size: 32, weight: .regular))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    .multilineTextAlignment(.center)
                
                // Hiragana reading
                if let firstReading = kanji.kunyomi.first ?? kanji.onyomi.first {
                    Text(firstReading)
                        .font(.system(size: 24))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                }
                
                Divider()
                    .frame(width: 60)
                    .padding(.vertical, 8)
                
                // Korean meaning/explanation
                VStack(spacing: 12) {
                    Text("실례하겠습니다. / 먼저 들어가 보겠습니다.")
                        .font(.system(size: 18))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .multilineTextAlignment(.center)
                    
                    // Romaji
                    Text("Shitsurei shimasu")
                        .font(.system(size: 16))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .italic()
                }
                .padding(.horizontal, 32)
            }
            
            Spacer(minLength: 40)
            
            // Long explanation text
            Text(kanji.mnemonic)
                .font(.system(size: 15))
                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.horizontal, 32)
                .lineLimit(6)
            
            Spacer()
            
            // Bottom buttons
            HStack {
                // Play audio button
                Button(action: {
                    if let reading = kanji.kunyomi.first ?? kanji.onyomi.first {
                        TTSManager.shared.speak(reading)
                    }
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.adaptive(light: .tabBarSelected.opacity(0.1), dark: .tabBarSelectedDark.opacity(0.1), for: colorScheme))
                        )
                }
                
                Spacer()
                
                // Bookmark button
                Button(action: toggleFavorite) {
                    Image(systemName: kanji.isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 22))
                        .foregroundColor(kanji.isFavorite ? Color.yellow : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .scaleEffect(isFavoriteAnimating ? 1.2 : 1.0)
                        .frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
    
    private func toggleFavorite() {
        HapticManager.shared.impact(.medium)
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            kanji.isFavorite.toggle()
            isFavoriteAnimating = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isFavoriteAnimating = false
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save favorite status: \(error)")
        }
    }
}

// MARK: - Kanji Back View
struct KanjiBackView: View {
    let kanji: Kanji
    let examples: [KanjiExample]
    let geometry: GeometryProxy
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("\(kanji.character) - 기억법과 예문")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Mnemonic
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb")
                                .font(.system(size: 16))
                                .foregroundColor(Color.orange)
                            Text("이미지 기억법")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        }
                        
                        Text(kanji.mnemonic)
                            .font(.system(size: 15))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                            .lineSpacing(4)
                            .padding(.horizontal, 4)
                    }
                    .padding(.horizontal, 20)
                    
                    // Example Sentences
                    if !examples.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 6) {
                                Image(systemName: "text.quote")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                Text("예문")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                            }
                            .padding(.horizontal, 20)
                            
                            ForEach(examples, id: \.id) { example in
                                VStack(alignment: .leading, spacing: 8) {
                                    // Japanese with play button
                                    HStack(alignment: .top, spacing: 8) {
                                        Button(action: {
                                            TTSManager.shared.speak(example.japanese)
                                        }) {
                                            Image(systemName: "speaker.wave.2.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                        }
                                        .accessibilityLabel("예문 듣기")
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(example.japanese)
                                                .font(.custom("NanumSquareRoundR", size: 16))
                                                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                                            
                                            Text(example.hiragana)
                                                .font(.system(size: 14))
                                                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                            
                                            Text(example.romaji)
                                                .font(.system(size: 13))
                                                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                                .italic()
                                        }
                                    }
                                    
                                    // Korean translation
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(example.korean)
                                            .font(.system(size: 15))
                                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                                        
                                        Text(example.koreanPronunciation)
                                            .font(.system(size: 13))
                                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                                )
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            
            // Flip hint
            Text("탭하여 앞면 보기")
                .font(.system(size: 12))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .opacity(0.6)
                .padding(.bottom, 20)
        }
    }
}