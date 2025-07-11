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

// MARK: - Kanji Front View (앞면)
struct KanjiFrontView: View {
    let kanji: Kanji
    let examples: [KanjiExample]
    let geometry: GeometryProxy
    @Environment(\.colorScheme) private var colorScheme
    @State private var isFavoriteAnimating = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with card number and bookmark
            HStack {
                Text("\(kanji.id)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme).opacity(0.5))
                
                Spacer()
                
                Button(action: toggleFavorite) {
                    Image(systemName: kanji.isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 20))
                        .foregroundColor(kanji.isFavorite ? Color.yellow : StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .scaleEffect(isFavoriteAnimating ? 1.2 : 1.0)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer(minLength: 30)
            
            // Main Kanji Character - 10% 작게
            Text(kanji.character)
                .font(.system(size: min(geometry.size.width * 0.32, 126), weight: .medium))
                .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
            
            // Korean meaning
            if let firstMeaning = kanji.meanings.first {
                Text("(\(firstMeaning))")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    .padding(.top, 12)
            }
            
            Spacer(minLength: 30)
            
            // Readings and Info Section - 공간 효율적으로
            VStack(alignment: .leading, spacing: 16) {
                // 음독 (音読み)
                if !kanji.onyomi.isEmpty {
                    HStack(alignment: .top, spacing: 12) {
                        Text("음독:")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            .frame(width: 50, alignment: .leading)
                        
                        HStack(spacing: 8) {
                            ForEach(kanji.onyomi, id: \.self) { reading in
                                Text(reading)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                    .underline()
                                    .onTapGesture {
                                        TTSManager.shared.speak(reading)
                                        HapticManager.shared.impact(.light)
                                    }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                // 훈독 (訓読み)
                if !kanji.kunyomi.isEmpty {
                    HStack(alignment: .top, spacing: 12) {
                        Text("훈독:")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            .frame(width: 50, alignment: .leading)
                        
                        HStack(spacing: 8) {
                            ForEach(kanji.kunyomi, id: \.self) { reading in
                                Text(reading)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color.purple)
                                    .underline()
                                    .onTapGesture {
                                        TTSManager.shared.speak(reading)
                                        HapticManager.shared.impact(.light)
                                    }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                // 부수 정보
                HStack(alignment: .top, spacing: 12) {
                    Text("부수:")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .frame(width: 50, alignment: .leading)
                    
                    Text("\(kanji.bushu) (\(kanji.bushuMeaning))")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                }
            }
            .padding(.horizontal, 40)
            
            Spacer(minLength: 20)
            
            // 이미지 기억법
            VStack(alignment: .leading, spacing: 8) {
                Text("기억법:")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                
                Text(kanji.mnemonic)
                    .font(.system(size: 15))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            // 탭 안내
            Text("음독/훈독을 탭하면 발음을 들을 수 있습니다")
                .font(.system(size: 12))
                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                .opacity(0.6)
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

// MARK: - Kanji Back View (뒷면)
struct KanjiBackView: View {
    let kanji: Kanji
    let examples: [KanjiExample]
    let geometry: GeometryProxy
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("\(kanji.character)")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                
                if let firstMeaning = kanji.meanings.first {
                    Text("- \(firstMeaning)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            // 포함 문장 타이틀
            HStack {
                Text("포함 문장")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
            
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(Array(examples.enumerated()), id: \.offset) { index, example in
                        VStack(alignment: .leading, spacing: 12) {
                            // Example number
                            Text("\(index + 1).")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                            
                            // Japanese sentence with play button
                            HStack(alignment: .top, spacing: 12) {
                                VStack(alignment: .leading, spacing: 8) {
                                    // Japanese
                                    Text(example.japanese)
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                                    
                                    // Korean translation
                                    Text("(\(example.korean))")
                                        .font(.system(size: 16))
                                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                                    
                                    // Hiragana reading
                                    Text(example.hiragana)
                                        .font(.system(size: 15))
                                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                    
                                    // Romaji with Korean pronunciation
                                    HStack(spacing: 4) {
                                        Text("(\(example.romaji))")
                                            .font(.system(size: 14))
                                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                            .italic()
                                        
                                        Text("/ \(example.koreanPronunciation)")
                                            .font(.system(size: 14))
                                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                                    }
                                }
                                
                                Spacer()
                                
                                // Play button
                                Button(action: {
                                    TTSManager.shared.speak(example.japanese)
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                        .frame(width: 36, height: 36)
                                        .background(
                                            Circle()
                                                .fill(Color.adaptive(light: .tabBarSelected.opacity(0.1), dark: .tabBarSelectedDark.opacity(0.1), for: colorScheme))
                                        )
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            
            Spacer(minLength: 20)
        }
    }
}