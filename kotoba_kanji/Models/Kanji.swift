import Foundation
import SwiftData

@Model
final class Kanji {
    var id: Int
    var character: String
    var meanings: [String]
    var onyomi: [String]
    var kunyomi: [String]
    var bushu: String
    var bushuMeaning: String
    var mnemonic: String
    var strokeCount: Int
    var jlptLevel: Int
    var frequency: Int
    var isFavorite: Bool
    
    init(
        id: Int,
        character: String,
        meanings: [String],
        onyomi: [String],
        kunyomi: [String],
        bushu: String,
        bushuMeaning: String,
        mnemonic: String,
        strokeCount: Int,
        jlptLevel: Int = 5,
        frequency: Int = 0,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.character = character
        self.meanings = meanings
        self.onyomi = onyomi
        self.kunyomi = kunyomi
        self.bushu = bushu
        self.bushuMeaning = bushuMeaning
        self.mnemonic = mnemonic
        self.strokeCount = strokeCount
        self.jlptLevel = jlptLevel
        self.frequency = frequency
        self.isFavorite = isFavorite
    }
}