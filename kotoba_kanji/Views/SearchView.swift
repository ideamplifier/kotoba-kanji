import SwiftUI
import SwiftData

// MARK: - Search View
struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var phrases: [JapanesePhrase]
    @State private var searchText = ""
    @State private var currentIndex = 0
    @State private var selectedPhrase: JapanesePhrase?
    @State private var showingCard = false
    
    var filteredPhrases: [JapanesePhrase] {
        if searchText.isEmpty {
            return phrases.sorted { $0.id < $1.id }
        } else {
            // Check if search text is a number (card number search)
            if let cardNumber = Int(searchText.trimmingCharacters(in: .whitespaces)), 
               cardNumber >= 1 && cardNumber <= 365 {
                return phrases.filter { phrase in
                    phrase.id == cardNumber
                }.sorted { $0.id < $1.id }
            }
            
            // Regular text search
            return phrases.filter { phrase in
                phrase.japaneseSentence.localizedCaseInsensitiveContains(searchText) ||
                phrase.koreanSentence.localizedCaseInsensitiveContains(searchText) ||
                phrase.hiragana.localizedCaseInsensitiveContains(searchText) ||
                phrase.romaji.localizedCaseInsensitiveContains(searchText) ||
                phrase.grammar.localizedCaseInsensitiveContains(searchText)
            }.sorted { $0.id < $1.id }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Content
                if searchText.isEmpty {
                    // Empty state with tags
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
                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    TagButton(title: "인사", searchText: $searchText)
                                    TagButton(title: "감사", searchText: $searchText)
                                    TagButton(title: "질문", searchText: $searchText)
                                }
                                HStack(spacing: 8) {
                                    TagButton(title: "음식", searchText: $searchText)
                                    TagButton(title: "날씨", searchText: $searchText)
                                    TagButton(title: "교통", searchText: $searchText)
                                }
                            }
                        }
                        .padding(.top, 16)
                        
                        Spacer()
                    }
                } else if filteredPhrases.isEmpty {
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
                            Text("\(filteredPhrases.count)개의 검색 결과")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        // Search Results List
                        ScrollView {
                            VStack(spacing: 8) {
                                ForEach(Array(filteredPhrases.enumerated()), id: \.offset) { index, phrase in
                                    SearchResultRowView(phrase: phrase) {
                                        selectedPhrase = phrase
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 20)
                        }
                    }
                }
                
                // Search Bar at bottom
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                            .accessibilityHidden(true)
                        
                        TextField("일본어, 한국어, 로마자 검색", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                            .accessibilityLabel("검색 입력 필드")
                            .accessibilityHint("일본어, 한국어, 로마자 또는 카드 번호로 검색할 수 있습니다")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                    .cornerRadius(12)
                    
                    if !searchText.isEmpty {
                        Button("취소") {
                            searchText = ""
                            hideKeyboard()
                        }
                        .font(StyleConstants.Typography.koreanDynamic(.body))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .accessibilityLabel("검색 취소")
                        .accessibilityHint("검색어를 지우고 키보드를 닫습니다")
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .sheet(item: $selectedPhrase) { phrase in
            VStack {
                CardView(phrase: phrase, isInModal: true)
                Spacer()
            }
            .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        }
        .onAppear {
            if !searchText.isEmpty {
                searchText = ""
            }
            currentIndex = 0
            TTSManager.shared.stop()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Search Result Row View
struct SearchResultRowView: View {
    let phrase: JapanesePhrase
    let onTap: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Card Number
                Text("\(phrase.id)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    // Japanese Text
                    Text(phrase.japaneseSentence)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.naturalTextColor.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    // Korean Text
                    Text(phrase.koreanSentence)
                        .font(.system(size: 13))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextTertiary(colorScheme))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .background(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
} 