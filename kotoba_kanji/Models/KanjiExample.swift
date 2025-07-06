import Foundation
import SwiftData

@Model
final class KanjiExample {
    var id: UUID
    var kanjiId: Int
    var japanese: String
    var hiragana: String
    var korean: String
    var romaji: String
    var koreanPronunciation: String
    
    init(
        kanjiId: Int,
        japanese: String,
        hiragana: String,
        korean: String,
        romaji: String,
        koreanPronunciation: String
    ) {
        self.id = UUID()
        self.kanjiId = kanjiId
        self.japanese = japanese
        self.hiragana = hiragana
        self.korean = korean
        self.romaji = romaji
        self.koreanPronunciation = koreanPronunciation
    }
}