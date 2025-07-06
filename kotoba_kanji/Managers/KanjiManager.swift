import Foundation
import SwiftData

class KanjiManager {
    static let shared = KanjiManager()
    
    private init() {}
    
    func loadInitialKanjiData(modelContext: ModelContext) {
        // Check if kanji data already exists
        let descriptor = FetchDescriptor<Kanji>()
        let existingKanji = try? modelContext.fetch(descriptor)
        
        if let existingKanji = existingKanji, !existingKanji.isEmpty {
            print("Kanji data already loaded: \(existingKanji.count) kanji found")
            return
        }
        
        // Load initial kanji data
        let kanjiData = getInitialKanjiData()
        for kanji in kanjiData {
            modelContext.insert(kanji)
        }
        
        // Load example sentences
        let examplesData = getInitialExamplesData()
        for example in examplesData {
            modelContext.insert(example)
        }
        
        do {
            try modelContext.save()
            print("Successfully loaded \(kanjiData.count) kanji and \(examplesData.count) examples")
        } catch {
            print("Failed to save initial kanji data: \(error)")
        }
    }
    
    private func getInitialKanjiData() -> [Kanji] {
        return [
            // 1. 日 (날 일, 해 일)
            Kanji(
                id: 1,
                character: "日",
                meanings: ["날", "해", "태양"],
                onyomi: ["ニチ", "ジツ"],
                kunyomi: ["ひ", "-び", "-か"],
                bushu: "日",
                bushuMeaning: "해 일",
                mnemonic: "네모난 창문(口)에 햇살(一)이 들어오는 모습을 형상화했거나, 둥근 태양의 모양을 네모나게 단순화한 글자입니다. 태양 그 자체를 떠올리세요.",
                strokeCount: 4,
                jlptLevel: 5
            ),
            
            // 2. 一 (한 일)
            Kanji(
                id: 2,
                character: "一",
                meanings: ["하나", "한"],
                onyomi: ["イチ", "イツ"],
                kunyomi: ["ひと", "ひとつ"],
                bushu: "一",
                bushuMeaning: "한 일",
                mnemonic: "손가락 하나를 옆으로 쭉 편 모양, 혹은 땅(지평선)을 하나의 선으로 표현한 가장 기본적인 글자입니다. 하나의 선으로 기억하세요.",
                strokeCount: 1,
                jlptLevel: 5
            ),
            
            // 3. 人 (사람 인)
            Kanji(
                id: 3,
                character: "人",
                meanings: ["사람"],
                onyomi: ["ジン", "ニン"],
                kunyomi: ["ひと"],
                bushu: "人",
                bushuMeaning: "사람 인",
                mnemonic: "사람이 두 발로 서서 걸어가는 옆모습을 본떠 만든 글자입니다. 걷는 사람을 상상해 보세요.",
                strokeCount: 2,
                jlptLevel: 5
            ),
            
            // 4. 年 (해 년, 나이 년)
            Kanji(
                id: 4,
                character: "年",
                meanings: ["해", "년", "나이"],
                onyomi: ["ネン"],
                kunyomi: ["とし"],
                bushu: "干",
                bushuMeaning: "방패 간",
                mnemonic: "벼(禾)가 자라서 수확하기까지의 주기, 즉 '한 해'를 의미했습니다. 지금의 자형은 모양이 변했지만, '벼농사를 짓는 한 해의 주기'라는 본래 의미를 떠올리면 기억하기 쉽습니다.",
                strokeCount: 6,
                jlptLevel: 5
            ),
            
            // 5. 大 (큰 대)
            Kanji(
                id: 5,
                character: "大",
                meanings: ["크다", "큰"],
                onyomi: ["ダイ", "タイ"],
                kunyomi: ["おお(きい)"],
                bushu: "大",
                bushuMeaning: "큰 대",
                mnemonic: "사람이 두 팔과 두 다리를 활짝 벌리고 서 있는 모습입니다. \"나 이만큼 크다!\" 하고 뽐내는 사람을 상상하세요.",
                strokeCount: 3,
                jlptLevel: 5
            ),
            
            // 6. 本 (근본 본, 책 본)
            Kanji(
                id: 6,
                character: "本",
                meanings: ["근본", "책", "원래"],
                onyomi: ["ホン"],
                kunyomi: ["もと"],
                bushu: "木",
                bushuMeaning: "나무 목",
                mnemonic: "나무(木)의 아래쪽에 선(一)을 그어 나무의 '뿌리' 즉 '근본'을 나타낸 글자입니다. 여기서 파생되어 '책'이라는 의미로도 널리 쓰입니다.",
                strokeCount: 5,
                jlptLevel: 5
            ),
            
            // 7. 中 (가운데 중)
            Kanji(
                id: 7,
                character: "中",
                meanings: ["가운데", "중간", "안"],
                onyomi: ["チュウ"],
                kunyomi: ["なか"],
                bushu: "丨",
                bushuMeaning: "뚫을 곤",
                mnemonic: "네모난 상자나 영역(口)의 정중앙을 막대기(丨)가 관통하는 모습입니다. '가운데', '안'이라는 의미를 직관적으로 보여줍니다.",
                strokeCount: 4,
                jlptLevel: 5
            ),
            
            // 8. 上 (윗 상)
            Kanji(
                id: 8,
                character: "上",
                meanings: ["위", "오르다", "상"],
                onyomi: ["ジョウ"],
                kunyomi: ["うえ", "あ(がる)"],
                bushu: "一",
                bushuMeaning: "한 일",
                mnemonic: "기준이 되는 지평선(긴 一) '위(上)'에 어떤 물건(짧은 ㅣ와 一)이 있는 모습을 나타냅니다. 아래를 나타내는 下와 반대되는 개념입니다.",
                strokeCount: 3,
                jlptLevel: 5
            ),
            
            // 9. 下 (아래 하)
            Kanji(
                id: 9,
                character: "下",
                meanings: ["아래", "내리다", "하"],
                onyomi: ["カ", "ゲ"],
                kunyomi: ["した", "さ(がる)", "くだ(さい)"],
                bushu: "一",
                bushuMeaning: "한 일",
                mnemonic: "기준이 되는 지평선(긴 一) '아래(下)'로 어떤 물건(T 모양)이 내려와 있는 모습입니다. 위를 나타내는 上과 세트로 기억하면 좋습니다.",
                strokeCount: 3,
                jlptLevel: 5
            ),
            
            // 10. 前 (앞 전)
            Kanji(
                id: 10,
                character: "前",
                meanings: ["앞", "전"],
                onyomi: ["ゼン"],
                kunyomi: ["まえ"],
                bushu: "刀",
                bushuMeaning: "칼 도",
                mnemonic: "원래는 '발(止)'로 '앞(前)'으로 나아가는 모습과 '배(舟)'의 이미지 등이 결합된 복잡한 글자였습니다. 현대적으로는 '달 월(月)'처럼 생긴 부분과 '칼(刂)'의 조합으로 보고, '달(月)이 뜨기 전(前)에 칼(刂)로 길을 개척하며 나아간다'는 식으로 이야기를 만들어 외우면 좋습니다.",
                strokeCount: 9,
                jlptLevel: 5
            )
        ]
    }
    
