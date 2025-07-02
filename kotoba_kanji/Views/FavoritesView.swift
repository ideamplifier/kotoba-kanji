import SwiftUI
import SwiftData

// MARK: - Favorites View
struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query(filter: #Predicate<JapanesePhrase> { phrase in
        phrase.isFavorite == true
    }) private var favoritePhrases: [JapanesePhrase]
    @State private var selectedPhrase: JapanesePhrase?
    
    private var sortedFavoritePhrases: [JapanesePhrase] {
        favoritePhrases.sorted { $0.id < $1.id }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if sortedFavoritePhrases.isEmpty {
                    // Empty Favorites State
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image("favorites_empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .opacity(0.6)
                            .accessibilityLabel("빈 즐겨찾기 이미지")
                        
                        VStack(spacing: 8) {
                            Text("즐겨찾기가 비어있어요")
                                .font(StyleConstants.Typography.koreanDynamic(.headline, weight: .medium))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        }
                        
                        Spacer()
                    }
                } else {
                    // Favorites List View
                    ScrollView {
                        VStack(spacing: 5) {
                            ForEach(sortedFavoritePhrases.reversed(), id: \.id) { phrase in
                                FavoriteRowView(phrase: phrase) {
                                    selectedPhrase = phrase
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .sheet(item: $selectedPhrase) { phrase in
            FavoriteCardDetailView(
                phrase: phrase,
                allFavorites: sortedFavoritePhrases,
                isPresented: .constant(true)
            )
        }
        .onAppear {
            TTSManager.shared.stop()
            // Favorites loaded
        }
    }
}

// MARK: - Favorite Row View
struct FavoriteRowView: View {
    let phrase: JapanesePhrase
    let onTap: () -> Void
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Card Number
                Text("\(phrase.id)")
                    .font(StyleConstants.Typography.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.gray.opacity(0.8))
                    .clipShape(Circle())
                    .accessibilityLabel("카드 번호 \(phrase.id)")
                
                VStack(alignment: .leading, spacing: 3) {
                    // Japanese Text
                    Text(phrase.japaneseSentence)
                        .font(StyleConstants.Typography.callout.weight(.medium))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("일본어: \(phrase.japaneseSentence)")
                    
                    // Korean Pronunciation
                    Text(phrase.koreanPronunciation)
                        .font(StyleConstants.Typography.koreanDynamic(.caption2))
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("한국어 발음: \(phrase.koreanPronunciation)")
                    
                    // Korean Text
                    Text(phrase.koreanSentence)
                        .font(StyleConstants.Typography.koreanDynamic(.footnote))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("한국어 번역: \(phrase.koreanSentence)")
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
            .cornerRadius(12)
            .shadow(color: StyleConstants.Colors.adaptiveShadow(colorScheme), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}

// MARK: - Favorite Card Detail View  
struct FavoriteCardDetailView: View {
    let phrase: JapanesePhrase
    let allFavorites: [JapanesePhrase]
    @Binding var isPresented: Bool
    @State private var currentIndex: Int = 0
    @Environment(\.colorScheme) private var colorScheme
    
    init(phrase: JapanesePhrase, allFavorites: [JapanesePhrase], isPresented: Binding<Bool>) {
        self.phrase = phrase
        self.allFavorites = allFavorites
        self._isPresented = isPresented
        self._currentIndex = State(initialValue: 0)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                // Card View
                if !allFavorites.isEmpty {
                    TabView(selection: $currentIndex) {
                        ForEach(Array(allFavorites.enumerated()), id: \.offset) { index, favoritePhrase in
                            CardView(phrase: favoritePhrase, isInModal: true)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 590)
                    .onChange(of: currentIndex) { oldValue, newValue in
                        TTSManager.shared.stop()
                        HapticManager.shared.impact(.light, intensity: 0.6)
                    }
                }
                
                Spacer()
                
                // Card Counter
                if !allFavorites.isEmpty {
                    Text("\(currentIndex + 1) / \(allFavorites.count)")
                        .font(StyleConstants.Typography.caption)
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .accessibilityLabel("\(allFavorites.count)개 중 \(currentIndex + 1)번째 카드")
                        .padding(.bottom, 30)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .onAppear {
            TTSManager.shared.stop()
            // Set correct index when modal appears
            DispatchQueue.main.async {
                if let index = allFavorites.firstIndex(where: { $0.id == phrase.id }) {
                    currentIndex = index
                }
            }
        }
        .onDisappear {
            TTSManager.shared.stop()
        }
    }
} 