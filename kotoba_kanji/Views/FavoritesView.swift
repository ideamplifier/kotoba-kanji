import SwiftUI
import SwiftData

// MARK: - Favorites View
struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query(filter: #Predicate<Kanji> { kanji in
        kanji.isFavorite == true
    }) private var favoriteKanji: [Kanji]
    @State private var selectedKanji: Kanji?
    
    private var sortedFavoriteKanji: [Kanji] {
        favoriteKanji.sorted { $0.id < $1.id }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if sortedFavoriteKanji.isEmpty {
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
                            ForEach(sortedFavoriteKanji, id: \.id) { kanji in
                                FavoriteKanjiRowView(kanji: kanji) {
                                    selectedKanji = kanji
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
        .sheet(item: $selectedKanji) { kanji in
            FavoriteKanjiDetailView(
                kanji: kanji,
                allFavorites: sortedFavoriteKanji,
                isPresented: .constant(true)
            )
        }
        .onAppear {
            TTSManager.shared.stop()
        }
    }
}

// MARK: - Favorite Kanji Row View
struct FavoriteKanjiRowView: View {
    let kanji: Kanji
    let onTap: () -> Void
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Kanji Character
                Text(kanji.character)
                    .font(.system(size: 32, weight: .regular))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    .frame(width: 44, height: 44)
                    .background(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .accessibilityLabel("한자 \(kanji.character)")
                
                VStack(alignment: .leading, spacing: 3) {
                    // Meanings
                    Text(kanji.meanings.joined(separator: ", "))
                        .font(StyleConstants.Typography.callout.weight(.medium))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("의미: \(kanji.meanings.joined(separator: ", "))")
                    
                    // Onyomi
                    if !kanji.onyomi.isEmpty {
                        Text("음독: \(kanji.onyomi.joined(separator: ", "))")
                            .font(StyleConstants.Typography.koreanDynamic(.caption2))
                            .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                            .multilineTextAlignment(.leading)
                            .accessibilityLabel("음독: \(kanji.onyomi.joined(separator: ", "))")
                    }
                    
                    // Kunyomi
                    if !kanji.kunyomi.isEmpty {
                        Text("훈독: \(kanji.kunyomi.joined(separator: ", "))")
                            .font(StyleConstants.Typography.koreanDynamic(.footnote))
                            .foregroundColor(Color.purple)
                            .multilineTextAlignment(.leading)
                            .accessibilityLabel("훈독: \(kanji.kunyomi.joined(separator: ", "))")
                    }
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

// MARK: - Favorite Kanji Detail View  
struct FavoriteKanjiDetailView: View {
    let kanji: Kanji
    let allFavorites: [Kanji]
    @Binding var isPresented: Bool
    @State private var currentIndex: Int = 0
    @Environment(\.colorScheme) private var colorScheme
    
    init(kanji: Kanji, allFavorites: [Kanji], isPresented: Binding<Bool>) {
        self.kanji = kanji
        self.allFavorites = allFavorites
        self._isPresented = isPresented
        self._currentIndex = State(initialValue: 0)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                // Kanji Card View
                if !allFavorites.isEmpty {
                    TabView(selection: $currentIndex) {
                        ForEach(Array(allFavorites.enumerated()), id: \.offset) { index, favoriteKanji in
                            KanjiCardView(kanji: favoriteKanji)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 590)
                    .padding(.horizontal, 20)
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
                        .accessibilityLabel("\(allFavorites.count)개 중 \(currentIndex + 1)번째 한자")
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
                if let index = allFavorites.firstIndex(where: { $0.id == kanji.id }) {
                    currentIndex = index
                }
            }
        }
        .onDisappear {
            TTSManager.shared.stop()
        }
    }
}