    private func getInitialExamplesData() -> [KanjiExample] {
        return [
            // Examples for 日 (id: 1)
            KanjiExample(
                kanjiId: 1,
                japanese: "今日は日曜日です。",
                hiragana: "きょうは にちようびです。",
                korean: "오늘은 일요일입니다.",
                romaji: "Kyō wa nichiyōbi desu.",
                koreanPronunciation: "쿄-와 니치요-비데스."
            ),
            KanjiExample(
                kanjiId: 1,
                japanese: "日本の夏は、日が長いです。",
                hiragana: "にほんの なつは ひが ながいです。",
                korean: "일본의 여름은 해가 깁니다.",
                romaji: "Nihon no natsu wa hi ga nagai desu.",
                koreanPronunciation: "니혼노 나츠와 히가 나가이데스."
            ),
            
            // Examples for 一 (id: 2)
            KanjiExample(
                kanjiId: 2,
                japanese: "一番安いのをください。",
                hiragana: "いちばん やすいのを ください。",
                korean: "제일 싼 것을 주세요.",
                romaji: "Ichiban yasui no o kudasai.",
                koreanPronunciation: "이치반 야스이노오 쿠다사이."
            ),
            KanjiExample(
                kanjiId: 2,
                japanese: "もう一度、ゆっくり話してください。",
                hiragana: "もう いちど、ゆっくり はなしてください。",
                korean: "한 번 더, 천천히 말해주세요.",
                romaji: "Mō ichido, yukkuri hanashite kudasai.",
                koreanPronunciation: "모- 이치도, 육쿠리 하나시테 쿠다사이."
            ),
            
            // Examples for 人 (id: 3)
            KanjiExample(
                kanjiId: 3,
                japanese: "あの人は誰ですか。",
                hiragana: "あの ひとは だれですか。",
                korean: "저 사람은 누구입니까?",
                romaji: "Ano hito wa dare desu ka.",
                koreanPronunciation: "아노 히토와 다레데스카."
            ),
            KanjiExample(
                kanjiId: 3,
                japanese: "この店は外国人に人気があります。",
                hiragana: "この みせは がいこくじんに にんきが あります。",
                korean: "이 가게는 외국인에게 인기가 있습니다.",
                romaji: "Kono mise wa gaikokujin ni ninki ga arimasu.",
                koreanPronunciation: "코노 미세와 가이코쿠진니 닌키가 아리마스."
            ),
            
            // Examples for 年 (id: 4)
            KanjiExample(
                kanjiId: 4,
                japanese: "今年はいい年でした。",
                hiragana: "ことしは いい としでした。",
                korean: "올해는 좋은 해였습니다.",
                romaji: "Kotoshi wa ii toshi deshita.",
                koreanPronunciation: "코토시와 이이 토시데시타."
            ),
            KanjiExample(
                kanjiId: 4,
                japanese: "来年、日本へ旅行に行く予定です。",
                hiragana: "らいねん、にほんへ りょこうに いく よていです。",
                korean: "내년에 일본으로 여행 갈 예정입니다.",
                romaji: "Rainen, Nihon e ryokō ni iku yotei desu.",
                koreanPronunciation: "라이넨, 니혼에 료코-니 이쿠 요테-데스."
            ),
            
            // Examples for 大 (id: 5)
            KanjiExample(
                kanjiId: 5,
                japanese: "この靴は大きいですね。",
                hiragana: "この くつは おおきいですね。",
                korean: "이 신발은 크네요.",
                romaji: "Kono kutsu wa ōkii desu ne.",
                koreanPronunciation: "코노 쿠츠와 오-키-데스네."
            ),
            KanjiExample(
                kanjiId: 5,
                japanese: "大学で日本語を勉強しています。",
                hiragana: "だいがくで にほんごを べんきょうしています。",
                korean: "대학교에서 일본어를 공부하고 있습니다.",
                romaji: "Daigaku de Nihongo o benkyō shite imasu.",
                koreanPronunciation: "다이가쿠데 니혼고오 벵쿄-시테이마스."
            ),
            
            // Examples for 本 (id: 6)
            KanjiExample(
                kanjiId: 6,
                japanese: "毎日、本を読みます。",
                hiragana: "まいにち、ほんを よみます。",
                korean: "매일 책을 읽습니다.",
                romaji: "Mainichi, hon o yomimasu.",
                koreanPronunciation: "마이니치, 홍오 요미마스."
            ),
            KanjiExample(
                kanjiId: 6,
                japanese: "山本さんは日本の文化に詳しいです。",
                hiragana: "やまもとさんは にほんの ぶんかに くわしいです。",
                korean: "야마모토씨는 일본 문화에 대해 잘 압니다.",
                romaji: "Yamamoto-san wa Nihon no bunka ni kuwashii desu.",
                koreanPronunciation: "야마모토상와 니혼노 분카니 쿠와시-데스."
            ),
            
            // Examples for 中 (id: 7)
            KanjiExample(
                kanjiId: 7,
                japanese: "カバンの中に何がありますか。",
                hiragana: "かばんの なかに なにが ありますか。",
                korean: "가방 안에 무엇이 있습니까?",
                romaji: "Kaban no naka ni nani ga arimasu ka.",
                koreanPronunciation: "카반노 나카니 나니가 아리마스카."
            ),
            KanjiExample(
                kanjiId: 7,
                japanese: "田中さんは今、電話中です。",
                hiragana: "たなかさんは いま、でんわちゅうです。",
                korean: "다나카씨는 지금 통화 중입니다.",
                romaji: "Tanaka-san wa ima, denwachū desu.",
                koreanPronunciation: "타나카상와 이마, 덴와츄-데스."
            ),
            
            // Examples for 上 (id: 8)
            KanjiExample(
                kanjiId: 8,
                japanese: "机の上に猫がいます。",
                hiragana: "つくえの うえに ねこが います。",
                korean: "책상 위에 고양이가 있습니다.",
                romaji: "Tsukue no ue ni neko ga imasu.",
                koreanPronunciation: "츠쿠에노 우에니 네코가 이마스."
            ),
            KanjiExample(
                kanjiId: 8,
                japanese: "エレベーターで上に上がってください。",
                hiragana: "エレベーターで うえに あがってください。",
                korean: "엘리베이터로 위로 올라가 주세요.",
                romaji: "Erebētā de ue ni agatte kudasai.",
                koreanPronunciation: "에레베-타-데 우에니 아갓테 쿠다사이."
            ),
            
            // Examples for 下 (id: 9)
            KanjiExample(
                kanjiId: 9,
                japanese: "椅子の下にあります。",
                hiragana: "いすの したに あります。",
                korean: "의자 아래에 있습니다.",
                romaji: "Isu no shita ni arimasu.",
                koreanPronunciation: "이스노 시타니 아리마스."
            ),
            KanjiExample(
                kanjiId: 9,
                japanese: "次の駅で電車を降りてください。",
                hiragana: "つぎの えきで でんしゃを おりてください。",
                korean: "다음 역에서 전차를 내려주세요.",
                romaji: "Tsugi no eki de densha o orite kudasai.",
                koreanPronunciation: "츠기노 에키데 덴샤오 오리테 쿠다사이."
            ),
            
            // Examples for 前 (id: 10)
            KanjiExample(
                kanjiId: 10,
                japanese: "駅の前にカフェがあります。",
                hiragana: "えきの まえに カフェが あります。",
                korean: "역 앞에 카페가 있습니다.",
                romaji: "Eki no mae ni kafe ga arimasu.",
                koreanPronunciation: "에키노 마에니 카페가 아리마스."
            ),
            KanjiExample(
                kanjiId: 10,
                japanese: "食事の前に手を洗いましょう。",
                hiragana: "しょくじの まえに てを あらいましょう。",
                korean: "식사 전에 손을 씻읍시다.",
                romaji: "Shokuji no mae ni te o araimashō.",
                koreanPronunciation: "쇼쿠지노 마에니 테오 아라이마쇼-."
            )
        ]
    }
}