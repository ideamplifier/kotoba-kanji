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
                RoundedRectangle(cornerRadius: 16)
                    .fill(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                
                // Content
                Group {
                    if !isFlipped {
                        KanjiFrontView(kanji: kanji, geometry: geometry)
                    } else {
                        KanjiBackView(kanji: kanji, examples: kanjiExamples, geometry: geometry)
                    }
                }
                .rotation3DEffect(
                    Angle(degrees: rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(abs(rotation).truncatingRemainder(dividingBy: 180) < 90 ? 1 : 0)
            }
            .frame(maxHeight: geometry.size.height * 0.8)
            .padding(.vertical, 20)
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
    let geometry: GeometryProxy
    @Environment(\.colorScheme) private var colorScheme
    @State private var isFavoriteAnimating = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with favorite button
            HStack {
                Spacer()
                Button(action: toggleFavorite) {
                    Image(systemName: kanji.isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor(kanji.isFavorite ? Color.yellow : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .scaleEffect(isFavoriteAnimating ? 1.2 : 1.0)
                }
                .accessibilityLabel(kanji.isFavorite ? "즐겨찾기 해제" : "즐겨찾기 추가")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Main Kanji Character
            Text(kanji.character)
                .font(.system(size: min(geometry.size.width * 0.35, 120), weight: .regular))
                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                .padding(.top, 20)
                .accessibilityLabel("한자: \(kanji.character)")
            
            // Meanings
            VStack(spacing: 8) {
                ForEach(kanji.meanings, id: \.self) { meaning in
                    Text(meaning)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                }
            }
            .padding(.top, 20)
            
            // Readings
            VStack(spacing: 16) {
                // Onyomi
                if !kanji.onyomi.isEmpty {
                    VStack(spacing: 4) {
                        Text("음독 (音読み)")
                            .font(.system(size: 14))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        
                        HStack(spacing: 12) {
                            ForEach(kanji.onyomi, id: \.self) { reading in
                                Button(action: {
                                    TTSManager.shared.speak(reading)
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "speaker.wave.2")
                                            .font(.system(size: 12))
                                        Text(reading)
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme).opacity(0.1))
                                    )
                                }
                                .accessibilityLabel("음독 \(reading) 듣기")
                            }
                        }
                    }
                }
                
                // Kunyomi
                if !kanji.kunyomi.isEmpty {
                    VStack(spacing: 4) {
                        Text("훈독 (訓読み)")
                            .font(.system(size: 14))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        
                        HStack(spacing: 12) {
                            ForEach(kanji.kunyomi, id: \.self) { reading in
                                Button(action: {
                                    TTSManager.shared.speak(reading)
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "speaker.wave.2")
                                            .font(.system(size: 12))
                                        Text(reading)
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .foregroundColor(Color.purple)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.purple.opacity(0.1))
                                    )
                                }
                                .accessibilityLabel("훈독 \(reading) 듣기")
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            // Info badges
            HStack(spacing: 16) {
                // Stroke count
                HStack(spacing: 4) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14))
                    Text("\(kanji.strokeCount)획")
                        .font(.system(size: 14))
                }
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                
                // JLPT Level
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                        .font(.system(size: 14))
                    Text("N\(kanji.jlptLevel)")
                        .font(.system(size: 14))
                }
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                
                // Bushu
                HStack(spacing: 4) {
                    Text("부수:")
                        .font(.system(size: 14))
                    Text("\(kanji.bushu) (\(kanji.bushuMeaning))")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Flip hint
            Text("탭하여 뒤집기")
                .font(.system(size: 12))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .opacity(0.6)
                .padding(.bottom, 20)
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