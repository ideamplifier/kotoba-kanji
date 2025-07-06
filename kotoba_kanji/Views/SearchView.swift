import SwiftUI
import SwiftData

// MARK: - Search View
struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var kanjiList: [Kanji]
    @Query private var examples: [KanjiExample]
    @State private var searchText = ""
    @State private var selectedKanji: Kanji?
    @State private var showingCard = false
    
    var filteredKanji: [Kanji] {
        if searchText.isEmpty {
            return kanjiList.sorted { $0.id < $1.id }
        } else {
            // Check if search text is a number (kanji ID search)
            if let kanjiId = Int(searchText.trimmingCharacters(in: .whitespaces)) {
                return kanjiList.filter { kanji in
                    kanji.id == kanjiId
                }.sorted { $0.id < $1.id }
            }
            
            // Regular text search
            return kanjiList.filter { kanji in
                // Search in kanji character
                kanji.character.localizedCaseInsensitiveContains(searchText) ||
                // Search in meanings
                kanji.meanings.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
                // Search in onyomi
                kanji.onyomi.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
                // Search in kunyomi
                kanji.kunyomi.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
                // Search in bushu
                kanji.bushu.localizedCaseInsensitiveContains(searchText) ||
                kanji.bushuMeaning.localizedCaseInsensitiveContains(searchText) ||
                // Search in example sentences
                examples.filter { $0.kanjiId == kanji.id }.contains { example in
                    example.japanese.localizedCaseInsensitiveContains(searchText) ||
                    example.korean.localizedCaseInsensitiveContains(searchText)
                }
            }.sorted { $0.id < $1.id }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Content
                if searchText.isEmpty {
                    // Empty state with quick search tags
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image("search_empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .opacity(0.6)
                            .accessibilityLabel("검색 대기 이미지")
                            .padding(.top, 200)
                        
                        // Quick Search Tags
                        VStack(spacing: 12) {
                            Text("빠른 검색")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            
                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    TagButton(title: "날", searchText: $searchText)
                                    TagButton(title: "사람", searchText: $searchText)
                                    TagButton(title: "큰", searchText: $searchText)
                                }
                                HStack(spacing: 8) {
                                    TagButton(title: "위", searchText: $searchText)
                                    TagButton(title: "아래", searchText: $searchText)
                                    TagButton(title: "앞", searchText: $searchText)
                                }
                            }
                        }
                        .padding(.top, 16)
                        
                        Spacer()
                    }
                } else if filteredKanji.isEmpty {
                    // No results
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image(systemName: "exclamationmark.magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextTertiary(colorScheme))
                            .accessibilityLabel("검색 결과 없음")
                        
                        Text("검색 결과가 없어요")
                            .font(StyleConstants.Typography.koreanDynamic(.headline, weight: .medium))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        
                        Text("다른 검색어로 시도해보세요")
                            .font(StyleConstants.Typography.koreanDynamic(.subheadline))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextTertiary(colorScheme))
                        
                        Spacer()
                    }
                } else {
                    // Search results with list view
                    VStack(spacing: 0) {
                        // Search Results Counter
                        HStack {
                            Text("\(filteredKanji.count)개의 검색 결과")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        
                        // Results List
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(filteredKanji, id: \.id) { kanji in
                                    SearchResultRow(kanji: kanji) {
                                        selectedKanji = kanji
                                        showingCard = true
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "한자, 의미, 음독, 훈독 검색"
            )
            .accessibilityLabel("검색 화면")
        }
        .sheet(isPresented: $showingCard) {
            if let kanji = selectedKanji {
                KanjiDetailModalView(kanji: kanji)
            }
        }
        .onAppear {
            TTSManager.shared.stop()
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let kanji: Kanji
    let onTap: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Kanji Character
                Text(kanji.character)
                    .font(.system(size: 36, weight: .regular))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    .frame(width: 50, height: 50)
                    .background(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityLabel("한자 \(kanji.character)")
                
                VStack(alignment: .leading, spacing: 4) {
                    // Meanings
                    Text(kanji.meanings.joined(separator: ", "))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .lineLimit(1)
                        .accessibilityLabel("의미: \(kanji.meanings.joined(separator: ", "))")
                    
                    // Readings
                    HStack(spacing: 8) {
                        if !kanji.onyomi.isEmpty {
                            Text(kanji.onyomi.first ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                                .lineLimit(1)
                        }
                        
                        if !kanji.kunyomi.isEmpty {
                            Text(kanji.kunyomi.first ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(Color.purple)
                                .lineLimit(1)
                        }
                    }
                    .accessibilityLabel("읽기: 음독 \(kanji.onyomi.joined(separator: ", ")), 훈독 \(kanji.kunyomi.joined(separator: ", "))")
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextTertiary(colorScheme))
                    .accessibilityHidden(true)
            }
            .padding(12)
            .background(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
            .cornerRadius(12)
            .shadow(color: StyleConstants.Colors.adaptiveShadow(colorScheme), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Kanji Detail Modal View
struct KanjiDetailModalView: View {
    let kanji: Kanji
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                KanjiCardView(kanji: kanji)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                }
            }
        }
    }
}