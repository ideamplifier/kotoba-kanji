import Foundation

// MARK: - Conversation Data Model
struct ConversationData {
    let speaker: String
    let text: String
    let romaji: String
    let translation: String
    let isUserLine: Bool
}

// MARK: - Conversation Manager
class ConversationManager {
    static let shared = ConversationManager()
    
    private init() {}
    
    // MARK: - Public Methods
    func getConversationScenario(for cardId: Int) -> [ConversationData]? {
        return conversationScenarios[cardId]
    }
    
    func hasConversation(for cardId: Int) -> Bool {
        return conversationScenarios[cardId] != nil
    }
    
    // MARK: - Quality Assessment
    /// 대화가 적용하기 적절한 카드인지 판단
    func isSuitableForConversation(phraseId: Int, phraseText: String) -> Bool {
        // 일상 대화에 자주 쓰이는 표현들
        let conversationFriendlyPatterns = [
            "ありがとう", "すみません", "お願い", "こんにちは", "おはよう",
            "いらっしゃい", "ください", "です", "だいじょうぶ", "わかり"
        ]
        
        return conversationFriendlyPatterns.contains { pattern in
            phraseText.contains(pattern)
        }
    }
    
    // MARK: - Private Data
    private let conversationScenarios: [Int: [ConversationData]] = [
        1: [ // 아침 인사 (朝の挨拶)
            ConversationData(speaker: "사토", text: "おはようございます！", romaji: "오하요- 고자이마스!", translation: "좋은 아침이에요!", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、おはようございます。よく眠れましたか？", romaji: "사토상, 오하요- 고자이마스. 요쿠 네무레마시타카?", translation: "사토 씨, 좋은 아침이에요. 잘 주무셨어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ぐっすり眠りました。今日も頑張りましょう！", romaji: "하이, 굿스리 네무리마시타. 쿄-모 감바리마쇼-!", translation: "네, 푹 잤어요. 오늘도 힘내요!", isUserLine: false)
        ],
        2: [ // 점심 인사 (昼の挨拶)
            ConversationData(speaker: "사토", text: "こんにちは。", romaji: "곤니치와.", translation: "안녕하세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、こんにちは。今からお昼ですか？", romaji: "사토상, 곤니치와. 이마카라 오히루데스카?", translation: "사토 씨, 안녕하세요. 지금 점심 드시러 가세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい。一緒に行きませんか？", romaji: "하이. 잇쇼니 이키마센카?", translation: "네. 같이 가지 않을래요?", isUserLine: false)
        ],
        3: [ // 감사 표현 (感謝の表現)
            ConversationData(speaker: "사토", text: "この資料、ありがとうございます。助かりました。", romaji: "고노 시료-, 아리가토- 고자이마스. 다스카리마시타.", translation: "이 자료, 고맙습니다. 도움이 되었어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、どういたしまして。", romaji: "이이에, 도-이타시마시테.", translation: "아니요, 천만에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当に助かりました。今度お礼にコーヒーでも。", romaji: "혼토-니 다스카리마시타. 콘도 오레-니 코-히-데모.", translation: "정말로 도움이 됐어요. 다음에 보답으로 커피라도 살게요.", isUserLine: false)
        ],
        4: [ // 사과/부탁 (謝罪/お願い)
            ConversationData(speaker: "사토", text: "すみません、ペンを貸していただけますか？", romaji: "스미마셍, 펜오 카시테 이타다케마스카?", translation: "실례합니다만, 펜 좀 빌릴 수 있을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、どうぞ。", romaji: "하이, 도-조.", translation: "네, 여기요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。すぐお返しします。", romaji: "아리가토- 고자이마스. 스구 오카에시시마스.", translation: "고맙습니다. 바로 돌려드릴게요.", isUserLine: false)
        ],
        5: [ // 부탁/요청 (お願い/要請)
            ConversationData(speaker: "사토", text: "この荷物、少しの間、見ていていただけますか。お願いします。", romaji: "고노 니모츠, 스코시노 아이다, 미테이테 이타다케마스카. 오네가이시마스.", translation: "이 짐, 잠시만 봐주시겠어요? 부탁드립니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、大丈夫ですよ。", romaji: "하이, 다이죠-부데스요.", translation: "네, 괜찮아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。本当に助かります。", romaji: "아리가토- 고자이마스. 혼토-니 다스카리마스.", translation: "고맙습니다. 정말 도움이 되네요.", isUserLine: false)
        ],
        6: [ // 가격 질문 (値段の質問)
            ConversationData(speaker: "사토", text: "これ、いくらですか？", romaji: "고레, 이쿠라데스카?", translation: "이거, 얼마예요?", isUserLine: false),
            ConversationData(speaker: "나", text: "それは千円です。", romaji: "소레와 센엔데스.", translation: "그것은 1,000엔입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか。じゃあ、これをください。", romaji: "소-데스카. 쟈-, 고레오 구다사이.", translation: "그래요? 그럼 이걸로 주세요.", isUserLine: false)
        ],
        7: [ // 장소 질문 (場所の質問)
            ConversationData(speaker: "사토", text: "すみません、トイレはどこですか？", romaji: "스미마셍, 토이레와 도코데스카?", translation: "실례합니다, 화장실은 어디인가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "あそこをまっすぐ行って、右に曲がるとありますよ。", romaji: "아소코오 맛스구 잇테, 미기니 마가루토 아리마스요.", translation: "저쪽으로 쭉 가서 오른쪽으로 돌면 있어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかりました。ありがとうございます。", romaji: "와카리마시타. 아리가토- 고자이마스.", translation: "알겠습니다. 고맙습니다.", isUserLine: false)
        ],
        8: [ // 괜찮음 표현 (大丈夫の表現)
            ConversationData(speaker: "사토", text: "大丈夫ですか？顔色が悪いですよ。", romaji: "다이죠-부데스카? 가오이로가 와루이데스요.", translation: "괜찮으세요? 안색이 안 좋아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫です、ちょっと疲れているだけです。", romaji: "다이죠-부데스, 좃토 츠카레테이루 다케데스.", translation: "괜찮습니다, 조금 피곤할 뿐이에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "無理しないでくださいね。", romaji: "무리시나이데 구다사이네.", translation: "무리하지 마세요.", isUserLine: false)
        ],
        9: [ // 이해 표현 (理解の表現)
            ConversationData(speaker: "사토", text: "このボタンを押してから、ダイヤルを回してください。", romaji: "고노 보탄오 오시테카라, 다이야루오 마와시테 구다사이.", translation: "이 버튼을 누르고 나서, 다이얼을 돌려주세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "わかりました。やってみます。", romaji: "와카리마시타. 얏테미마스.", translation: "알겠습니다. 해 볼게요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "何か分からなかったら、また聞いてくださいね。", romaji: "나니카 와카라나캇타라, 마타 키-테 구다사이네.", translation: "모르는 게 있으면 또 물어보세요.", isUserLine: false)
        ],
        10: [ // 첫 만남 (初対面)
            ConversationData(speaker: "사토", text: "はじめまして、佐藤と申します。", romaji: "하지메마시테, 사토-토 모-시마스.", translation: "처음 뵙겠습니다, 사토라고 합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はじめまして、キムです。どうぞよろしくお願いします。", romaji: "하지메마시테, 기무데스. 도-조 요로시쿠 오네가이시마스.", translation: "처음 뵙겠습니다, 김입니다. 부디 잘 부탁드립니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "こちらこそ、よろしくお願いします。", romaji: "고치라코소, 요로시쿠 오네가이시마스.", translation: "저야말로 잘 부탁드립니다.", isUserLine: false)
        ],
        11: [ // 천만에요 표현 (どういたしまして)
            ConversationData(speaker: "사토", text: "先程は資料のコピー、ありがとうございました。", romaji: "사키호도와 시료-노 코피-, 아리가토- 고자이마시타.", translation: "아까 자료 복사, 감사했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、どういたしまして。お役に立ててよかったです。", romaji: "이이에, 도-이타시마시테. 오야쿠니 타테테 요캇타데스.", translation: "아닙니다, 천만에요. 도움이 되어서 다행이에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "おかげで会議に間に合いました。", romaji: "오카게데 카이기니 마니아이마시타.", translation: "덕분에 회의에 늦지 않았어요.", isUserLine: false)
        ],
        12: [ // 가벼운 사과 (ごめんなさい)
            ConversationData(speaker: "사토", text: "あっ、ごめんなさい！足を踏んでしまいました。", romaji: "앗, 고멘나사이! 아시오 훈데시마이마시타.", translation: "앗, 미안해요! 발을 밟아버렸어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫ですよ。気にしないでください。", romaji: "다이죠-부데스요. 키니시나이데 쿠다사이.", translation: "괜찮아요. 신경 쓰지 마세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "すみません、気をつけます。", romaji: "스미마센, 키오츠케마스.", translation: "죄송합니다, 조심할게요.", isUserLine: false)
        ],
        13: [ // 가게의 환영 인사 (いらっしゃいませ)
            ConversationData(speaker: "점원", text: "いらっしゃいませ！何名様ですか？", romaji: "이랏샤이마세! 난메-사마데스카?", translation: "어서 오세요! 몇 분이신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "二人です。禁煙席はありますか？", romaji: "후타리데스. 킨엔세키와 아리마스카?", translation: "두 명이에요. 금연석 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、ございます。こちらの席へどうぞ。", romaji: "하이, 고자이마스. 코치라노 세키에 도-조.", translation: "네, 있습니다. 이쪽 자리로 안내해 드릴게요.", isUserLine: false)
        ],
        14: [ // 식사 전 인사 (いただきます)
            ConversationData(speaker: "사토", text: "うわー、美味しそう！写真撮ってもいいですか？", romaji: "우와-, 오이시소-! 샤신 톳테모 이이데스카?", translation: "와, 맛있겠다! 사진 찍어도 돼요?", isUserLine: false),
            ConversationData(speaker: "나", text: "もちろんです。じゃあ、食べましょうか。いただきます。", romaji: "모치론데스. 쟈-, 타베마쇼-카. 이타다키마스.", translation: "물론이죠. 그럼, 먹을까요? 잘 먹겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、いただきます！", romaji: "하이, 이타다키마스!", translation: "네, 잘 먹겠습니다!", isUserLine: false)
        ],
        15: [ // 식사 후 인사 (ごちそうさまでした)
            ConversationData(speaker: "사토", text: "あー、お腹いっぱい。本当に美味しかったですね。", romaji: "아-, 오나카 잇파이. 혼토-니 오이시캇타데스네.", translation: "아, 배부르다. 정말 맛있었네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、また来たいです。ごちそうさまでした。", romaji: "에에, 마타 키타이데스. 고치소-사마데시타.", translation: "네, 또 오고 싶어요. 잘 먹었습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もです。ごちそうさまでした。", romaji: "와타시모데스. 고치소-사마데시타.", translation: "저도요. 잘 먹었습니다.", isUserLine: false)
        ],
        16: [ // 모름 표현 (わかりません)
            ConversationData(speaker: "사토", text: "この漢字の読み方、わかりますか？", romaji: "코노 칸지노 요미카타, 와카리마스카?", translation: "이 한자 읽는 법, 아세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、見たことはありますが、読み方はわかりません。", romaji: "스미마센, 미타코토와 아리마스가, 요미카타와 와카리마센.", translation: "죄송해요, 본 적은 있는데, 읽는 법은 모르겠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか。じゃあ、後で調べてみましょう。", romaji: "소-데스카. 쟈-, 아토데 시라베테미마쇼-.", translation: "그렇군요. 그럼, 나중에 찾아봐요.", isUserLine: false)
        ],
        17: [ // 재차 부탁 (もう一度お願いします)
            ConversationData(speaker: "사토", text: "明日の待ち合わせ時間は10時です。", romaji: "아시타노 마치아와세지칸와 쥬-지데스.", translation: "내일 약속 시간은 10시입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、電波が悪くて…。もう一度お願いします。", romaji: "스미마센, 덴파가 와루쿠테... 모- 이치도 오네가이시마스.", translation: "죄송합니다, 전파가 안 좋아서요... 다시 한번 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかりました。明日は、朝10時です。", romaji: "와카리마시타. 아시타와, 아사 쥬-지데스.", translation: "알겠습니다. 내일은, 아침 10시입니다.", isUserLine: false)
        ],
        18: [ // 천천히 말해달라고 부탁 (ゆっくりお願いします)
            ConversationData(speaker: "사토", text: "この道をまっすぐ行って、三つ目の角を右です。", romaji: "코노 미치오 맛스구 잇테, 밋츠메노 카도오 미기데스.", translation: "이 길로 쭉 가서, 세 번째 모퉁이에서 오른쪽입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、日本語がまだ下手で…。もう少しゆっくりお願いします。", romaji: "스미마센, 니혼고가 마다 헤타데... 모- 스코시 윳쿠리 오네가이시마스.", translation: "죄송합니다, 일본어가 아직 서툴러서요... 조금 더 천천히 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、失礼しました。この道を、まっすぐ…です。", romaji: "아아, 시츠레-시마시타. 코노 미치오, 맛스구...데스.", translation: "아, 실례했습니다. 이 길을, 똑바로... 가세요.", isUserLine: false)
        ],
        19: [ // 직장에서의 인사 (お疲れ様です)
            ConversationData(speaker: "사토", text: "お先に失礼します。お疲れ様です。", romaji: "오사키니 시츠레-시마스. 오츠카레사마데스.", translation: "먼저 실례하겠습니다. 수고하셨습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "お疲れ様です。気をつけて帰ってください。", romaji: "오츠카레사마데스. 키오츠케테 카엣테쿠다사이.", translation: "수고하셨습니다. 조심히 들어가세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ありがとうございます。また明日。", romaji: "하이, 아리가토-고자이마스. 마타 아시타.", translation: "네, 감사합니다. 내일 봬요.", isUserLine: false)
        ],
        20: [ // 자리를 뜨거나 들어갈 때 (失礼します)
            ConversationData(speaker: "사토", text: "そろそろ時間ですね。私はこれで失礼します。", romaji: "소로소로 지칸데스네. 와타시와 코레데 시츠레-시마스.", translation: "슬슬 시간이네요. 저는 이만 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。今日はお疲れ様でした。失礼します。", romaji: "하이. 쿄-와 오츠카레사마데시타. 시츠레-시마스.", translation: "네. 오늘 수고 많으셨습니다. 저도 실례하겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "お疲れ様でした。また連絡します。", romaji: "오츠카레사마데시타. 마타 렌라쿠시마스.", translation: "수고하셨습니다. 또 연락할게요.", isUserLine: false)
        ],
        21: [ // 이름 묻기 (名前を尋ねる)
            ConversationData(speaker: "사토", text: "先程はありがとうございました。まだ自己紹介がでしたね。", romaji: "사키호도와 아리가토- 고자이마시타. 마다 지코쇼-카이가데시타네.", translation: "아까는 감사했습니다. 아직 자기소개를 안 했네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。私はキムと申します。お名前は何ですか？", romaji: "소-데스네. 와타시와 기무토 모-시마스. 오나마에와 난데스카?", translation: "그렇네요. 저는 김이라고 합니다. 성함이 어떻게 되시나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "佐藤です。キムさん、どうぞよろしくお願いします。", romaji: "사토-데스. 기무상, 도-조 요로시쿠 오네가이시마스.", translation: "사토입니다. 김 씨, 부디 잘 부탁드립니다.", isUserLine: false)
        ],
        22: [ // 출신 밝히기 (出身を明かす)
            ConversationData(speaker: "사토", text: "キムさんは、どちらのご出身ですか？", romaji: "기무상와, 도치라노 고슛신데스카?", translation: "김 씨는 어디 출신이세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "私は韓国から来ました。", romaji: "와타시와 칸코쿠카라 키마시타.", translation: "저는 한국에서 왔습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね！だから日本語がお上手なんですね。", romaji: "소-난데스네! 다카라 니혼고가 오죠-즈난데스네.", translation: "그렇군요! 그래서 일본어를 잘하시는군요.", isUserLine: false)
        ],
        23: [ // 취미 묻기 (趣味を尋ねる)
            ConversationData(speaker: "사토", text: "キムさんはお休みの日は何をしているんですか？", romaji: "기무상와 오야스미노 히와 나니오 시테이룬데스카?", translation: "김 씨는 쉬는 날에 무엇을 하세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "私はよく散歩をします。佐藤さんの趣味は何ですか？", romaji: "와타시와 요쿠 산포오 시마스. 사토-상노 슈미와 난데스카?", translation: "저는 자주 산책을 해요. 사토 씨의 취미는 무엇인가요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "私は料理です。今度、手料理ご馳走しますよ。", romaji: "와타시와 료-리데스. 콘도, 테료-리 고치소-시마스요.", translation: "제 취미는 요리예요. 다음에 제 요리를 대접할게요.", isUserLine: false)
        ],
        24: [ // 추천 메뉴 묻기 (おすすめを尋ねる)
            ConversationData(speaker: "사토", text: "このお店、初めて来たけどメニューがたくさんありますね。", romaji: "코노 오미세, 하지메테 키타케도 메뉴-가 타쿠상 아리마스네.", translation: "이 가게, 처음 와봤는데 메뉴가 정말 많네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。すみません、おすすめは何ですか？", romaji: "혼토-데스네. 스미마센, 오스스메와 난데스카?", translation: "그러게요. 실례합니다, 추천 메뉴가 무엇인가요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "本日限定のパスタセットが一番人気ですよ。", romaji: "혼지츠 겐테-노 파스타셋토가 이치방 닌키데스요.", translation: "오늘 한정 파스타 세트가 가장 인기 있습니다.", isUserLine: false)
        ],
        25: [ // 계산 요청하기 (会計を頼む)
            ConversationData(speaker: "사토", text: "今日はごちそうさまでした。とても美味しかったです。", romaji: "쿄-와 고치소-사마데시타. 토테모 오이시캇타데스.", translation: "오늘은 잘 먹었습니다. 정말 맛있었어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。では、そろそろ行きましょうか。すみません、お会計お願いします。", romaji: "코치라코소. 데와, 소로소로 이키마쇼-카. 스미마센, 오카이케- 오네가이시마스.", translation: "저야말로요. 그럼, 슬슬 가볼까요? 실례합니다, 계산 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。合計で3千円になります。", romaji: "카시코마리마시타. 고-케-데 산젠엔니 나리마스.", translation: "알겠습니다. 합계 3,000엔입니다.", isUserLine: false)
        ],
        26: [ // 결제 수단 묻기 (支払い方法を尋ねる)
            ConversationData(speaker: "점원", text: "お会計は5千円です。", romaji: "오카이케-와 고센엔데스.", translation: "계산은 5,000엔입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、今、現金が足りなくて。カードで払えますか？", romaji: "스미마센, 이마, 겐킨가 타리나쿠테. 카-도데 하라에마스카?", translation: "죄송합니다, 지금 현금이 부족해서요. 카드로 계산할 수 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、もちろんご利用いただけます。", romaji: "하이, 모치론 고리요- 이타다케마스.", translation: "네, 물론 이용 가능합니다.", isUserLine: false)
        ],
        27: [ // 사진 촬영 허락받기 (写真撮影の許可を得る)
            ConversationData(speaker: "사토", text: "わあ、素敵な庭園ですね。", romaji: "와아, 스테키나 테-엔데스네.", translation: "와, 멋진 정원이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当に綺麗です。記念に、ここで写真を撮ってもいいですか？", romaji: "혼토-니 키레-데스. 키넨니, 코코데 샤신오 톳테모 이이데스카?", translation: "정말 아름다워요. 기념으로 여기서 사진 찍어도 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、もちろん。私が撮ってあげましょうか？", romaji: "에에, 모치론. 와타시가 톳테 아게마쇼-카?", translation: "네, 물론이죠. 제가 찍어드릴까요?", isUserLine: false)
        ],
        28: [ // 즐거웠다고 말하기 (楽しかったと伝える)
            ConversationData(speaker: "사토", text: "今日は一日、ありがとうございました。", romaji: "쿄-와 이치니치, 아리가토- 고자이마시타.", translation: "오늘 하루, 감사했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。遊園地なんて久しぶりで、本当に楽しかったです。", romaji: "코치라코소. 유-엔치난테 히사시부리데, 혼토-니 타노시캇타데스.", translation: "저야말로요. 놀이공원 같은 곳은 오랜만이라 정말 즐거웠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そう言ってもらえて嬉しいです。また行きましょうね。", romaji: "소- 잇테모라에테 우레시-데스. 마타 이키마쇼-네.", translation: "그렇게 말해주니 기쁘네요. 또 가요.", isUserLine: false)
        ],
        29: [ // 조심히 가라고 인사하기 (気をつけてと挨拶する)
            ConversationData(speaker: "사토", text: "では、私はこのバスに乗るので、ここで。", romaji: "데와, 와타시와 코노 바스니 노루노데, 코코데.", translation: "그럼 저는 이 버스를 타야 해서, 여기서 이만.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、分かりました。雨が降っているので、気をつけてくださいね。", romaji: "하이, 와카리마시타. 아메가 훗테이루노데, 키오츠케테 쿠다사이네.", translation: "네, 알겠습니다. 비가 오고 있으니 조심하세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "キムさんも。ありがとうございます。", romaji: "기무상모. 아리가토- 고자이마스.", translation: "김 씨도요. 감사합니다.", isUserLine: false)
        ],
        30: [ // 공감하며 위로하기 (共感して慰める)
            ConversationData(speaker: "사토", text: "最近、仕事が忙しくて、毎日残業なんです。", romaji: "사이킨, 시고토가 이소가시쿠테, 마이니치 잔교-난데스.", translation: "요즘 일이 바빠서 매일 야근이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうなんですか。毎日とは、それは大変ですね。", romaji: "소-난데스카. 마이니치토와, 소레와 타이헨데스네.", translation: "그러세요? 매일이라니, 그거 힘드시겠네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ。でも、このプロジェクトが終われば、少しは楽になるはずです。", romaji: "에에. 데모, 코노 프로제쿠토가 오와레바, 스코시와 라쿠니 나루하즈데스.", translation: "네. 그래도 이 프로젝트가 끝나면 좀 편해질 거예요.", isUserLine: false)
        ],
        31: [ // 안부 묻기 (様子を尋ねる)
            ConversationData(speaker: "사토", text: "はぁ…。", romaji: "하아...", translation: "하아...", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、元気がないですね。どうしましたか？", romaji: "사토-상, 겐키가 나이데스네. 도-시마시타카?", translation: "사토 씨, 기운이 없네요. 무슨 일 있어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ちょっと仕事でミスをしてしまって、部長に叱られました。", romaji: "좃토 시고토데 미스오 시테시맛테, 부쵸-니 시카라레마시타.", translation: "일하다가 실수를 좀 해서 부장님께 혼났어요.", isUserLine: false)
        ],
        32: [ // 괜찮은지 묻기 (安否を尋ねる)
            ConversationData(speaker: "사토", text: "咳が止まらないな…。", romaji: "세키가 토마라나이나...", translation: "기침이 멈추질 않네...", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫ですか？風邪ですか？", romaji: "다이죠-부데스카? 카제데스카?", translation: "괜찮아요? 감기예요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、昨日から少し熱があって。でも、薬を飲んだので大丈夫です。", romaji: "하이, 키노-카라 스코시 네츠가 앗테. 데모, 쿠스리오 논다노데 다이죠-부데스.", translation: "네, 어제부터 열이 좀 있어서요. 그래도 약 먹었으니 괜찮아요.", isUserLine: false)
        ],
        33: [ // 배고픔 표현 (空腹の表現)
            ConversationData(speaker: "사토", text: "もうすぐお昼ですね。", romaji: "모-스구 오히루데스네.", translation: "이제 곧 점심시간이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。なんだか、すごくお腹が空きました。", romaji: "소-데스네. 난다카, 스고쿠 오나카가 스키마시타.", translation: "그러게요. 왠지 엄청 배가 고파졌어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もです。今日はとんかつが食べたい気分です。", romaji: "와타시모데스. 쿄-와 통카츠가 타베타이 키분데스.", translation: "저도요. 오늘은 돈가스가 먹고 싶은 기분이에요.", isUserLine: false)
        ],
        34: [ // 목마름 표현 (喉の渇きの表現)
            ConversationData(speaker: "사토", text: "今日は天気が良くて、たくさん歩きましたね。", romaji: "쿄-와 텐키가 요쿠테, 타쿠상 아루키마시타네.", translation: "오늘은 날씨가 좋아서 많이 걸었네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、少し汗をかきました。喉が渇きましたね。", romaji: "에에, 스코시 아세오 카키마시타. 노도가 카와키마시타네.", translation: "네, 땀을 좀 흘렸어요. 목이 마르네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あそこの自販機で何か飲み物を買いましょうか。", romaji: "아소코노 지한키데 나니카 노미모노오 카이마쇼-카.", translation: "저기 자판기에서 뭐라도 마실 걸 살까요?", isUserLine: false)
        ],
        35: [ // 기대감 표현 (期待の表現)
            ConversationData(speaker: "사토", text: "じゃあ、来週の週末、一緒に旅行に行きましょう。", romaji: "쟈-, 라이슈-노 슈-마츠, 잇쇼니 료코-니 이키마쇼-.", translation: "그럼 다음 주 주말에 같이 여행 가요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですか？嬉しいです！楽しみにしています。", romaji: "혼토-데스카? 우레시-데스! 타노시미니 시테이마스.", translation: "정말요? 기뻐요! 기대하고 있을게요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もです。どこに行くか、一緒に計画を立てましょう。", romaji: "와타시모데스. 도코니 이쿠카, 잇쇼니 케-카쿠오 타테마쇼-.", translation: "저도요. 어디로 갈지 같이 계획 세워요.", isUserLine: false)
        ],
        36: [ // 먼저 퇴근할 때 인사 (先に帰る時の挨拶)
            ConversationData(speaker: "사토", text: "キムさん、まだ仕事残っていますか？私はこれで。", romaji: "기무상, 마다 시고토 노콧테이마스카? 와타시와 코레데.", translation: "김 씨, 아직 일 남았어요? 저는 이만.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。お先に失礼します。お疲れ様でした。", romaji: "하이. 오사키니 시츠레-시마스. 오츠카레사마데시타.", translation: "네. 먼저 실례하겠습니다. 수고하셨습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "お疲れ様でした。あまり無理しないでくださいね。", romaji: "오츠카레사마데시타. 아마리 무리시나이데 쿠다사이네.", translation: "수고하셨습니다. 너무 무리하지 마세요.", isUserLine: false)
        ],
        37: [ // 좋아하는 것 말하기 (好きなものを言う)
            ConversationData(speaker: "사토", text: "キムさんは、動物は好きですか？", romaji: "기무상와, 도-부츠와 스키데스카?", translation: "김 씨는 동물을 좋아해요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、大好きです。特に、猫が好きです。", romaji: "하이, 다이스키데스. 토쿠니, 네코가 스키데스.", translation: "네, 아주 좋아해요. 특히 고양이를 좋아해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね。私も猫を飼っていますよ。今度、写真見せますね。", romaji: "소-난데스네. 와타시모 네코오 캇테이마스요. 콘도, 샤신 미세마스네.", translation: "그렇군요. 저도 고양이 키우고 있어요. 다음에 사진 보여드릴게요.", isUserLine: false)
        ],
        38: [ // 싫어하는 것 말하기 (嫌いなものを言う)
            ConversationData(speaker: "사토", text: "このお店のサラダ、野菜が新鮮で美味しいですよ。", romaji: "코노 오미세노 사라다, 야사이가 신센데 오이시-데스요.", translation: "이 가게 샐러드, 채소가 신선하고 맛있어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうなんですね。でも、実は私、ピーマンが嫌いなんです。", romaji: "소-난데스네. 데모, 지츠와 와타시, 피-망가 키라이난데스.", translation: "그렇군요. 근데 실은 제가 피망을 싫어해서요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あら、そうでしたか。じゃあ、店員さんにピーマン抜きでお願いしてみましょうか。", romaji: "아라, 소-데시타카. 쟈-, 텐인상니 피-망누키데 오네가이시테 미마쇼-카.", translation: "어머, 그랬군요. 그럼 점원분께 피망을 빼달라고 부탁해 볼까요?", isUserLine: false)
        ],
        39: [ // 칭찬하기 (褒める)
            ConversationData(speaker: "사토", text: "キムさんの企画書、読みました。すごく分かりやすかったです。", romaji: "기무상노 키카쿠쇼, 요미마시타. 스고쿠 와카리야스캇타데스.", translation: "김 씨 기획서 읽어봤어요. 굉장히 이해하기 쉬웠어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、そんな…。でも、ありがとうございます。", romaji: "이에이에, 손나... 데모, 아리가토-고자이마스.", translation: "아니에요, 뭘요... 그래도 감사합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当に。特にグラフの使い方が、日本語が上手ですね。…じゃなくて、センスがいいですね！", romaji: "혼토-니. 토쿠니 구라후노 츠카이카타가, 니혼고가 죠-즈데스네. ...쟈나쿠테, 센스가 이이데스네!", translation: "정말이에요. 특히 그래프 사용법이, 일본어를 잘하시네요. ...가 아니라, 센스가 좋네요!", isUserLine: false)
        ],
        40: [ // 감탄하기 (感心する)
            ConversationData(speaker: "사토", text: "この間のN1試験、合格したんですよ。", romaji: "코노 아이다노 N1 시켄, 고-카쿠시탄데스요.", translation: "지난번 N1 시험, 합격했어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええっ、本当ですか？すごいですね！おめでとうございます！", romaji: "엣, 혼토-데스카? 스고이데스네! 오메데토- 고자이마스!", translation: "엣, 정말요? 대단하네요! 축하드려요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。毎日頑張って勉強した甲斐がありました。", romaji: "아리가토- 고자이마스. 마이니치 간밧테 벤쿄-시타 카이가 아리마시타.", translation: "고마워요. 매일 열심히 공부한 보람이 있었어요.", isUserLine: false)
        ],
        41: [ // 의견 묻기 (意見を尋ねる)
            ConversationData(speaker: "사토", text: "新しい企画についてですが、何か良いアイデアはありますか？", romaji: "아타라시이 키카쿠니 츠이테데스가, 나니카 이이 아이데아와 아리마스카?", translation: "새로운 기획에 대해서인데, 뭔가 좋은 아이디어 있나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね…コスト削減の観点から、A案が良いかと。佐藤さんはどう思いますか？", romaji: "소-데스네... 코스토 사쿠겐노 칸텐카라, 에-안가 이이카토. 사토-상와 도- 오모이마스카?", translation: "글쎄요… 비용 절감 관점에서 A안이 좋을 것 같은데. 사토 씨는 어떻게 생각하세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もA案に賛成です。一番現実的で、実行しやすいと思います。", romaji: "와타시모 에-안니 산세-데스. 이치반 겐지츠테키데, 짓코-시야스이토 오모이마스.", translation: "저도 A안에 찬성이에요. 가장 현실적이고 실행하기 쉽다고 생각해요.", isUserLine: false)
        ],
        42: [ // 동의하기 (同意する)
            ConversationData(speaker: "사토", text: "やっぱり、旅行は計画を立てている時が一番楽しいですね。", romaji: "얏파리, 료코-와 케-카쿠오 타테테이루 토키가 이치반 타노시이데스네.", translation: "역시 여행은 계획을 세울 때가 가장 즐거운 것 같아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、私もそう思います。どこに行こうか、何を食べるか考えるだけでわくわくします。", romaji: "에에, 와타시모 소- 오모이마스. 도코니 이코-카, 나니오 타베루카 칸가에루다케데 와쿠와쿠시마스.", translation: "네, 저도 그렇게 생각해요. 어디 갈지, 뭘 먹을지 생각하는 것만으로도 설레요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね！次の休みが待ち遠しいです。", romaji: "데스요네! 츠기노 야스미가 마치도-시-데스.", translation: "그쵸! 다음 휴가가 정말 기다려져요.", isUserLine: false)
        ],
        43: [ // 이유 묻기 (理由を尋ねる)
            ConversationData(speaker: "사토", text: "申し訳ありませんが、明日の飲み会は参加できなくなりました。", romaji: "모-시와케 아리마센가, 아시타노 노미카이와 산카데키나쿠 나리마시타.", translation: "죄송하지만, 내일 회식은 참석하기 어렵게 되었습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうなんですか、残念です。差し支えなければ、どうしてですか？", romaji: "소-난데스카, 잔넨데스. 사시츠카에 나케레바, 도-시테데스카?", translation: "그래요? 아쉽네요. 괜찮으시다면, 이유를 여쭤봐도 될까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "急な出張が入ってしまって。本当にすみません。", romaji: "큐-나 슛쵸-가 하잇테시맛테. 혼토-니 스미마센.", translation: "급한 출장이 잡혀서요. 정말 죄송합니다.", isUserLine: false)
        ],
        44: [ // 이해했을 때 반응 (理解した時の相槌)
            ConversationData(speaker: "사토", text: "このボタンを先に押さないと、電源が入らない仕組みなんです。", romaji: "코노 보탄오 사키니 오사나이토, 덴겐가 하이라나이 시쿠미난데스.", translation: "이 버튼을 먼저 누르지 않으면 전원이 들어오지 않는 구조예요.", isUserLine: false),
            ConversationData(speaker: "나", text: "なるほど。だからさっきから動かなかったんですね。", romaji: "나루호도. 다카라 삿키카라 우고카나캇탄데스네.", translation: "그렇군요. 그래서 아까부터 작동하지 않았던 거군요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい。もう一度やってみてください。", romaji: "하이. 모- 이치도 얏테미테 쿠다사이.", translation: "네. 다시 한번 해보세요.", isUserLine: false)
        ],
        45: [ // 축하하기 (お祝い)
            ConversationData(speaker: "사토", text: "キムさん、ご結婚おめでとうございます！", romaji: "기무상, 고켓콘 오메데토- 고자이마스!", translation: "김 씨, 결혼 축하해요!", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます！佐藤さんにそう言っていただけて嬉しいです。", romaji: "아리가토- 고자이마스! 사토-상니 소- 잇테이타다케테 우레시-데스.", translation: "감사합니다! 사토 씨가 그렇게 말해주시니 기뻐요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "とてもお似合いのカップルですね。末永くお幸せに。", romaji: "토테모 오니아이노 캇푸루데스네. 스에나가쿠 오시아와세니.", translation: "정말 잘 어울리는 커플이에요. 오래오래 행복하세요.", isUserLine: false)
        ],
        46: [ // 기쁨 표현 (嬉しい気持ちの表現)
            ConversationData(speaker: "사토", text: "この前のレポート、とても良く書けていましたよ。部長も褒めていました。", romaji: "코노 마에노 레포-토, 토테모 요쿠 카케테이마시타요. 부쵸-모 호메테이마시타.", translation: "지난번 보고서, 아주 잘 썼더군요. 부장님도 칭찬하셨어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですか？嬉しいです！頑張って作った甲斐がありました。", romaji: "혼토-데스카? 우레시-데스! 간밧테 츠쿳타 카이가 아리마시타.", translation: "정말요? 기쁩니다! 열심히 만든 보람이 있네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、その調子で頑張ってください。", romaji: "에에, 소노 쵸-시데 간밧테 쿠다사이.", translation: "네, 그런 식으로 계속 열심히 해주세요.", isUserLine: false)
        ],
        47: [ // 슬픔 표현 (悲しい気持ちの表現)
            ConversationData(speaker: "사토", text: "楽しみにしていた映画、公開が中止になったそうです。", romaji: "타노시미니 시테이타 에-가, 코-카이가 츄-시니 낫타소-데스.", translation: "기대하고 있던 영화, 개봉이 취소됐대요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええっ、そうなんですか。それはとても悲しいですね。", romaji: "엣, 소-난데스카. 소레와 토테모 카나시-데스네.", translation: "엣, 그래요? 그건 정말 슬프네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当に。ずっと待っていたのに…。", romaji: "혼토-니. 즛토 맛테이타노니...", translation: "정말로요. 계속 기다렸는데...", isUserLine: false)
        ],
        48: [ // 배부름 표현 (満腹の表現)
            ConversationData(speaker: "사토", text: "このお店はデザートも美味しいですよ。ケーキはいかがですか？", romaji: "코노 오미세와 데자-토모 오이시-데스요. 케-키와 이카가데스카?", translation: "이 가게는 디저트도 맛있어요. 케이크는 어떠세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、美味しそうですが、もうお腹がいっぱいです。", romaji: "우-응, 오이시소-데스가, 모- 오나카가 잇파이데스.", translation: "음, 맛있어 보이긴 하는데, 이제 배가 너무 불러요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか、残念。では、温かいお茶でも頼みましょうか。", romaji: "소-데스카, 잔넨. 데와, 아타타카이 오차데모 타노미마쇼-카.", translation: "그래요? 아쉽네요. 그럼 따뜻한 차라도 시킬까요?", isUserLine: false)
        ],
        49: [ // 흔쾌히 수락하기 (快く承諾する)
            ConversationData(speaker: "사토", text: "すみません、急な雨で…。申し訳ないのですが、駅まで傘に入れてもらえませんか？", romaji: "스미마센, 큐-나 아메데... 모-시와케 나이노데스가, 에키마데 카사니 이레테모라에마센카?", translation: "죄송합니다, 갑자기 비가 와서... 미안하지만 역까지 우산 좀 같이 써도 될까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "もちろん、いいですよ。どうぞ、こちらへ。", romaji: "모치론, 이이데스요. 도-조, 코치라에.", translation: "물론, 괜찮아요. 이쪽으로 들어오세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます！本当に助かります。", romaji: "아리가토- 고자이마스! 혼토-니 타스카리마스.", translation: "고맙습니다! 정말 살았어요.", isUserLine: false)
        ],
        50: [ // 함께 가자고 제안하기 (一緒に行こうと誘う)
            ConversationData(speaker: "사토", text: "仕事の帰り、新しくできたカフェに行ってみようと思うんです。", romaji: "시고토노 카에리, 아타라시쿠 데키타 카페니 잇테미요-토 오모운데스.", translation: "퇴근길에 새로 생긴 카페에 가보려고 해요.", isUserLine: false),
            ConversationData(speaker: "나", text: "あ、私も気になっていました。よかったら、一緒に行きませんか？", romaji: "아, 와타시모 키니낫테 이마시타. 요캇타라, 잇쇼니 이키마센카?", translation: "아, 저도 궁금했어요. 괜찮으시다면, 함께 가지 않을래요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ぜひ！では、仕事が終わったらロビーで会いましょう。", romaji: "제히! 데와, 시고토가 오왓타라 로비-데 아이마쇼-.", translation: "좋아요! 그럼 일 끝나고 로비에서 만나요.", isUserLine: false)
        ],
        51: [ // 말 걸기 - 声をかける
            ConversationData(speaker: "사토", text: "(집중해서 서류를 검토하고 있다)", romaji: "(집중해서 서류를 검토하고 있다)", translation: "(집중해서 서류를 검토하고 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、お忙しいところすみません。今、ちょっといいですか？", romaji: "사토-상, 오이소가시- 토코로 스미마센. 이마, 좃토 이이데스카?", translation: "사토 씨, 바쁘신 중에 죄송합니다. 지금 잠시 괜찮으세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、はい。大丈夫ですよ。どうしましたか？", romaji: "아, 하이. 다이죠-부데스요. 도-시마시타카?", translation: "아, 네. 괜찮아요. 무슨 일이세요?", isUserLine: false)
        ],
        52: [ // 기다리게 했을 때 - 待たせた時
            ConversationData(speaker: "사토", text: "(약속 장소에서 시계를 보며 서 있다)", romaji: "(약속 장소에서 시계를 보며 서 있다)", translation: "(약속 장소에서 시계를 보며 서 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん！すみません、お待たせしました！", romaji: "사토-상! 스미마센, 오마타세시마시타!", translation: "사토 씨! 죄송해요, 기다리셨죠!", isUserLine: true),
            ConversationData(speaker: "사토", text: "大丈夫ですよ。私も今来たところです。さあ、行きましょうか。", romaji: "다이죠-부데스요. 와타시모 이마 키타 토코로데스. 사-, 이키마쇼-카.", translation: "괜찮아요. 저도 방금 도착했어요. 자, 갈까요?", isUserLine: false)
        ],
        53: [ // 늦었을 때 사과 - 遅れた時の謝罪
            ConversationData(speaker: "사토", text: "キムさん、会議はもう始まっていますよ。", romaji: "기무상, 카이기와 모- 하지맛테이마스요.", translation: "김 씨, 회의는 이미 시작했어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "遅くなってすみません。事故で電車が遅れてしまって…。", romaji: "오소쿠낫테 스미마센. 지코데 덴샤가 오쿠레테시맛테...", translation: "늦어서 죄송합니다. 사고로 전철이 지연되는 바람에...", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですね。大変でしたね。とりあえず席についてください。", romaji: "소-닷탄데스네. 타이헨데시타네. 토리아에즈 세키니 츠이테쿠다사이.", translation: "그랬군요. 힘드셨겠네요. 일단 자리에 앉으세요.", isUserLine: false)
        ],
        54: [ // 격려하기 - 激励する
            ConversationData(speaker: "사토", text: "明日、日本語能力試験があるんです。少し自信がありません。", romaji: "아시타, 니혼고노-료쿠시켄가 아룬데스. 스코시 지신가 아리마센.", translation: "내일 일본어 능력 시험이 있어요. 자신이 좀 없네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうなんですね。今まで勉強してきたじゃないですか。頑張ってください！", romaji: "소-난데스네. 이마마데 벤쿄-시테키타쟈나이데스카. 간밧테쿠다사이!", translation: "그렇군요. 지금까지 공부해 왔잖아요. 힘내세요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ありがとうございます。最後まで諦めずに頑張ります。", romaji: "하이, 아리가토-고자이마스. 사이고마데 아키라메즈니 간바리마스.", translation: "네, 고맙습니다. 마지막까지 포기하지 않고 열심히 할게요.", isUserLine: false)
        ],
        55: [ // 도움 요청하기 - 助けを求める
            ConversationData(speaker: "사토", text: "(무거운 짐을 혼자 옮기려 애쓰며) うーん、これは一人じゃ無理かも…。", romaji: "우-응, 코레와 히토리쟈 무리카모...", translation: "으음, 이건 혼자선 무리일지도...", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、危ないですよ！すみません、誰か、助けてください！", romaji: "사토-상, 아부나이데스요! 스미마센, 다레카, 타스케테쿠다사이!", translation: "사토 씨, 위험해요! 실례합니다, 누가 좀 도와주세요!", isUserLine: true),
            ConversationData(speaker: "동료", text: "大丈夫ですか？私たちが手伝いますよ。", romaji: "다이죠-부데스카? 와타시타치가 테츠다이마스요.", translation: "괜찮으세요? 저희가 도와드릴게요.", isUserLine: false)
        ],
        56: [ // 가게를 나설 때 - 店を出る時
            ConversationData(speaker: "점원", text: "ご試着もできますので、お気軽にどうぞ。", romaji: "고시챠쿠모 데키마스노데, 오키가루니 도-조.", translation: "입어보실 수도 있으니 편하게 말씀해주세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。今日は時間がなくて…。とても素敵なので、また来ます。", romaji: "아리가토-고자이마스. 쿄-와 지칸가 나쿠테... 토테모 스테키나노데, 마타 키마스.", translation: "감사합니다. 오늘은 시간이 없어서요... 아주 멋져서 또 오겠습니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。またのご来店をお待ちしております。", romaji: "카시코마리마시타. 마타노 고라이텐오 오마치시테오리마스.", translation: "알겠습니다. 또 방문해 주시기를 기다리고 있겠습니다.", isUserLine: false)
        ],
        57: [ // 편하게 있도록 권유하기 - ゆっくりするように勧める
            ConversationData(speaker: "사토", text: "お邪魔します。わあ、とてもきれいなお部屋ですね。", romaji: "오자마시마스. 와아, 토테모 키레이나 오헤야데스네.", translation: "실례합니다. 와, 아주 예쁜 방이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。さあ、どうぞ座ってください。ごゆっくりどうぞ。", romaji: "아리가토-고자이마스. 사-, 도-조 스왓테쿠다사이. 고윳쿠리 도-조.", translation: "고맙습니다. 자, 앉으세요. 편히 계세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。では、お言葉に甘えさせていただきます。", romaji: "아리가토-고자이마스. 데와, 오코토바니 아마에사세테이타다키마스.", translation: "감사합니다. 그럼, 말씀대로 편히 있겠습니다.", isUserLine: false)
        ],
        58: [ // "저야말로요" 표현 - こちらこそ
            ConversationData(speaker: "사토", text: "今日は食事に誘ってくれて、ありがとうございました。", romaji: "쿄-와 쇼쿠지니 사솟테쿠레테, 아리가토-고자이마시타.", translation: "오늘 식사에 초대해줘서 고마웠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、こちらこそ。佐藤さんと話せて楽しかったです。", romaji: "이이에, 코치라코소. 사토-상토 하나세테 타노시캇타데스.", translation: "아니에요, 저야말로요. 사토 씨와 이야기할 수 있어서 즐거웠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もです。また、ぜひ。", romaji: "와타시모데스. 마타, 제히.", translation: "저도요. 또 봐요.", isUserLine: false)
        ],
        59: [ // 예약 요청 - 予約の依頼
            ConversationData(speaker: "점원", text: "はい、美容室「カミワザ」でございます。", romaji: "하이, 비요-시츠 「카미와자」데고자이마스.", translation: "네, 미용실 '카미와자'입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "もしもし、予約をお願いします。今週の土曜日の午後、空いていますか？", romaji: "모시모시, 요야쿠오 오네가이시마스. 콘슈-노 도요-비노 고고, 아이테이마스카?", translation: "여보세요, 예약을 부탁합니다. 이번 주 토요일 오후에 시간 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "土曜日の午後ですね。少々お待ちください…はい、3時でしたらご案内できます。", romaji: "도요-비노 고고데스네. 쇼-쇼- 오마치쿠다사이... 하이, 산지데시타라 고안나이데키마스.", translation: "토요일 오후 말씀이시죠. 잠시만 기다려주세요… 네, 3시라면 안내해 드릴 수 있습니다.", isUserLine: false)
        ],
        60: [ // 소요 시간 묻기 - 所要時間を尋ねる
            ConversationData(speaker: "안내원", text: "ただいま、大変混み合っておりまして、お待ちいただく必要がございます。", romaji: "타다이마, 타이헨 코미앗테오리마시테, 오마치이타다쿠 히츠요-가 고자이마스.", translation: "지금 매우 혼잡해서, 기다리셔야 합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですか。待ち時間はどのくらいかかりますか？", romaji: "소-데스카. 마치지칸와 도노쿠라이 카카리마스카?", translation: "그래요? 대기 시간은 어느 정도 걸릴까요?", isUserLine: true),
            ConversationData(speaker: "안내원", text: "おそらく20分から30分ほどかと存じます。", romaji: "오소라쿠 니짓푼카라 산짓푼호도카토 존지마스.", translation: "아마 20분에서 30분 정도 걸릴 것으로 생각됩니다.", isUserLine: false)
        ],
        61: [ // 확인받기 - 確認を求める
            ConversationData(speaker: "사토", text: "このアンケート用紙、記入をお願いします。", romaji: "코노 안케-토 요-시, 키뉴-오 오네가이시마스.", translation: "이 설문지, 작성을 부탁드립니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。ええと…このように書きました。すみません、これでいいですか？", romaji: "하이. 에-토... 코노요-니 카키마시타. 스미마센, 코레데 이이데스카?", translation: "네. 음... 이렇게 썼습니다. 실례합니다, 이걸로 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、拝見します。ええ、完璧です。ありがとうございます。", romaji: "하이, 하이켄시마스. 에에, 칸페키데스. 아리가토- 고자이마스.", translation: "네, 보겠습니다. 네, 완벽합니다. 감사합니다.", isUserLine: false)
        ],
        62: [ // 불확실한 긍정 - 不確かな肯定
            ConversationData(speaker: "사토", text: "明日の朝9時の会議、間に合いそうですか？", romaji: "아시타노 아사 쿠지노 카이기, 마니아이소-데스카?", translation: "내일 아침 9시 회의, 늦지 않겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、たぶん大丈夫です。今夜中に資料を完成させる予定です。", romaji: "하이, 타분 다이죠-부데스. 콘야쥬-니 시료-오 칸세-사세루 요테-데스.", translation: "네, 아마 괜찮을 거예요. 오늘 밤 안으로 자료를 완성할 예정입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "無理はしないでくださいね。手伝えることがあれば言ってください。", romaji: "무리와 시나이데 쿠다사이네. 테츠다에루 코토가 아레바 잇테쿠다사이.", translation: "너무 무리는 하지 마세요. 도울 일 있으면 말해주세요.", isUserLine: false)
        ],
        63: [ // 시착 요청 - 試着の依頼
            ConversationData(speaker: "점원", text: "こちらのワンピース、本日入荷したばかりですよ。", romaji: "코치라노 완피-스, 혼지츠 뉴-카시타 바카리데스요.", translation: "이 원피스, 오늘 막 들어온 상품이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "わあ、色がきれいですね。すみません、これ、試着してもいいですか？", romaji: "와아, 이로가 키레-데스네. 스미마센, 코레, 시챠쿠시테모 이이데스카?", translation: "와, 색이 예쁘네요. 실례합니다, 이거 입어봐도 될까요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、もちろんです。あちらの試着室をご利用ください。", romaji: "하이, 모치론데스. 아치라노 시챠쿠시츠오 고리요- 쿠다사이.", translation: "네, 물론입니다. 저쪽 탈의실을 이용해주세요.", isUserLine: false)
        ],
        64: [ // 다른 색상 문의 - 他の色の問い合わせ
            ConversationData(speaker: "점원", text: "このTシャツ、お客様によくお似合いですよ。", romaji: "코노 티-샤츠, 오캬쿠사마니 요쿠 오니아이데스요.", translation: "이 티셔츠, 손님께 아주 잘 어울리세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですか？ありがとうございます。デザインは気に入ったのですが、他の色はありませんか？", romaji: "소-데스카? 아리가토-고자이마스. 데자인와 키니잇타노데스가, 호카노 이로와 아리마센카?", translation: "그런가요? 감사합니다. 디자인은 마음에 드는데, 다른 색은 없나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、白とネイビーがございます。すぐにお持ちしますね。", romaji: "하이, 시로토 네이비-가 고자이마스. 스구니 오모치시마스네.", translation: "네, 흰색과 남색이 있습니다. 바로 가져다 드릴게요.", isUserLine: false)
        ],
        65: [ // 정중한 거절 - 丁寧な断り
            ConversationData(speaker: "점원", text: "お弁当、温めますか？", romaji: "오벤토-, 아타타메마스카?", translation: "도시락, 데워드릴까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、結構です。", romaji: "이이에, 켓코-데스.", translation: "아니요, 괜찮습니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。お箸はお使いになりますか？", romaji: "카시코마리마시타. 오하시오 오츠카이니 나리마스카?", translation: "알겠습니다. 젓가락은 사용하시겠습니까?", isUserLine: false)
        ],
        66: [ // 가장 가까운 역 묻기 - 最寄り駅を尋ねる
            ConversationData(speaker: "사토", text: "(지도를 보며) うーん、完全に道に迷いましたね。", romaji: "우-응, 칸젠니 미치니 마요이마시타네.", translation: "음, 완전히 길을 잃었네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、ちょっとお尋ねします。一番近い駅はどこですか？", romaji: "스미마센, 좃토 오타즈네시마스. 이치반 치카이 에키와 도코데스카?", translation: "실례합니다, 잠시 여쭙겠습니다. 가장 가까운 역은 어디인가요?", isUserLine: true),
            ConversationData(speaker: "행인", text: "この道をまっすぐ5分ほど歩くと、右手にありますよ。", romaji: "코노 미치오 맛스구 고훈호도 아루쿠토, 미기테니 아리마스요.", translation: "이 길로 똑바로 5분 정도 걸어가면 오른쪽에 있어요.", isUserLine: false)
        ],
        67: [ // 물건 주인 찾기 - 持ち主を探す
            ConversationData(speaker: "사토", text: "あれ、会議室に誰かの傘が置いてありますよ。", romaji: "아레, 카이기시츠니 다레카노 카사가 오이테 아리마스요.", translation: "어라, 회의실에 누군가의 우산이 놓여있네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。これは誰の傘ですか？忘れ物みたいですね。", romaji: "혼토-데스네. 코레와 다레노 카사데스카? 와스레모노 미타이데스네.", translation: "그러네요. 이건 누구 우산이죠? 분실물 같아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "デザインからして、鈴木さんのかもしれません。後で聞いてみましょう。", romaji: "데자인카라시테, 스즈키상노카모 시레마센. 아토데 키이테미마쇼-.", translation: "디자인을 보니 스즈키 씨 것일지도 모르겠어요. 나중에 물어보죠.", isUserLine: false)
        ],
        68: [ // 시간 맞출 수 있는지 묻기 - 間に合うか尋ねる
            ConversationData(speaker: "사토", text: "大変！映画、あと10分で始まっちゃう！", romaji: "타이헨! 에-가, 아토 쥿푼데 하지맛챠우!", translation: "큰일났다! 영화, 앞으로 10분 뒤에 시작해!", isUserLine: false),
            ConversationData(speaker: "나", text: "ええっ！今からタクシーを拾っても、間に合いますか？", romaji: "엣! 이마카라 타쿠시-오 히롯테모, 마니아이마스카?", translation: "엣! 지금부터 택시를 잡아도 시간에 맞출 수 있을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ギリギリかもしれないけど、急げばなんとかなるかも！走りましょう！", romaji: "기리기리카모 시레나이케도, 이소게바 난토카 나루카모! 하시리마쇼-!", translation: "아슬아슬할지도 모르지만, 서두르면 어떻게든 될지도 몰라! 뛰어요!", isUserLine: false)
        ],
        69: [ // 화장실 위치 묻기 - お手洗いの場所を尋ねる
            ConversationData(speaker: "사토", text: "食事が終わったら、少しデパートの中を見て回りませんか？", romaji: "쇼쿠지가 오왓타라, 스코시 데파-토노 나카오 미테 마와리마센카?", translation: "식사 끝나면 백화점 안을 좀 둘러보지 않을래요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいですね。その前にすみません、お手洗いはどこですか？", romaji: "이이데스네. 소노 마에니 스미마센, 오테아라이와 도코데스카?", translation: "좋아요. 그 전에 실례합니다만, 화장실은 어디인가요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "このフロアのエスカレーターの隣にありますよ。", romaji: "코노 후로아노 에스카레-타-노 토나리니 아리마스요.", translation: "이 층 에스컬레이터 옆에 있어요.", isUserLine: false)
        ],
        70: [ // 택시에서 내릴 때 - タクシーを降りる時
            ConversationData(speaker: "기사", text: "そろそろ住所のあたりですが、どこで停めますか？", romaji: "소로소로 쥬-쇼노 아타리데스가, 도코데 토메마스카?", translation: "슬슬 주소 근처인데, 어디에 세울까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "あの信号を越えた、最初の角でお願いします。…あ、はい、ここで降ろしてください。", romaji: "아노 신고-오 코에타, 사이쇼노 카도데 오네가이시마스. ...아, 하이, 코코데 오로시테 쿠다사이.", translation: "저 신호를 지난 첫 번째 모퉁이에서 부탁합니다. …아, 네, 여기서 내려주세요.", isUserLine: true),
            ConversationData(speaker: "기사", text: "はい、かしこまりました。", romaji: "하이, 카시코마리마시타.", translation: "네, 알겠습니다.", isUserLine: false)
        ],
        71: [ // 전화 받을 때 - 電話に出る時
            ConversationData(speaker: "사토", text: "(전화벨이 울린다)", romaji: "(전화벨이 울린다)", translation: "(전화벨이 울린다)", isUserLine: false),
            ConversationData(speaker: "나", text: "もしもし、キムです。", romaji: "모시모시, 기무데스.", translation: "여보세요, 김입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、キムさん？私、佐藤です。今、大丈夫ですか？", romaji: "아, 기무상? 와타시, 사토-데스. 이마, 다이죠-부데스카?", translation: "아, 김 씨? 저, 사토예요. 지금 괜찮으세요?", isUserLine: false)
        ],
        72: [ // 특정 인물과 통화 요청 - 特定の人との通話を頼む
            ConversationData(speaker: "접수원", text: "はい、〇〇商事でございます。", romaji: "하이, 마루마루 쇼-지데 고자이마스.", translation: "네, ㈜OO상사입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "私、△△会社のキムと申します。恐れ入りますが、営業部の鈴木さんをお願いします。", romaji: "와타시, 산카쿠산카쿠 가이샤노 기무토 모-시마스. 오소레이리마스가, 에-교-부노 스즈키상오 오네가이시마스.", translation: "저는 △△회사의 김이라고 합니다. 죄송하지만, 영업부의 스즈키 씨를 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "접수원", text: "鈴木ですね。少々お待ちください。", romaji: "스즈키데스네. 쇼-쇼- 오마치쿠다사이.", translation: "스즈키 말씀이시죠. 잠시만 기다려주십시오.", isUserLine: false)
        ],
        73: [ // 상대방 신원 묻기 - 相手の身元を尋ねる
            ConversationData(speaker: "나", text: "(전화를 받으며) はい、キムですが。", romaji: "하이, 기무데스가.", translation: "네, 김입니다만.", isUserLine: true),
            ConversationData(speaker: "나", text: "恐れ入りますが、どちら様ですか？", romaji: "오소레이리마스가, 도치라사마데스카?", translation: "죄송합니다만, 누구시죠?", isUserLine: true),
            ConversationData(speaker: "상대방", text: "申し訳ありません。私、ABC配送の田中と申します。", romaji: "모-시와케 아리마센. 와타시, 에-비-시-하이소-노 타나카토 모-시마스.", translation: "죄송합니다. 저는 ABC 배송의 다나카라고 합니다.", isUserLine: false)
        ],
        74: [ // 다시 써달라고 부탁 - 書き直しを頼む
            ConversationData(speaker: "사토", text: "(메모를 보여주며) これが新しい住所です。", romaji: "코레가 아타라시- 쥬-쇼데스.", translation: "이것이 새 주소입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、字が少し読みにくくて…。もう一度、書いてください。", romaji: "스미마센, 지가 스코시 요미니쿠쿠테... 모- 이치도, 카이테 쿠다사이.", translation: "죄송합니다, 글씨를 조금 알아보기 힘들어서... 다시 한번 써주시겠어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、失礼しました。もっと大きく書きますね。", romaji: "아아, 시츠레-시마시타. 못토 오-키쿠 카키마스네.", translation: "아, 실례했습니다. 더 크게 쓰겠습니다.", isUserLine: false)
        ],
        75: [ // 사물의 이름 묻기 - 物の名前を尋ねる
            ConversationData(speaker: "사토", text: "この公園、色々な花が咲いていてきれいですね。", romaji: "코노 코-엔, 이로이로나 하나가 사이테이테 키레-데스네.", translation: "이 공원, 여러 가지 꽃이 펴서 예쁘네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。あ、あのピンクの花、とても可愛い。これは何という花ですか？", romaji: "혼토-데스네. 아, 아노 핀쿠노 하나, 토테모 카와이-. 코레와 난토 이우 하나데스카?", translation: "그러게요. 아, 저 분홍색 꽃, 정말 귀여워요. 이건 뭐라고 하는 꽃이에요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あれはコスモスですよ。秋の代表的な花です。", romaji: "아레와 코스모스데스요. 아키노 다이효-테키나 하나데스.", translation: "저건 코스모스예요. 가을의 대표적인 꽃이죠.", isUserLine: false)
        ],
        76: [ // 잘 모르겠다고 표현 - よく分からないと表現
            ConversationData(speaker: "사토", text: "新しいパソコンのセットアップ方法、わかりますか？", romaji: "아타라시- 파소콘노 셋토앗푸 호-호-, 와카리마스카?", translation: "새 컴퓨터 설정 방법, 아세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、説明書を読みましたが、専門用語が多くてよく分かりません。", romaji: "우-응, 세츠메-쇼오 요미마시타가, 센몬요-고가 오-쿠테 요쿠 와카리마센.", translation: "음, 설명서를 읽어봤지만 전문 용어가 많아서 잘 모르겠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね。私もです。詳しい人を呼んでみましょう。", romaji: "데스요네. 와타시모데스. 쿠와시- 히토오 욘데미마쇼-.", translation: "그렇죠? 저도 그래요. 잘 아는 사람을 불러봅시다.", isUserLine: false)
        ],
        77: [ // 연락처 묻기 - 連絡先を尋ねる
            ConversationData(speaker: "사토", text: "今日はありがとうございました。またぜひお会いしたいです。", romaji: "쿄-와 아리가토-고자이마시타. 마타 제히 오아이시타이데스.", translation: "오늘은 감사했습니다. 또 꼭 뵙고 싶습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。よろしければ、連絡先を教えてください。", romaji: "코치라코소. 요로시케레바, 렌라쿠사키오 오시에테쿠다사이.", translation: "저야말로요. 괜찮으시다면 연락처를 알려주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "もちろんです。これが私の名刺です。", romaji: "모치론데스. 코레가 와타시노 메-시데스.", translation: "물론이죠. 이것이 제 명함입니다.", isUserLine: false)
        ],
        78: [ // 현금 결제 표현 - 現金払いの表現
            ConversationData(speaker: "점원", text: "お会計、2500円です。カードはお使いになりますか？", romaji: "오카이케-, 니센고햐쿠엔데스. 카-도와 오츠카이니 나리마스카?", translation: "계산, 2500엔입니다. 카드를 사용하시겠습니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、現金で払います。", romaji: "이이에, 겐킨데 하라이마스.", translation: "아니요, 현금으로 낼게요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、3000円、お預かりします。", romaji: "카시코마리마시타. 데와, 산젠엔, 오아즈카리시마스.", translation: "알겠습니다. 그럼 3000엔 받겠습니다.", isUserLine: false)
        ],
        79: [ // 영수증 요청 - 領収書の依頼
            ConversationData(speaker: "점원", text: "500円のお返しです。ありがとうございました。", romaji: "고햐쿠엔노 오카에시데스. 아리가토-고자이마시타.", translation: "500엔 거스름돈입니다. 감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、領収書をください。", romaji: "스미마센, 료-슈-쇼오 쿠다사이.", translation: "죄송하지만, 영수증을 주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、かしこまりました。お宛名はどうなさいますか？", romaji: "하이, 카시코마리마시타. 오아테나와 도-나사이마스카?", translation: "네, 알겠습니다. 받으시는 분 성함은 어떻게 해드릴까요?", isUserLine: false)
        ],
        80: [ // 시간이 다 됐다고 말하기 - 時間切れを告げる
            ConversationData(speaker: "사토", text: "この件について、もっと議論が必要ですね。", romaji: "코노 켄니 츠이테, 못토 기론가 히츠요-데스네.", translation: "이 건에 대해서는 좀 더 논의가 필요하겠네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。しかし、申し訳ありませんが、そろそろ時間です。", romaji: "소-데스네. 시카시, 모-시와케 아리마센가, 소로소로 지칸데스.", translation: "그렇네요. 하지만 죄송하지만, 슬슬 시간이 다 되었습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、本当ですね。では、続きはまた明日にしましょう。", romaji: "아, 혼토-데스네. 데와, 츠즈키와 마타 아시타니 시마쇼-.", translation: "아, 그러네요. 그럼 다음 이야기는 내일 하도록 하죠.", isUserLine: false)
        ],
        81: [ // 계산하겠다고 말하기 - 自分が払うと申し出る
            ConversationData(speaker: "사토", text: "今日は楽しかったです。食事代、割り勘にしましょう。", romaji: "쿄-와 타노시캇타데스. 쇼쿠지다이, 와리칸니 시마쇼-.", translation: "오늘 즐거웠어요. 식사비는 각자 나눠서 내요.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、今日は私がご馳走します。いつもお世話になっていますから。", romaji: "이이에, 쿄-와 와타시가 고치소-시마스. 이츠모 오세와니 낫테이마스카라.", translation: "아니에요, 오늘은 제가 대접할게요. 항상 신세 지고 있으니까요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そんな、悪いですよ。", romaji: "손나, 와루이데스요.", translation: "아유, 미안하게 왜 그러세요.", isUserLine: false)
        ],
        82: [ // 의미 묻기 - 意味を尋ねる
            ConversationData(speaker: "사토", text: "この件は「ケースバイケース」で対応しましょう。", romaji: "코노 켄와 「케-스 바이 케-스」데 타이오-시마쇼-.", translation: "이 건은 '케이스 바이 케이스'로 대응합시다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、勉強不足で。「ケースバイケース」とは、どういう意味ですか？", romaji: "스미마센, 벤쿄-부소쿠데. 「케-스 바이 케-스」토와, 도-이우 이미데스카?", translation: "죄송합니다, 제가 공부가 부족해서요. '케이스 바이 케이스'라는 건 무슨 의미인가요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、状況によって対応を変える、という意味ですよ。", romaji: "아아, 죠-쿄-니 욧테 타이오-오 카에루, 토이우 이미데스요.", translation: "아, 상황에 따라 대응을 바꾼다는 의미예요.", isUserLine: false)
        ],
        83: [ // 가고 싶은 장소 말하기 - 行きたい場所を言う
            ConversationData(speaker: "사토", text: "今度の週末、どこか行きたいところはありますか？", romaji: "콘도노 슈-마츠, 도코카 이키타이 토코로와 아리마스카?", translation: "이번 주말에 어디 가고 싶은 곳 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね…。最近、海を見ていないので、海辺のカフェに行きたいです。", romaji: "소-데스네... 사이킨, 우미오 미테이나이노데, 우미베노 카페니 이키타이데스.", translation: "글쎄요... 요즘 바다를 못 봐서, 바닷가 카페에 가고 싶어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "いいですね！じゃあ、景色のいいカフェを探してみましょう。", romaji: "이이데스네! 쟈-, 케시키노 이이 카페오 사가시테미마쇼-.", translation: "좋네요! 그럼 경치 좋은 카페를 찾아봐요.", isUserLine: false)
        ],
        84: [ // 길을 잃었을 때 - 道に迷った時
            ConversationData(speaker: "사토", text: "あれ？この景色、さっきも見たような…。", romaji: "아레? 코노 케시키, 삿키모 미타요-나...", translation: "어라? 이 풍경, 아까도 본 것 같은데...", isUserLine: false),
            ConversationData(speaker: "나", text: "もしかして、私たち、道に迷いましたか？", romaji: "모시카시테, 와타시타치, 미치니 마요이마시타카?", translation: "혹시, 우리, 길을 잃었나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そのようですね。すみませんが、スマートフォンで地図を確認してもらえますか？", romaji: "소노요-데스네. 스미마센가, 스마-토폰데 치즈오 카쿠닌시테모라에마스카?", translation: "그런 것 같네요. 미안하지만 스마트폰으로 지도 좀 확인해 줄래요?", isUserLine: false)
        ],
        85: [ // 버스 행선지 묻기 - バスの行き先を尋ねる
            ConversationData(speaker: "사토", text: "次に来るバスは5番ですね。", romaji: "츠기니 쿠루 바스와 고반데스네.", translation: "다음에 오는 버스는 5번이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、運転手さん。このバスは新宿に行きますか？", romaji: "스미마센, 운텐슈상. 코노 바스와 신주쿠니 이키마스카?", translation: "실례합니다, 기사님. 이 버스는 신주쿠에 가나요?", isUserLine: true),
            ConversationData(speaker: "기사", text: "はい、終点が新宿駅ですよ。", romaji: "하이, 슈-텐가 신주쿠에키데스요.", translation: "네, 종점이 신주쿠역입니다.", isUserLine: false)
        ],
        86: [ // 알레르기 정보 알리기 - アレルギー情報を伝える
            ConversationData(speaker: "점원", text: "ご注文は以上でよろしいですか？", romaji: "고츄-몬와 이죠-데 요로시-데스카?", translation: "주문은 이상으로 괜찮으신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。すみません、一つお願いがあるのですが、私、そばアレルギーがあります。", romaji: "하이. 스미마센, 히토츠 오네가이가 아루노데스가, 와타시, 소바 아레루기-가 아리마스.", translation: "네. 죄송하지만, 한 가지 부탁이 있는데, 제가 메밀 알레르기가 있습니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、こちらの料理にはそば粉が使われていないか、厨房に確認しますね。", romaji: "카시코마리마시타. 데와, 코치라노 료-리니와 소바코가 츠카와레테이나이카, 츄-보-니 카쿠닌시마스네.", translation: "알겠습니다. 그럼 이 요리에 메밀가루가 사용되었는지 주방에 확인하겠습니다.", isUserLine: false)
        ],
        87: [ // 잠시 기다려 달라고 할 때 - 少し待ってほしい時
            ConversationData(speaker: "사토", text: "キムさん、この件について、今すぐ結論を出せますか？", romaji: "기무상, 코노 켄니 츠이테, 이마스구 케츠론오 다세마스카?", translation: "김 씨, 이 건에 대해 지금 바로 결론을 낼 수 있나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "申し訳ありません、もう少し考える時間が欲しいです。少々お待ちください。", romaji: "모-시와케 아리마센, 모-스코시 칸가에루 지칸가 호시-데스. 쇼-쇼- 오마치쿠다사이.", translation: "죄송합니다, 조금 더 생각할 시간이 필요합니다. 잠시만 기다려 주십시오.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかりました。では、今日の午後までにお願いします。", romaji: "와카리마시타. 데와, 쿄-노 고고마데니 오네가이시마스.", translation: "알겠습니다. 그럼 오늘 오후까지 부탁합니다.", isUserLine: false)
        ],
        88: [ // 귀가 인사 - 帰宅の挨拶
            ConversationData(speaker: "아내", text: "(현관문 열리는 소리)", romaji: "현관문 열리는 소리", translation: "현관문 열리는 소리", isUserLine: false),
            ConversationData(speaker: "나", text: "ただいま。", romaji: "타다이마.", translation: "다녀왔습니다.", isUserLine: true),
            ConversationData(speaker: "아내", text: "おかえりなさい。今日もお疲れ様でした。", romaji: "오카에리나사이. 쿄-모 오츠카레사마데시타.", translation: "어서 와요. 오늘도 수고 많았어요.", isUserLine: false)
        ],
        89: [ // 귀가한 사람을 맞이하는 인사 - 帰宅した人を迎える挨拶
            ConversationData(speaker: "나", text: "ただいまー。", romaji: "타다이마-.", translation: "다녀왔습니다~", isUserLine: false),
            ConversationData(speaker: "나", text: "おかえりなさい。ご飯、できてますよ。", romaji: "오카에리나사이. 고항, 데키테마스요.", translation: "어서 와요. 밥 다 됐어요.", isUserLine: true),
            ConversationData(speaker: "남편", text: "本当？ありがとう！お腹すいたよ。", romaji: "혼토-? 아리가토-! 오나카 스이타요.", translation: "정말? 고마워! 배고팠어.", isUserLine: false)
        ],
        90: [ // 남의 집 방문 시 인사 - 他人の家を訪問する時の挨拶
            ConversationData(speaker: "사토", text: "(초인종 소리) ピンポーン。", romaji: "초인종 소리) 핑퐁-", translation: "초인종 소리", isUserLine: false),
            ConversationData(speaker: "나", text: "(문을 열며) はい、どうぞ。いらっしゃい。", romaji: "하이, 도-조. 이랏샤이.", translation: "네, 들어오세요. 어서 와요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "こんにちは、お邪魔します。", romaji: "콘니치와, 오자마시마스.", translation: "안녕하세요, 실례합니다.", isUserLine: false)
        ],
        91: [ // 방문 후 떠날 때 인사 - 訪問先から帰る時の挨拶
            ConversationData(speaker: "사토", text: "今日は招待してくれてありがとうございました。とても楽しかったです。", romaji: "쿄-와 쇼-타이시테쿠레테 아리가토-고자이마시타. 토테모 타노시캇타데스.", translation: "오늘 초대해줘서 고마웠어요. 정말 즐거웠어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ、来てくれて嬉しかったです。またいつでも遊びに来てください。", romaji: "코치라코소, 키테쿠레테 우레시캇타데스. 마타 이츠데모 아소비니 키테쿠다사이.", translation: "저야말로, 와줘서 기뻤어요. 언제든지 또 놀러오세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい！では、長々と失礼しました。お邪魔しました。", romaji: "하이! 데와, 나가나가토 시츠레-시마시타. 오자마시마시타.", translation: "네! 그럼, 오랫동안 실례했습니다.", isUserLine: false)
        ],
        92: [ // 칭찬에 대한 겸손한 부정 - 褒め言葉への謙遜
            ConversationData(speaker: "사토", text: "キムさんの作る料理はいつも美味しいですね。お店みたいです。", romaji: "기무상노 츠쿠루 료-리와 이츠모 오이시-데스네. 오미세미타이데스.", translation: "김 씨가 만든 요리는 항상 맛있어요. 가게 같아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そんなことないです。ただの趣味ですよ。", romaji: "손나코토나이데스. 타다노 슈미데스요.", translation: "그렇지 않아요. 그냥 취미인걸요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "謙遜しなくてもいいのに。本当に上手ですよ。", romaji: "켄손시나쿠테모 이이노니. 혼토-니 죠-즈데스요.", translation: "겸손하지 않아도 되는데. 정말 잘해요.", isUserLine: false)
        ],
        93: [ // 음식 권하기 - 食べ物を勧める
            ConversationData(speaker: "사토", text: "わあ、たくさんご馳走が並んでいますね。", romaji: "와아, 타쿠상 고치소-가 나란데이마스네.", translation: "와, 맛있는 음식이 잔뜩 차려져 있네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "今日は腕によりをかけて作りました。さあ、遠慮なさらずに、どうぞ、召し上がってください。", romaji: "쿄-와 우데니 요리오 카케테 츠쿠리마시타. 사-, 엔료나사라즈니, 도-조, 메시갓테쿠다사이.", translation: "오늘은 솜씨를 발휘해서 만들었어요. 자, 사양하지 마시고, 어서 드세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。では、いただきます。", romaji: "아리가토-고자이마스. 데와, 이타다키마스.", translation: "감사합니다. 그럼 잘 먹겠습니다.", isUserLine: false)
        ],
        94: [ // 아침 안부 인사 - 朝の安否の挨拶
            ConversationData(speaker: "사토", text: "キムさん、おはようございます。", romaji: "기무상, 오하요-고자이마스.", translation: "김 씨, 좋은 아침이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "おはようございます。昨日の夜は、よく眠れましたか？", romaji: "오하요-고자이마스. 키노-노 요루와, 요쿠 네무레마시타카?", translation: "좋은 아침이에요. 어젯밤에는 잘 주무셨어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、おかげさまでぐっすりです。キムさんもよく眠れましたか？", romaji: "하이, 오카게사마데 굿스리데스. 기무상모 요쿠 네무레마시타카?", translation: "네, 덕분에 푹 잤어요. 김 씨도 잘 주무셨어요?", isUserLine: false)
        ],
        95: [ // 덕분이라고 답하기 - おかげさまと答える
            ConversationData(speaker: "사토", text: "この間のプロジェクト、大成功だったそうですね。おめでとうございます。", romaji: "코노 아이다노 프로제쿠토, 다이세-코-닷타소-데스네. 오메데토-고자이마스.", translation: "지난번 프로젝트, 대성공이었다면서요. 축하합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。これもチームの皆さんのおかげさまです。", romaji: "아리가토-고자이마스. 코레모 치-무노 미나상노 오카게사마데스.", translation: "감사합니다. 이것도 팀 여러분 덕분입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "キムさんのリーダーシップがあったからですよ。", romaji: "기무상노 리-다-싯푸가 앗타카라데스요.", translation: "김 씨의 리더십이 있었기 때문이죠.", isUserLine: false)
        ],
        96: [ // 변함없다고 말하기 - 相変わらずだと答える
            ConversationData(speaker: "사토", text: "キムさん、お久しぶりです。最近、どうですか？", romaji: "기무상, 오히사시부리데스. 사이킨, 도-데스카?", translation: "김 씨, 오랜만이네요. 요즘 어때요?", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さんこそ、お元気そうで何よりです。私は相変わらずです。忙しい毎日です。", romaji: "사토-상코소, 오겐키소-데 나니요리데스. 와타시와 아이카와라즈데스. 이소가시- 마이니치데스.", translation: "사토 씨야말로 건강해 보여서 다행이네요. 저는 변함없어요. 바쁜 매일입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "お互い、体には気をつけましょうね。", romaji: "오타가이, 카라다니와 키오츠케마쇼-네.", translation: "우리 서로 몸은 챙깁시다.", isUserLine: false)
        ],
        97: [ // 자리를 뜰 것을 제안 - 席を立つことを提案
            ConversationData(speaker: "사토", text: "時計を見たら、もう10時ですね。", romaji: "토케-오 미타라, 모- 쥬-지데스네.", translation: "시계를 보니 벌써 10시네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。楽しい時間はあっという間です。では、そろそろ行きましょうか。", romaji: "혼토-데스네. 타노시- 지칸와 앗토이우마데스. 데와, 소로소로 이키마쇼-카.", translation: "그러게요. 즐거운 시간은 눈 깜짝할 사이네요. 그럼, 슬슬 갈까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですね。名残惜しいですが、また会いましょう。", romaji: "소-데스네. 나고리오시-데스가, 마타 아이마쇼-.", translation: "그러죠. 아쉽지만 또 만나요.", isUserLine: false)
        ],
        98: [ // 오랜만에 만났을 때의 정중한 인사 - 久しぶりの丁寧な挨拶
            ConversationData(speaker: "고객사", text: "ああ、これはキムさん。しばらくでした。", romaji: "아아, 코레와 기무상. 시바라쿠데시타.", translation: "아아, 이거 김 씨 아니십니까. 오랜만입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "部長。大変ご無沙汰しております。お変わりなくお元気そうで何よりです。", romaji: "부쵸-. 타이헨 고부사타시테오리마스. 오카와리나쿠 오겐키소-데 나니요리데스.", translation: "부장님. 정말 오랜만입니다. 변함없이 건강해 보이셔서 다행입니다.", isUserLine: true),
            ConversationData(speaker: "고객사", text: "キムさんこそ、ますますご活躍のご様子で。", romaji: "기무상코소, 마스마스 고카츠야쿠노 고요-스데.", translation: "김 씨야말로 더욱더 활약하고 계신 것 같군요.", isUserLine: false)
        ],
        99: [ // 아픈 사람에게 하는 인사 - 病気の人への挨拶
            ConversationData(speaker: "사토", text: "すみません、熱があるので、今日は早退させていただけますか。", romaji: "스미마센, 네츠가 아루노데, 쿄-와 소-타이사세테이타다케마스카.", translation: "죄송합니다, 열이 있어서 오늘은 조퇴해도 될까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "もちろんです。大丈夫ですか？病院には行きましたか？無理せず、お大事に。", romaji: "모치론데스. 다이죠-부데스카? 뵤-인니와 이키마시타카? 무리세즈, 오다이지니.", translation: "물론이죠. 괜찮아요? 병원에는 갔어요? 무리하지 말고, 몸조리 잘 하세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ありがとうございます。", romaji: "하이, 아리가토-고자이마스.", translation: "네, 감사합니다.", isUserLine: false)
        ],
        100: [ // 앞으로의 관계를 부탁하는 인사 - 今後の関係を願う挨拶
            ConversationData(speaker: "사토", text: "以上で、私の自己紹介を終わります。", romaji: "이죠-데, 와타시노 지코쇼-카이오 오와리마스.", translation: "이상으로 제 자기소개를 마치겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "素晴らしい発表でした。未熟者ですが、これからどうぞよろしくお願いします。", romaji: "스바라시- 핫표-데시타. 미주쿠모노데스가, 코레카라 도-조 요로시쿠 오네가이시마스.", translation: "훌륭한 발표였습니다. 미숙하지만, 앞으로 부디 잘 부탁드립니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "こちらこそ、よろしくお願いします。一緒に頑張りましょう。", romaji: "코치라코소, 요로시쿠 오네가이시마스. 잇쇼니 간바리마쇼-.", translation: "저야말로 잘 부탁드립니다. 함께 힘내요.", isUserLine: false)
        ],
        101: [ // 물건 가리키며 구매 요청 - 指差して購入を頼む
            ConversationData(speaker: "점원", text: "いらっしゃいませ。何かお探しですか？", romaji: "이랏샤이마세. 나니카 오사가시데스카?", translation: "어서 오세요. 무엇을 찾으시나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "あの棚の上にある、赤い箱のやつ。これをください。", romaji: "아노 타나노 우에니 아루, 아카이 하코노 야츠. 코레오 쿠다사이.", translation: "저 선반 위에 있는, 빨간 상자요. 이걸로 주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、かしこまりました。新しいものをお出ししますね。", romaji: "하이, 카시코마리마시타. 아타라시- 모노오 오다시시마스네.", translation: "네, 알겠습니다. 새것으로 꺼내 드릴게요.", isUserLine: false)
        ],
        102: [ // 멀리 있는 물건 보여달라고 요청 - 遠い物を見せてと頼む
            ConversationData(speaker: "점원", text: "こちらのショーケースの中は、いかがですか？", romaji: "코치라노 쇼-케-스노 나카와, 이카가데스카?", translation: "이쪽 쇼케이스 안은 어떠신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね…一番奥にある、あの青い皿、あれを見せてください。", romaji: "소-데스네... 이치방 오쿠니 아루, 아노 아오이 사라, 아레오 미세테쿠다사이.", translation: "글쎄요… 가장 안쪽에 있는, 저 파란 접시, 저것을 보여주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、かしこまりました。少々お待ちください。", romaji: "하이, 카시코마리마시타. 쇼-쇼- 오마치쿠다사이.", translation: "네, 알겠습니다. 잠시만 기다려주십시오.", isUserLine: false)
        ],
        103: [ // 추가 주문 - 追加注文
            ConversationData(speaker: "사토", text: "この唐揚げ、美味しいですね。", romaji: "코노 카라아게, 오이시-데스네.", translation: "이 가라아게, 맛있네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。すみません、これ、もう一つください。", romaji: "혼토-데스네. 스미마센, 코레, 모- 히토츠 쿠다사이.", translation: "그러게요. 실례합니다, 이거 하나 더 주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、喜んで！", romaji: "하이, 요로콘데!", translation: "네, 기꺼이 가져다드리겠습니다!", isUserLine: false)
        ],
        104: [ // 둘 중 선택 묻기 - 二つのうち、どちらかを選ぶよう尋ねる
            ConversationData(speaker: "사토", text: "赤いネクタイと青いネクタイ、どっちが父の日のプレゼントにいいかな？", romaji: "아카이 네쿠타이토 아오이 네쿠타이, 돗치가 치치노 히노 프레젠토니 이이카나?", translation: "빨간 넥타이랑 파란 넥타이, 어느 쪽이 아버지날 선물로 좋을까?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、どっちも素敵ですね。お父さんの好みは、どちらがいいですか？", romaji: "우-응, 돗치모 스테키데스네. 오토-상노 코노미와, 도치라가 이이데스카?", translation: "음, 둘 다 멋지네요. 아버님 취향은 어느 쪽이 좋으세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだね…青い方が好きかもしれない。", romaji: "소-다네... 아오이 호-가 스키카모 시레나이.", translation: "그렇네… 파란색을 더 좋아하실지도 몰라.", isUserLine: false)
        ],
        105: [ // "어느 쪽이든 좋다"고 답하기 - どちらでもいいと答える
            ConversationData(speaker: "사토", text: "昼ごはんだけど、パスタとカレー、どっちがいい？", romaji: "히루고한다케도, 파스타토 카레-, 돗치가 이이?", translation: "점심 말인데, 파스타랑 카레, 어느 쪽이 좋아?", isUserLine: false),
            ConversationData(speaker: "나", text: "私はどちらでもいいですよ。佐藤さんの食べたい方で。", romaji: "와타시와 도치라데모 이이데스요. 사토-상노 타베타이 호-데.", translation: "저는 어느 쪽이든 괜찮아요. 사토 씨가 먹고 싶은 걸로 해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当？じゃあ、今日はカレーの気分かな。", romaji: "혼토-? 쟈-, 쿄-와 카레-노 키분카나.", translation: "정말? 그럼 오늘은 카레가 당기네.", isUserLine: false)
        ],
        106: [ // 생각할 시간을 요청 - 考える時間を頼む
            ConversationData(speaker: "점원", text: "こちらのプランとこちらのプラン、どちらになさいますか？", romaji: "코치라노 푸란토 코치라노 푸란, 도치라니 나사이마스카?", translation: "이쪽 플랜과 이쪽 플랜, 어느 것으로 하시겠습니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね…すぐには決められないので、ちょっと考えます。", romaji: "소-데스네... 스구니와 키메라레나이노데, 좃토 칸가에마스.", translation: "글쎄요… 바로 정할 수가 없어서, 조금 생각해보겠습니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。決まりましたら、またお声がけください。", romaji: "카시코마리마시타. 키마리마시타라, 마타 오코에가케 쿠다사이.", translation: "알겠습니다. 정해지시면 다시 말씀해주세요.", isUserLine: false)
        ],
        107: [ // 날짜 묻기 - 日付を尋ねる
            ConversationData(speaker: "사토", text: "この書類、提出期限はいつまででしたっけ？", romaji: "코노 쇼루이, 테-슈츠키겐와 이츠마데데시탓케?", translation: "이 서류, 제출 기한이 언제까지였죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "確か、今週の金曜日までです。今日は何日ですか？", romaji: "타시카, 콘슈-노 킨요-비마데데스. 쿄-와 난니치데스카?", translation: "아마 이번 주 금요일까지요. 오늘이 며칠이죠?", isUserLine: true),
            ConversationData(speaker: "사토", text: "今日は水曜日だから、あと2日ですね。急がないと。", romaji: "쿄-와 스이요-비다카라, 아토 후츠카데스네. 이소가나이토.", translation: "오늘은 수요일이니까 앞으로 이틀 남았네요. 서둘러야겠어요.", isUserLine: false)
        ],
        108: [ // 생일 묻기 - 誕生日を尋ねる
            ConversationData(speaker: "사토", text: "キムさんの星座は何ですか？", romaji: "기무상노 세-자와 난데스카?", translation: "김 씨 별자리는 뭐예요?", isUserLine: false),
            ConversationData(speaker: "나", text: "私は蟹座です。佐藤さんの誕生日はいつですか？", romaji: "와타시와 카니자데스. 사토-상노 탄죠-비와 이츠데스카?", translation: "저는 게자리예요. 사토 씨 생일은 언제예요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "私は11月生まれの蠍座です。", romaji: "와타시와 쥬-이치가츠 우마레노 사소리자데스.", translation: "저는 11월생인 전갈자리예요.", isUserLine: false)
        ],
        109: [ // 특정 상품 재고 묻기 - 特定商品の在庫を尋ねる
            ConversationData(speaker: "점원", text: "何かお探しですか？", romaji: "나니카 오사가시데스카?", translation: "무엇을 찾으시나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。半袖のTシャツはありますか？", romaji: "하이. 한소데노 티-샤츠와 아리마스카?", translation: "네. 반팔 티셔츠는 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、あちらのコーナーにございます。ご案内しますね。", romaji: "하이, 아치라노 코-나-니 고자이마스. 고안나이시마스네.", translation: "네, 저쪽 코너에 있습니다. 안내해 드릴게요.", isUserLine: false)
        ],
        110: [ // 다시 말해달라고 정중히 요청 - 丁寧に聞き返す
            ConversationData(speaker: "사토", text: "明日の集合場所と時間をもう一度お伝えします。新宿駅東口に朝9時です。", romaji: "아시타노 슈-고-바쇼토 지칸오 모-이치도 오츠타에시마스. 신주쿠에키 히가시구치니 아사 쿠지데스.", translation: "내일 집합 장소와 시간을 다시 한번 말씀드립니다. 신주쿠역 동쪽 출구에 아침 9시입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、もう一度言ってください。場所がよく聞き取れませんでした。", romaji: "스미마센, 모- 이치도 잇테 쿠다사이. 바쇼가 요쿠 키키토레마센데시타.", translation: "죄송합니다, 다시 한번 말씀해주세요. 장소를 잘 못 들었습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい。新宿駅の、東口です。", romaji: "하이. 신주쿠에키노, 히가시구치데스.", translation: "네. 신주쿠역, 동쪽 출구입니다.", isUserLine: false)
        ],
        111: [ // 통증 표현 - 痛みを表現する
            ConversationData(speaker: "사토", text: "キムさん、どうかしましたか？顔色が優れませんよ。", romaji: "기무상, 도-카시마시타카? 카오이로가 스구레마센요.", translation: "김 씨, 무슨 일 있어요? 안색이 좋지 않아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、少し朝から頭が痛いです。", romaji: "에에, 스코시 아사카라 아타마가 이타이데스.", translation: "네, 아침부터 머리가 좀 아프네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "それは大変。薬は飲みましたか？今日は無理せず、早めに帰った方がいいですよ。", romaji: "소레와 타이헨. 쿠스와 노미마시타카? 쿄-와 무리세즈, 하야메니 카엣타 호-가 이이데스요.", translation: "저런. 약은 먹었어요? 오늘은 무리하지 말고 일찍 들어가는 게 좋겠어요.", isUserLine: false)
        ],
        112: [ // 몸 상태가 좋지 않음 표현 - 体調不良を表現する
            ConversationData(speaker: "사토", text: "キムさん、大丈夫？なんだか顔が真っ青だよ。", romaji: "기무상, 다이죠-부? 난다카 카오가 맛사오다요.", translation: "김 씨, 괜찮아? 왠지 얼굴이 새파래.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、ちょっと気分が悪いです。少し外の空気を吸ってきます。", romaji: "스미마센, 좃토 키분가 와루이데스. 스코시 소토노 쿠-키오 슷테키마스.", translation: "죄송합니다, 속이 좀 안 좋아서요. 잠시 바깥바람 좀 쐬고 오겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかった。一人で平気？誰か呼ぼうか？", romaji: "와캇타. 히토리데 헤-키? 다레카 요보-카?", translation: "알았어. 혼자 괜찮겠어? 누구 불러줄까?", isUserLine: false)
        ],
        113: [ // A와 B 중 선택 묻기 - AとBの選択を尋ねる
            ConversationData(speaker: "사토", text: "今度の休み、どこに行こうか。温泉もいいし、ショッピングもいいなあ。", romaji: "콘도노 야스미, 도코니 이코-카. 온센모 이이시, 숏핀구모 이이나아.", translation: "이번 휴가 때 어디로 갈까. 온천도 좋고, 쇼핑도 좋은데.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。佐藤さんは、犬と猫と、どちらが好きですか？…みたいに、全然決められませんね。", romaji: "소-데스네. 사토-상와, 이누토 네코토, 도치라가 스키데스카?...미타이니, 젠젠 키메라레마센네.", translation: "그러게요. 사토 씨는 '개와 고양이 중 어느 쪽을 좋아하세요?'...처럼 전혀 정할 수가 없네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ははは、本当にその通りですね。", romaji: "하하하, 혼토-니 소노 토-리데스네.", translation: "하하하, 정말 그렇네요.", isUserLine: false)
        ],
        114: [ // A 쪽을 더 좋아한다고 답하기 - Aの方が好きだと答える
            ConversationData(speaker: "사토", text: "キムさんは犬派？猫派？", romaji: "기무상와 이누하? 네코하?", translation: "김 씨는 강아지파? 고양이파?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、どちらも可愛いですが、どちらかと言えば猫の方が好きです。", romaji: "우-응, 도치라모 카와이-데스가, 도치라카토 이에바 네코노 호-가 스키데스.", translation: "음, 둘 다 귀엽지만, 굳이 따지자면 고양이 쪽을 더 좋아해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんだ。私は犬の、人懐っこいところが好きですね。", romaji: "소-난다. 와타시와 이누노, 히토나츠밋코이 토코로가 스키데스네.", translation: "그렇구나. 저는 개의 사람 잘 따르는 점이 좋더라고요.", isUserLine: false)
        ],
        115: [ // 이것이 무엇인지 묻기 - これが何か尋ねる
            ConversationData(speaker: "사토", text: "はい、これ、旅行のお土産です。", romaji: "하이, 코레, 료코-노 오미야게데스.", translation: "자, 이거 여행 선물이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "わあ、ありがとうございます！綺麗なお菓子ですね。これは何ですか？", romaji: "와아, 아리가토-고자이마스! 키레이나 오카시데스네. 코레와 난데스카?", translation: "와아, 고맙습니다! 예쁜 과자네요. 이건 뭐예요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "金沢の和菓子ですよ。見た目も味も、とても上品なんです。", romaji: "카나자와노 와가시데스요. 미타메모 아지모, 토테모 죠-힌난데스.", translation: "가나자와의 화과자예요. 모양도 맛도 아주 고급스러워요.", isUserLine: false)
        ],
        116: [ // 취미를 구체적으로 말하기 - 趣味を具体的に言う
            ConversationData(speaker: "사토", text: "キムさんは、休みの日は何をして過ごすことが多いですか？", romaji: "기무상와, 야스미노 히와 나니오 시테 스고스코토가 오-이데스카?", translation: "김 씨는 쉬는 날에 주로 뭘 하면서 보내요?", isUserLine: false),
            ConversationData(speaker: "나", text: "私の趣味は映画を見ることです。家でゆっくり見るのが好きですね。", romaji: "와타시노 슈미와 에-가오 미루 코토데스. 우치데 윳쿠리 미루노가 스키데스네.", translation: "제 취미는 영화 감상이에요. 집에서 느긋하게 보는 걸 좋아해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "いいですね。最近、何か面白い映画はありましたか？", romaji: "이이데스네. 사이킨, 나니카 오모시로이 에-가와 아리마시타카?", translation: "좋네요. 최근에 재미있는 영화 있었어요?", isUserLine: false)
        ],
        117: [ // 나중에 연락하겠다고 말하기 - 後で連絡すると言う
            ConversationData(speaker: "사토", text: "明日の飲み会の場所、決まりましたか？", romaji: "아시타노 노미카이노 바쇼, 키마리마시타카?", translation: "내일 회식 장소, 정해졌어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、まだお店を調べているところです。決まり次第、後で連絡します。", romaji: "스미마센, 마다 오미세오 시라베테이루 토코로데스. 키마리시다이, 아토데 렌라쿠시마스.", translation: "죄송해요, 아직 가게를 알아보는 중이에요. 정해지는 대로 나중에 연락할게요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "了解です。楽しみにしています。", romaji: "료카이데스. 타노시미니 시테이마스.", translation: "알겠습니다. 기대하고 있을게요.", isUserLine: false)
        ],
        118: [ // 짐 보관 요청 - 荷物の保管を依頼する
            ConversationData(speaker: "호텔 직원", text: "いらっしゃいませ。ご宿泊でいらっしゃいますか。", romaji: "이랏샤이마세. 고슈쿠하쿠데 이랏샤이마스카.", translation: "어서 오십시오. 숙박 손님이신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。チェックインまで時間があるので、先に荷物をお願いします。", romaji: "하이. 체크인마데 지칸가 아루노데, 사키니 니모츠오 오네가이시마스.", translation: "네. 체크인까지 시간이 있어서, 먼저 짐을 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "호텔 직원", text: "かしこまりました。では、お帰りの時間まで、こちらでお預かりいたします。", romaji: "카시코마리마시타. 데와, 오카에리노 지칸마데, 코치라데 오아즈카리이타시마스.", translation: "알겠습니다. 그럼, 돌아오실 때까지 여기서 보관해드리겠습니다.", isUserLine: false)
        ],
        119: [ // 체크인 요청 - チェックインの依頼
            ConversationData(speaker: "호텔 직원", text: "いらっしゃいませ。", romaji: "이랏샤이마세.", translation: "어서 오십시오.", isUserLine: false),
            ConversationData(speaker: "나", text: "こんにちは。予約したキムと申します。チェックインをお願いします。", romaji: "콘니치와. 요야쿠시타 기무토 모-시마스. 체크인오 오네가이시마스.", translation: "안녕하세요. 예약한 김이라고 합니다. 체크인 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "호텔 직원", text: "キム様ですね。お待ちしておりました。こちらにサインをお願いいたします。", romaji: "기무사마데스네. 오마치시테오리마시타. 코치라니 사인오 오네가이이타시마스.", translation: "김 님이시군요. 기다리고 있었습니다. 이쪽에 서명 부탁드립니다.", isUserLine: false)
        ],
        120: [ // 체크아웃 요청 - チェックアウトの依頼
            ConversationData(speaker: "호텔 직원", text: "おはようございます。何かお困りですか？", romaji: "오하요-고자이마스. 나니카 오코마리데스카?", translation: "좋은 아침입니다. 무엇을 도와드릴까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "チェックアウトをお願いします。部屋は708号室です。", romaji: "체크아우토오 오네가이시마스. 헤야와 나나마루하치고-시츠데스.", translation: "체크아웃 부탁합니다. 방은 708호입니다.", isUserLine: true),
            ConversationData(speaker: "호텔 직원", text: "かしこまりました。ごゆっくりお休みいただけましたか？", romaji: "카시코마리마시타. 고윳쿠리 오야스미 이타다케마시타카?", translation: "알겠습니다. 편안히 쉬셨습니까?", isUserLine: false)
        ],
        121: [ // 오늘의 일정 묻기 - 今日の予定を尋ねる
            ConversationData(speaker: "사토", text: "おはようございます。今日もいい天気ですね。", romaji: "오하요-고자이마스. 쿄-모 이이 텐키데스네.", translation: "좋은 아침이에요. 오늘도 날씨가 좋네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "おはようございます。佐藤さん、今日の予定は何ですか？", romaji: "오하요-고자이마스. 사토-상, 쿄-노 요테-와 난데스카?", translation: "안녕하세요. 사토 씨, 오늘 계획이 어떻게 되세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "午前中は会議で、午後は取引先を訪問する予定です。", romaji: "고젠츄-와 카이기데, 고고와 토리히키사키오 호-몬스루 요테-데스.", translation: "오전에는 회의가 있고, 오후에는 거래처를 방문할 예정이에요.", isUserLine: false)
        ],
        122: [ // 시간 있는지 묻기 - 時間があるか尋ねる
            ConversationData(speaker: "사토", text: "(자리에서 서류를 정리하고 있다)", romaji: "자리에서 서류를 정리하고 있다", translation: "자리에서 서류를 정리하고 있다", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、すみません。今、時間はありますか？ちょっと相談したいことがありまして。", romaji: "사토-상, 스미마센. 이마, 지칸와 아리마스카? 좃토 소-단시타이 코토가 아리마시테.", translation: "사토 씨, 죄송합니다. 지금 시간 괜찮으세요? 잠시 상의하고 싶은 게 있어서요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、大丈夫ですよ。どうしましたか？", romaji: "하이, 다이죠-부데스요. 도-시마시타카?", translation: "네, 괜찮아요. 무슨 일이세요?", isUserLine: false)
        ],
        123: [ // 원하는 시간대 묻기 - 希望の時間を尋ねる
            ConversationData(speaker: "사토", text: "この件、明日改めて打ち合わせしましょう。", romaji: "코노 켄, 아시타 아라타메테 우치아와세시마쇼-.", translation: "이 건, 내일 다시 협의합시다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、承知しました。何時ごろがいいですか？", romaji: "하이, 쇼-치시마시타. 난지고로가 이이데스카?", translation: "네, 알겠습니다. 몇 시쯤이 좋으세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですね…キムさんのご都合の良い時間で大丈夫ですよ。", romaji: "소-데스네... 기무상노 고츠고-노 이이 지칸데 다이죠-부데스요.", translation: "글쎄요… 김 씨 편한 시간으로 괜찮아요.", isUserLine: false)
        ],
        124: [ // 직업 묻기 - 職業を尋ねる
            ConversationData(speaker: "사토", text: "キムさんはこのイベントには、どうして参加されたんですか？", romaji: "기무상와 코노 이벤토니와, 도-시테 산카사레탄데스카?", translation: "김 씨는 이 행사에 어떻게 참여하게 되셨어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "友人に誘われて来ました。佐藤さんは、お仕事は何をしていますか？", romaji: "유-진니 사소와레테 키마시타. 사토-상와, 오시고토와 나니오 시테이마스카?", translation: "친구가 권해서 왔어요. 사토 씨는 어떤 일을 하세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "私は出版社で編集者をしています。", romaji: "와타시와 슷판샤데 헨슈-샤오 시테이마스.", translation: "저는 출판사에서 편집자로 일하고 있어요.", isUserLine: false)
        ],
        125: [ // 곧 도착한다고 알리기 - もうすぐ着くと知らせる
            ConversationData(speaker: "사토", text: "(전화로) もしもし、今どこですか？みんな待っていますよ。", romaji: "모시모시, 이마 도코데스카? 민나 맛테이마스요.", translation: "여보세요, 지금 어디예요? 다들 기다리고 있어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません！道が混んでいて…。でも、もうすぐ着きます！", romaji: "스미마센! 미치가 콘데이테... 데모, 모-스구 츠키마스!", translation: "죄송해요! 길이 막혀서... 그래도 이제 곧 도착해요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "分かりました。気をつけて来てください。", romaji: "와카리마시타. 키오츠케테 키테쿠다사이.", translation: "알겠어요. 조심해서 오세요.", isUserLine: false)
        ],
        126: [ // 금연석 요청 - 禁煙席の依頼
            ConversationData(speaker: "점원", text: "いらっしゃいませ。おタバコは吸われますか？", romaji: "이랏샤이마세. 오타바코와 스와레마스카?", translation: "어서 오세요. 담배는 피우십니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、吸いません。禁煙席をお願いします。", romaji: "이이에, 스이마센. 킨엔세키오 오네가이시마스.", translation: "아니요, 피우지 않습니다. 금연석으로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。こちらへどうぞ。", romaji: "카시코마리마시타. 코치라에 도-조.", translation: "알겠습니다. 이쪽으로 앉으세요.", isUserLine: false)
        ],
        127: [ // 흡연석 요청 - 喫煙席の依頼
            ConversationData(speaker: "점원", text: "いらっしゃいませ。何名様ですか？", romaji: "이랏샤이마세. 난메-사마데스카?", translation: "어서 오세요. 몇 분이신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "一人です。喫煙席をお願いします。", romaji: "히토리데스. 키츠엔세키오 오네가이시마스.", translation: "한 명입니다. 흡연석으로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、かしこまりました。あちらのカウンター席へどうぞ。", romaji: "하이, 카시코마리마시타. 아치라노 카운타-세키에 도-조.", translation: "네, 알겠습니다. 저쪽 카운터석으로 앉으세요.", isUserLine: false)
        ],
        128: [ // 창가 좌석 요청 - 窓側の席の依頼
            ConversationData(speaker: "항공사 직원", text: "お客様、お座席のご希望はございますか？", romaji: "오캬쿠사마, 오자세키노 고키보-와 고자이마스카?", translation: "손님, 원하시는 좌석이 있으신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、外の景色が見たいので、窓側の席をお願いします。", romaji: "하이, 소토노 케시키가 미타이노데, 마도가와노 세키오 오네가이시마스.", translation: "네, 바깥 경치를 보고 싶어서 창가 쪽 좌석으로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "항공사 직원", text: "かしこまりました。前方、窓側のお席でご用意いたしました。", romaji: "카시코마리마시타. 젠포-, 마도가와노 오세키데 고요-이 이타시마시타.", translation: "알겠습니다. 앞쪽 창가 좌석으로 준비해드렸습니다.", isUserLine: false)
        ],
        129: [ // 통로 좌석 요청 - 通路側の席の依頼
            ConversationData(speaker: "항공사 직원", text: "お座席はいかがなさいますか？", romaji: "오자세키와 이카가나사이마스카?", translation: "좌석은 어떻게 하시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "長時間なので、できれば通路側の席をお願いします。", romaji: "쵸-지칸나노데, 데키레바 츠-로가와노 세키오 오네가이시마스.", translation: "장시간 비행이라서, 가능하면 통로 쪽 좌석으로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "항공사 직원", text: "かしこまりました。通路側ですね。では、こちらの25C席でいかがでしょうか。", romaji: "카시코마리마시타. 츠-로가와데스네. 데와, 코치라노 니쥬-고노 시-세키데 이카가데쇼-카.", translation: "알겠습니다. 통로 쪽이시죠. 그럼, 이쪽 25C석은 어떠신가요?", isUserLine: false)
        ],
        130: [ // "별로"라고 무관심하게 답하기 - 無関心に「別に」と答える
            ConversationData(speaker: "사토", text: "何か怒ってる？さっきから一言も喋らないけど。", romaji: "나니카 오콧테루? 삿키카라 히토코토모 샤베라나이케도.", translation: "뭐 화난 거 있어? 아까부터 한마디도 안 하네.", isUserLine: false),
            ConversationData(speaker: "나", text: "別に。", romaji: "베츠니.", translation: "별로.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そう…。まあ、何かあったら聞くからね。", romaji: "소-... 마아, 나니카 앗타라 키쿠카라네.", translation: "그래…. 뭐, 무슨 일 있으면 들어줄게.", isUserLine: false)
        ],
        131: [ // A보다 B가 좋다고 표현하기 - AよりBがいいと表現する
            ConversationData(speaker: "사토", text: "食後にコーヒーと紅茶、どちらがいいですか？", romaji: "쇼쿠고니 코-히-토 코-챠, 도치라가 이이데스카?", translation: "식후에 커피랑 홍차, 어느 쪽이 좋으세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。私は紅茶よりコーヒーの方がいいです。", romaji: "아리가토-고자이마스. 와타시와 코-챠요리 코-히-노 호-가 이이데스.", translation: "감사합니다. 저는 홍차보다 커피가 더 좋습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "かしこまりました。ブラックでよろしいですか？", romaji: "카시코마리마시타. 부랏쿠데 요로시-데스카?", translation: "알겠습니다. 블랙으로 괜찮으신가요?", isUserLine: false)
        ],
        132: [ // 찬성 표현 - 賛成の表現
            ConversationData(speaker: "사토", text: "次の社員旅行は、近場の温泉に行くのはどうでしょうか。", romaji: "츠기노 샤인료코-와, 치카바노 온센니 이쿠노와 도-데쇼-카.", translation: "다음 사원 여행은 가까운 온천으로 가는 게 어떨까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいですね。私はその意見に賛成です。", romaji: "이이데스네. 와타시와 소노 이켄니 산세-데스.", translation: "좋네요. 저는 그 의견에 찬성입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "よかった。では、具体的な場所をいくつか探してみます。", romaji: "요캇타. 데와, 구타이테키나 바쇼오 이쿠츠카 사가시테미마스.", translation: "다행이다. 그럼 구체적인 장소를 몇 군데 찾아볼게요.", isUserLine: false)
        ],
        133: [ // 반대 표현 - 反対の表現
            ConversationData(speaker: "사토", text: "経費削減のため、会社の飲み会は全て中止にするのはどうでしょう。", romaji: "케-히사쿠겐노 타메, 카이샤노 노미카이와 스베테 츄-시니 스루노와 도-데쇼-.", translation: "경비 절감을 위해, 회사 회식은 전부 중지하는 게 어떨까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "申し訳ありませんが、私は反対です。チームの親睦を深める機会も必要だと思います。", romaji: "모-시와케 아리마센가, 와타시와 한타이데스. 치-무노 신보쿠오 후카메루 키카이모 히츠요-다토 오모이마스.", translation: "죄송하지만 저는 반대입니다. 팀의 친목을 다질 기회도 필요하다고 생각합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "なるほど。確かに、それも一理ありますね。", romaji: "나루호도. 타시카니, 소레모 이치리 아리마스네.", translation: "그렇군요. 확실히 그것도 일리가 있네요.", isUserLine: false)
        ],
        134: [ // 믿을 수 없다는 표현 - 信じられないという表現
            ConversationData(speaker: "사토", text: "聞きましたか？隣の課の田中さん、宝くじで1億円当たったそうですよ。", romaji: "키키마시타카? 토나리노 카노 타나카상, 타카라쿠지데 이치오쿠엔 아탓타소-데스요.", translation: "들었어요? 옆 부서의 다나카 씨, 복권으로 1억 엔에 당첨됐대요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええっ、本当ですか？信じられません！", romaji: "엣, 혼토-데스카? 신지라레마센!", translation: "엣, 정말요? 믿을 수가 없어요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "私もです。明日は何か奢ってもらわないと。", romaji: "와타시모데스. 아시타와 나니카 오곳테모라와나이토.", translation: "저도요. 내일은 뭐라도 한턱 얻어먹어야겠어요.", isUserLine: false)
        ],
        135: [ // 농담이라고 말하기 - 冗談だと言う
            ConversationData(speaker: "사토", text: "実は私、昔アイドルとして活動していたんですよ。", romaji: "지츠와 와타시, 무카시 아이도루토시테 카츠도-시테이탄데스요.", translation: "사실 저, 예전에 아이돌로 활동했었어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええーっ！すごいですね！全然知りませんでした！", romaji: "에에-! 스고이데스네! 젠젠 시리마센데시타!", translation: "에이! 대단하네요! 전혀 몰랐어요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "ははは、すみません、冗談です。信じましたか？", romaji: "하하하, 스미마센, 죠-단데스. 신지마시타카?", translation: "하하하, 죄송해요, 농담이에요. 믿었어요?", isUserLine: false)
        ],
        136: [ // 전적으로 동의하기 - 全面的に同意する
            ConversationData(speaker: "사토", text: "このプロジェクトを成功させるには、チームワークが何よりも大切だと思います。", romaji: "코노 프로제쿠토오 세-코-사세루니와, 치-무와-쿠가 나니요리모 타이세츠다토 오모이마스.", translation: "이 프로젝트를 성공시키려면 팀워크가 무엇보다 중요하다고 생각해요.", isUserLine: false),
            ConversationData(speaker: "나", text: "その通りです。みんなで協力しなければ、達成できません。", romaji: "소노 토-리데스. 민나데 쿄-료쿠시나케레바, 탓세-데키마센.", translation: "맞습니다. 다 함께 협력하지 않으면 달성할 수 없어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね。もう一度、役割分担を確認しましょう。", romaji: "데스요네. 모-이치도, 야쿠와리분탄오 카쿠닌시마쇼-.", translation: "그렇죠. 다시 한번 역할 분담을 확인합시다.", isUserLine: false)
        ],
        137: [ // 정중하게 정정하기 - 丁寧に訂正する
            ConversationData(speaker: "사토", text: "ということは、キムさんはこのA案に賛成、ということでよろしいですね？", romaji: "토이우코토와, 기무상와 코노 에-안니 산세-, 토이우코토데 요로시-데스네?", translation: "그렇다는 건, 김 씨는 이 A안에 찬성이라는 말씀이시죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "いえ、すみません、ちょっと違います。全面的に賛成というより、条件付きで賛成という意味です。", romaji: "이에, 스미마센, 좃토 치가이마스. 젠멘테키니 산세-토 이우요리, 죠-켄츠키데 산세-토 이우 이미데스.", translation: "아니요, 죄송합니다, 조금 다릅니다. 전면적으로 찬성이라기보다, 조건부로 찬성이라는 의미입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、なるほど。失礼いたしました。", romaji: "아아, 나루호도. 시츠레-이타시마시타.", translation: "아아, 그렇군요. 실례했습니다.", isUserLine: false)
        ],
        138: [ // 경우에 따라 다르다고 말하기 - 場合によると言う
            ConversationData(speaker: "사토", text: "お客様からのクレームには、どのように対応するのがベストでしょうか。", romaji: "오캬쿠사마카라노 쿠레-무니와, 도노요-니 타이오-스루노가 베스토데쇼-카.", translation: "고객 클레임에는 어떻게 대응하는 것이 최선일까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "それはケースバイケースですね。マニュアル通りではなく、内容をよく聞いて判断する必要があります。", romaji: "소레와 케-스바이케-스데스네. 마뉴아루도-리데와 나쿠, 나이요-오 요쿠 키이테 한단스루 히츠요-가 아리마스.", translation: "그건 경우에 따라 다릅니다. 매뉴얼대로가 아니라, 내용을 잘 듣고 판단할 필요가 있어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかりました。臨機応変に対応します。", romaji: "와카리마시타. 린키오-헨니 타이오-시마스.", translation: "알겠습니다. 임기응변으로 대응하겠습니다.", isUserLine: false)
        ],
        139: [ // 강하게 부정하거나 사양하기 - 強く否定・辞退する
            ConversationData(speaker: "사토", text: "今回の契約、キムさんがいなければ絶対に取れませんでした。本当にありがとうございます。", romaji: "콘카이노 케-야쿠, 기무상가 이나케레바 젯타이니 토레마센데시타. 혼토-니 아리가토-고자이마스.", translation: "이번 계약, 김 씨가 없었다면 절대 성사시키지 못했을 겁니다. 정말 감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "とんでもないです。チーム全員の努力の結果ですよ。", romaji: "톤데모나이데스. 치-무 젠인노 도료쿠노 켓카데스요.", translation: "천만에요. 팀 전원의 노력의 결과입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "キムさんはいつも謙虚ですね。", romaji: "기무상와 이츠모 켄쿄데스네.", translation: "김 씨는 언제나 겸손하시네요.", isUserLine: false)
        ],
        140: [ // 결정을 맡기기 - 決定を任せる
            ConversationData(speaker: "사토", text: "今日の夕食、何を食べましょうか。パスタか、それとも和食か。", romaji: "쿄-노 유-쇼쿠, 나니오 타베마쇼-카. 파스타카, 소레토모 와쇼쿠카.", translation: "오늘 저녁, 뭘 먹을까요? 파스타, 아니면 일식?", isUserLine: false),
            ConversationData(speaker: "나", text: "私はどちらも好きなので、佐藤さんにお任せします。", romaji: "와타시와 도치라모 스키나노데, 사토-상니 오마카세시마스.", translation: "저는 둘 다 좋아해서, 사토 씨에게 맡길게요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当ですか？じゃあ、今日はさっぱりと和食にしましょうか。", romaji: "혼토-데스카? 쟈-, 쿄-와 삿파리토 와쇼쿠니 시마쇼-카.", translation: "정말요? 그럼, 오늘은 개운하게 일식으로 할까요?", isUserLine: false)
        ],
        141: [ // 아침 식사 여부 묻기 - 朝食の有無を尋ねる
            ConversationData(speaker: "사토", text: "キムさん、おはようございます。", romaji: "기무상, 오하요-고자이마스.", translation: "김 씨, 좋은 아침이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "おはようございます。佐藤さん、朝ご飯は食べましたか？", romaji: "오하요-고자이마스. 사토-상, 아사고항와 타베마시타카?", translation: "좋은 아침이에요. 사토 씨, 아침밥은 먹었어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ちゃんと食べてきました。キムさんは？", romaji: "하이, 찬토 타베테키마시타. 기무상와?", translation: "네, 잘 챙겨 먹고 왔어요. 김 씨는요?", isUserLine: false)
        ],
        142: [ // 이미 먹었다고 답하기 - 既に食べたと答える
            ConversationData(speaker: "사토", text: "キムさん、もう何か食べましたか？お腹すいていませんか？", romaji: "기무상, 모- 나니카 타베마시타카? 오나카 스이테이마센카?", translation: "김 씨, 뭐 벌써 먹었어요? 배 안 고파요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、家を出る前に、もう食べました。", romaji: "하이, 우치오 데루 마에니, 모- 타베마시타.", translation: "네, 집을 나오기 전에 이미 먹었습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか。朝食は大事ですからね。", romaji: "소-데스카. 쵸-쇼쿠와 다이지데스카라네.", translation: "그래요? 아침 식사는 중요하니까요.", isUserLine: false)
        ],
        143: [ // 아직 안 먹었다고 답하기 - まだだと答える
            ConversationData(speaker: "사토", text: "よかったら、このパンを食べませんか？", romaji: "요캇타라, 코노 팡오 타베마센카?", translation: "괜찮으면 이 빵 먹을래요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。実は朝ごはん、まだです。", romaji: "아리가토-고자이마스. 지츠와 아사고항, 마다데스.", translation: "고맙습니다. 실은 아침밥, 아직 안 먹었어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですね。では、遠慮なくどうぞ。", romaji: "소-닷탄데스네. 데와, 엔료나쿠 도-조.", translation: "그랬군요. 그럼, 사양 말고 드세요.", isUserLine: false)
        ],
        144: [ // 잠자리에 들겠다고 말하기 - 寝ると告げる
            ConversationData(speaker: "사토", text: "ふわあ…もうこんな時間か。", romaji: "후와아... 모- 콘나 지칸카.", translation: "후아… 벌써 시간이 이렇게 됐네.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。私はもう眠いので、そろそろ寝ます。", romaji: "혼토-데스네. 와타시와 모- 네무이노데, 소로소로 네마스.", translation: "그러게요. 저는 이제 졸려서 슬슬 자야겠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、わかりました。良い夢を。", romaji: "하이, 와카리마시타. 요이 유메오.", translation: "네, 알겠어요. 좋은 꿈 꿔요.", isUserLine: false)
        ],
        145: [ // 밤 인사 - 夜の挨拶
            ConversationData(speaker: "사토", text: "今日も一日お疲れ様でした。", romaji: "쿄-모 이치니치 오츠카레사마데시타.", translation: "오늘 하루도 수고 많으셨습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、お疲れ様でした。では、また明日。おやすみなさい。", romaji: "하이, 오츠카레사마데시타. 데와, 마타 아시타. 오야스미나사이.", translation: "네, 수고하셨습니다. 그럼, 내일 봬요. 안녕히 주무세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "おやすみなさい。", romaji: "오야스미나사이.", translation: "안녕히 주무세요.", isUserLine: false)
        ],
        146: [ // 바쁜지 묻기 - 忙しいか尋ねる
            ConversationData(speaker: "사토", text: "キムさん、こんにちは。", romaji: "기무상, 콘니치와.", translation: "김 씨, 안녕하세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "こんにちは。すみません、佐藤さん、今日は忙しいですか？", romaji: "콘니치와. 스미마센, 사토-상, 쿄-와 이소가시-데스카?", translation: "안녕하세요. 죄송하지만 사토 씨, 오늘 바쁘세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "いえ、午後は特に予定もないので、大丈夫ですよ。何かありましたか？", romaji: "이에, 고고와 토쿠니 요테-모 나이노데, 다이죠-부데스요. 나니카 아리마시타카?", translation: "아니요, 오후에는 특별한 일정도 없어서 괜찮아요. 무슨 일 있으세요?", isUserLine: false)
        ],
        147: [ // "그저 그렇다"고 답하기 - まあまあだと答える
            ConversationData(speaker: "사토", text: "新しくできたあのレストラン、行ってみましたか？味はどうでした？", romaji: "아타라시쿠 데키타 아노 레스토란, 잇테미마시타카? 아지와 도-데시타?", translation: "새로 생긴 저 레스토랑, 가봤어요? 맛은 어땠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、正直、まあまあです。期待したほどではなかったですね。", romaji: "우-응, 쇼-지키, 마-마-데스. 키타이시타 호도데와 나캇타데스네.", translation: "음, 솔직히 그럭저럭이었어요. 기대했던 만큼은 아니었네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "なるほど。教えてくれてありがとうございます。", romaji: "나루호도. 오시에테쿠레테 아리가토-고자이마스.", translation: "그렇군요. 알려줘서 고마워요.", isUserLine: false)
        ],
        148: [ // 차로 데려다 달라고 부탁 - 車で送ってもらうよう頼む
            ConversationData(speaker: "사토", text: "もう終電もないし、タクシーも捕まらないね。", romaji: "모- 슈-덴모 나이시, 타쿠시-모 츠카마라나이네.", translation: "이제 막차도 없고, 택시도 안 잡히네.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当に困りました。すみませんが、もしよかったら、家まで車で送ってください。", romaji: "혼토-니 코마리마시타. 스미마센가, 모시 요캇타라, 우치마데 쿠루마데 오쿳테쿠다사이.", translation: "정말 곤란하게 됐어요. 죄송하지만, 괜찮으시다면 집까지 차로 바래다주시겠어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "もちろんいいですよ。こっちの方向ですし。さあ、乗ってください。", romaji: "모치론 이이데스요. 콧치노 호-코-데스시. 사-,놋테쿠다사이.", translation: "물론 괜찮아요. 이쪽 방향이기도 하고. 자, 타세요.", isUserLine: false)
        ],
        149: [ // 데리러 와달라고 부탁 - 迎えに来てと頼む
            ConversationData(speaker: "사토", text: "もしもし、どうしたの？まだ会社？", romaji: "모시모시, 도-시타노? 마다 카이샤?", translation: "여보세요, 무슨 일이야? 아직 회사야?", isUserLine: false),
            ConversationData(speaker: "나", text: "急な残業で、電車がなくなってしまいました。申し訳ないけど、駅まで迎えに来てください。", romaji: "큐-나 잔교-데, 덴샤가 나쿠낫테 시마이마시타. 모-시와케나이케도, 에키마데 무카에니 키테쿠다사이.", translation: "갑작스러운 야근으로 전철이 끊겼어요. 미안하지만, 역으로 데리러 와주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかった。30分くらいで着くと思う。気をつけて待っててね。", romaji: "와캇타. 산짓뿐쿠라이데 츠쿠토 오모우. 키오츠케테 맛테테네.", translation: "알았어. 30분 정도면 도착할 거야. 조심해서 기다리고 있어.", isUserLine: false)
        ],
        150: [ // 나중에 전화해달라고 부탁 - 後で電話してと頼む
            ConversationData(speaker: "사토", text: "もしもし、キムさん？今、ちょっと相談したいことがあるんだけど。", romaji: "모시모시, 기무상? 이마, 좃토 소-단시타이코토가 아룬다케도.", translation: "여보세요, 김 씨? 지금 잠깐 상의하고 싶은 게 있는데.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、今ちょっと手が離せなくて。30分後に、後で電話してください。", romaji: "스미마센, 이마 좃토 테가 하나세나쿠테. 산짓뿐고니, 아토데 덴와시테쿠다사이.", translation: "죄송합니다, 지금 잠시 다른 일을 하고 있어서요. 30분 뒤에, 나중에 전화해 주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "了解しました。では、また後で。", romaji: "료카이시마시타. 데와, 마타 아토데.", translation: "알겠습니다. 그럼 나중에 다시 걸게요.", isUserLine: false)
        ],
        151: [ // 자리에 앉아도 되는지 묻기 - 席に座っていいか尋ねる
            ConversationData(speaker: "사토", text: "", romaji: "카페의 큰 테이블에 혼자 앉아 책을 읽고 있다", translation: "카페의 큰 테이블에 혼자 앉아 책을 읽고 있다", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、他の席が満席で。ここに座ってもいいですか？", romaji: "스미마센, 호카노 세키가 만세키데. 코코니 스왓테모 이이데스카?", translation: "실례합니다, 다른 자리가 꽉 차서요. 여기에 앉아도 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、はい。どうぞ、どうぞ。", romaji: "아, 하이. 도-조, 도-조.", translation: "아, 네. 물론이죠, 앉으세요.", isUserLine: false)
        ],
        152: [ // 금지 행위 알리기 - 禁止行為を知らせる
            ConversationData(speaker: "관광객", text: "", romaji: "공원 벤치에서 담배에 불을 붙인다", translation: "공원 벤치에서 담배에 불을 붙인다", isUserLine: false),
            ConversationData(speaker: "나", text: "あの、すみません。この公園は禁煙なので、ここでタバコを吸ってはいけません。", romaji: "아노, 스미마센. 코노 코-엔와 킨엔나노데, 코코데 타바코오 슷테와 이케마센.", translation: "저기, 실례합니다. 이 공원은 금연구역이라서, 여기서 담배를 피우시면 안 됩니다.", isUserLine: true),
            ConversationData(speaker: "관광객", text: "あ、そうでしたか。知らずにすみませんでした。すぐに消します。", romaji: "아, 소-데시타카. 시라즈니 스미마센데시타. 스구니 케시마스.", translation: "아, 그랬군요. 모르고 죄송했습니다. 바로 끄겠습니다.", isUserLine: false)
        ],
        153: [ // 잊지 말라고 당부하기 - 忘れないよう念を押す
            ConversationData(speaker: "사토", text: "では、明日の会議、よろしくお願いします。", romaji: "데와, 아시타노 카이기, 요로시쿠 오네가이시마스.", translation: "그럼, 내일 회의 잘 부탁드립니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。配布した資料には目を通しておいてください。忘れないでくださいね。", romaji: "하이. 하이후시타 시료-니와 메오 토오시테오이테 쿠다사이. 와스레나이데 쿠다사이네.", translation: "네. 배부해 드린 자료는 미리 훑어봐 주세요. 잊지 말아 주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "承知しました。必ず読んでおきます。", romaji: "쇼-치시마시타. 카나라즈 욘데오키마스.", translation: "알겠습니다. 반드시 읽어두겠습니다.", isUserLine: false)
        ],
        154: [ // 안심시키기 - 安心させる
            ConversationData(speaker: "사토", text: "初めて一人でプレゼンをするので、とても緊張しています。", romaji: "하지메테 히토리데 프레젠오 스루노데, 토테모 킨쵸-시테이마스.", translation: "처음으로 혼자 프레젠테이션을 하는 거라, 무척 긴장돼요.", isUserLine: false),
            ConversationData(speaker: "나", text: "あれだけ練習したじゃないですか。大丈夫、心配しないでください。", romaji: "아레다케 렌슈-시타쟈나이데스카. 다이죠-부, 신파이시나이데 쿠다사이.", translation: "그렇게나 연습했잖아요. 괜찮아요, 걱정하지 마세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい…。ありがとうございます。少し自信が持てました。", romaji: "하이.... 아리가토-고자이마스. 스코시 지신가 모테마시타.", translation: "네…. 고맙습니다. 조금 자신이 생겼어요.", isUserLine: false)
        ],
        155: [ // 무리하지 말라고 조언하기 - 無理しないよう助言する
            ConversationData(speaker: "사토", text: "すみません、少し風邪気味ですが、今日の仕事は最後までやります。", romaji: "스미마센, 스코시 카제기미데스가, 쿄-노 시고토와 사이고마데 야리마스.", translation: "죄송합니다, 감기 기운이 좀 있지만 오늘 일은 끝까지 하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そんな体で大丈夫ですか。無理しないでください。今日は早めに帰ったほうがいいですよ。", romaji: "손나 카라다데 다이죠-부데스카. 무리시나이데 쿠다사이. 쿄-와 하야메니 카엣타 호-가 이이데스요.", translation: "그런 몸으로 괜찮겠어요? 무리하지 마세요. 오늘은 일찍 퇴근하는 편이 좋아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。では、お言葉に甘えて…。", romaji: "아리가토-고자이마스. 데와, 오코토바니 아마에테...", translation: "감사합니다. 그럼, 말씀대로...", isUserLine: false)
        ],
        156: [ // 노래 못한다고 사양하기 - 歌が下手だと断る
            ConversationData(speaker: "사토", text: "さあ、次はキムさんの番ですよ！マイクをどうぞ！", romaji: "사-, 츠기와 기무상노 반데스요! 마이쿠오 도-조!", translation: "자, 다음은 김 씨 차례예요! 마이크 받으세요!", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、とんでもない。私は歌が下手ですから、皆さんの歌を聞いているだけで十分です。", romaji: "이에이에, 톤데모나이. 와타시와 우타가 헤타데스카라, 미나산노 우타오 키이테이루다케데 쥬-분데스.", translation: "아니에요, 말도 안 돼요. 저는 노래를 못해서, 여러분 노래 듣는 것만으로도 충분해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そんなこと言わずに、一曲だけ歌いましょうよ。", romaji: "손나 코토 이와즈니, 익쿄쿠다케 우타이마쇼-요.", translation: "그런 말 말고, 딱 한 곡만 불러요.", isUserLine: false)
        ],
        157: [ // 요리 실력 묻기 - 料理の腕前を尋ねる
            ConversationData(speaker: "사토", text: "キムさんは一人暮らしが長いんですよね。自炊はしますか？", romaji: "기무상와 히토리구라시가 나가인데스요네. 지스와 시마스카?", translation: "김 씨는 자취한 지 오래됐죠. 밥은 해 먹어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、時々しますよ。", romaji: "하이, 토키도키 시마스요.", translation: "네, 가끔 해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね。料理ができますか？得意料理とかあります？", romaji: "소-난데스네. 료-리가 데키마스카? 토쿠이료-리토카 아리마스?", translation: "그렇군요. 요리할 줄 알아요? 자신 있는 요리 같은 거 있어요?", isUserLine: false)
        ],
        158: [ // 잘 못한다고 겸손하게 답하기 - あまりできないと謙遜して答える
            ConversationData(speaker: "사토", text: "英語は話せますか？", romaji: "에-고와 하나세마스카?", translation: "영어는 할 줄 아세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、あまりできません。簡単な挨拶程度です。", romaji: "이이에, 아마리 데키마센. 칸탄나 아이사츠테-도데스.", translation: "아니요, 그다지 잘하지 못해요. 간단한 인사 정도입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね。私ももっと勉強しないと。", romaji: "소-난데스네. 와타시모 못토 벤쿄-시나이토.", translation: "그렇군요. 저도 더 공부해야겠어요.", isUserLine: false)
        ],
        159: [ // 운동하라고 조언하기 - 運動を勧める
            ConversationData(speaker: "사토", text: "最近、階段を上るだけで息が切れてしまいます。", romaji: "사이킨, 카이단오 노보루다케데 이키가 키레테시마이마스.", translation: "요즘 계단을 오르는 것만으로도 숨이 차요.", isUserLine: false),
            ConversationData(speaker: "나", text: "それは運動不足ですよ。毎日少しでもいいから、運動した方がいいですよ。", romaji: "소레와 운도-부소쿠데스요. 마이니치 스코시데모 이이카라, 운도-시타 호-가 이이데스요.", translation: "그건 운동 부족이에요. 매일 조금이라도 좋으니 운동하는 편이 좋아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね…。分かってはいるんですが、なかなか時間がなくて。", romaji: "데스요네... 와캇테와 이룬데스가, 나카나카 지칸가 나쿠테.", translation: "그렇죠…. 알고는 있는데, 좀처럼 시간이 없어서요.", isUserLine: false)
        ],
        160: [ // 약 먹으라고 조언하기 - 薬を飲むよう助言する
            ConversationData(speaker: "사토", text: "昨日からずっと頭が痛くて、仕事に集中できません。", romaji: "키노-카라 즛토 아타마가 이타쿠테, 시고토니 슈-츄-데키마센.", translation: "어제부터 계속 머리가 아파서 일에 집중을 못 하겠어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "我慢しないで、薬を飲んだ方がいいですよ。", romaji: "가만시나이데, 쿠스리오 논다 호-가 이이데스요.", translation: "참지 말고 약을 먹는 편이 좋아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですね。昼休みになったら薬局に行ってきます。", romaji: "소-데스네. 히루야스미니 낫타라 약쿄쿠니 잇테키마스.", translation: "그러게요. 점심시간 되면 약국에 다녀와야겠어요.", isUserLine: false)
        ],
        161: [ // 지각 이유 묻기 - 遅刻の理由を尋ねる
            ConversationData(speaker: "사토", text: "キムさん、遅いですよ。もう会議は始まっています。どうして遅れたんですか？", romaji: "기무상, 오소이데스요. 모- 카이기와 하지맛테이마스. 도-시테 오쿠레탄데스카?", translation: "김 씨, 늦었어요. 벌써 회의 시작했다고요. 왜 늦은 거예요?", isUserLine: false),
            ConversationData(speaker: "나", text: "大変申し訳ありません。途中で人身事故があって、電車が止まってしまったんです。", romaji: "타이헨 모-시와케 아리마센. 토츄-데 진신지코가 앗테, 덴샤가 토맛테시맛탄데스.", translation: "정말 죄송합니다. 오는 길에 인명 사고가 있어서 전철이 멈춰버렸습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですか。それは大変でしたね。分かりました、席に着いてください。", romaji: "소-닷탄데스카. 소레와 타이헨데시타네. 와카리마시타, 세키니 츠이테쿠다사이.", translation: "그랬군요. 힘들었겠네요. 알겠습니다, 자리에 앉으세요.", isUserLine: false)
        ],
        162: [ // 지각 이유 답하기 - 遅刻の理由に答える
            ConversationData(speaker: "사토", text: "どうしたの？約束の時間、30分も過ぎてるよ。", romaji: "도-시타노? 야쿠소쿠노 지칸, 산짓뿐모 스기테루요.", translation: "무슨 일이야? 약속 시간 30분이나 지났어.", isUserLine: false),
            ConversationData(speaker: "나", text: "ごめんなさい！電車が遅れたからです。急な車両点検があったみたいで…。", romaji: "고멘나사이! 덴샤가 오쿠레타카라데스. 큐-나 샤료-텐켄가 앗타미타이데...", translation: "미안해! 전철이 지연돼서 그래. 갑자기 차량 점검이 있었나 봐...", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんだ。心配したよ。とりあえず、無事に着いてよかった。", romaji: "소-닷탄다. 신파이시타요. 토리아에즈, 부지니 츠이테 요캇타.", translation: "그랬구나. 걱정했잖아. 일단 무사히 도착해서 다행이다.", isUserLine: false)
        ],
        163: [ // 처음이라고 말하기 - 初めてだと伝える
            ConversationData(speaker: "사토", text: "キムさん、スキーはしたことありますか？", romaji: "기무상, 스키-와 시타코토 아리마스카?", translation: "김 씨, 스키 타본 적 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、一度もありません。今回が全くの初めてです。", romaji: "이이에, 이치도모 아리마센. 콘카이가 맛타쿠노 하지메테데스.", translation: "아니요, 한 번도 없어요. 이번이 완전 처음이에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね！じゃあ、私が基本から教えてあげますよ。", romaji: "소-난데스네! 쟈-, 와타시가 키혼카라 오시에테아게마스요.", translation: "그렇군요! 그럼 제가 기초부터 가르쳐 드릴게요.", isUserLine: false)
        ],
        164: [ // 오랜만이라고 인사하기 - 久しぶりだと挨拶する
            ConversationData(speaker: "사토", text: "あれ、もしかしてキムさんですか？", romaji: "아레, 모시카시테 기무상데스카?", translation: "어라, 혹시 김 씨 아니세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、そうですが…。あ、佐藤さん！お久しぶりです！", romaji: "하이, 소-데스가... 아, 사토-상! 오히사시부리데스!", translation: "네, 그런데요... 아, 사토 씨! 오랜만입니다!", isUserLine: true),
            ConversationData(speaker: "사토", text: "やっぱり！全然変わらないから、すぐに分かりましたよ。", romaji: "얏파리! 젠젠 카와라나이카라, 스구니 와카리마시타요.", translation: "역시! 전혀 변하지 않아서 바로 알아봤어요.", isUserLine: false)
        ],
        165: [ // 긴장된다고 표현하기 - 緊張していると表現する
            ConversationData(speaker: "사토", text: "もうすぐ発表の順番ですね。準備は万端ですか？", romaji: "모-스구 핫표-노 준반데스네. 준비와 반탄데스카?", translation: "이제 곧 발표 순서네요. 준비는 다 됐어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、準備はしたんですが…大勢の人の前だと、どうしても緊張しています。", romaji: "하이, 준비와 시탄데스가... 오-제-노 히토노 마에다토, 도-시테모 킨쵸-시테이마스.", translation: "네, 준비는 했는데... 많은 사람 앞에서는 아무래도 긴장이 되네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "大丈夫。深呼吸して、練習通りにやればきっとうまくいきますよ。", romaji: "다이죠-부. 신코큐-시테, 렌슈-도-리니 야레바 킷토 우마쿠이키마스요.", translation: "괜찮아요. 심호흡하고, 연습한 대로 하면 분명 잘 될 거예요.", isUserLine: false)
        ],
        166: [ // 실망감 표현하기 - がっかりした気持ちを表現する
            ConversationData(speaker: "사토", text: "楽しみにしていた花火大会、台風で中止になってしまいましたね。", romaji: "타노시미니 시테이타 하나비타이카이, 타이후-데 츄-시니 낫테시마이마시타네.", translation: "기대했던 불꽃놀이 축제, 태풍 때문에 취소되어 버렸네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、本当に。この日のために浴衣まで買ったのに、がっかりしました。", romaji: "에에, 혼토-니. 코노 히노 타메니 유카타마데 캇타노니, 각카리시마시타.", translation: "네, 정말요. 이날을 위해 유카타까지 샀는데, 실망했어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "また来年がありますよ。来年こそは晴れるといいですね。", romaji: "마타 라이넨가 아리마스요. 라이넨코소와 하레루토 이이데스네.", translation: "내년이 또 있잖아요. 내년이야말로 날씨가 좋으면 좋겠네요.", isUserLine: false)
        ],
        167: [ // 감동 표현하기 - 感動を表現する
            ConversationData(speaker: "사토", text: "昨日、おすすめしてくれた映画、見ましたよ。", romaji: "키노-, 오스스메시테쿠레타 에-가, 미마시타요.", translation: "어제 추천해준 영화, 봤어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "あ、本当ですか？どうでした？", romaji: "아, 혼토-데스카? 도-데시타?", translation: "아, 정말요? 어땠어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "家族の愛情に、本当に感動しました。涙が止まりませんでした。", romaji: "카조쿠노 아이죠-니, 혼토-니 칸도-시마시타. 나미다가 토마리마센데시타.", translation: "가족의 사랑에 정말 감동했어요. 눈물이 멈추질 않았어요.", isUserLine: false)
        ],
        168: [ // 머리 잘랐는지 묻기 - 髪を切ったか尋ねる
            ConversationData(speaker: "사토", text: "あれ、キムさん。なんだか今日、雰囲気が違いますね。", romaji: "아레, 기무상. 난다카 쿄-, 훈이키가 치가이마스네.", translation: "어라, 김 씨. 왠지 오늘 분위기가 다르네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "あ、分かりますか？実は昨日、美容院に行ったんです。", romaji: "아, 와카리마스카? 지츠와 키노-, 비요-인니 잇탄데스.", translation: "아, 아시겠어요? 실은 어제 미용실에 다녀왔어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね！髪を切りましたか？とても素敵ですよ。", romaji: "소-난데스네! 카미오 키리마시타카? 토테모 스테키데스요.", translation: "그렇군요! 머리 자르셨어요? 아주 멋져요.", isUserLine: false)
        ],
        169: [ // 잘 어울린다고 칭찬하기 - 似合うと褒める
            ConversationData(speaker: "사토", text: "そのジャケット、新しいのですか？色がきれいですね。", romaji: "소노 자켓토, 아타라시-노데스카? 이로가 키레-데스네.", translation: "그 재킷, 새로 산 거예요? 색이 예쁘네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、昨日買いました。ちょっと派手かなと思ったんですが…。", romaji: "하이, 키노- 카이마시타. 좃토 하데카나토 오못탄데스가...", translation: "네, 어제 샀어요. 좀 화려한가 싶었는데...", isUserLine: true),
            ConversationData(speaker: "사토", text: "そんなことないですよ。キムさんによく似合いますね。", romaji: "손나코토나이데스요. 기무상니 요쿠 니아이마스네.", translation: "그렇지 않아요. 김 씨에게 아주 잘 어울리네요.", isUserLine: false)
        ],
        170: [ // 돌아가자고 제안하기 - 帰ろうと提案する
            ConversationData(speaker: "사토", text: "もう夜も遅いですね。明日も朝から仕事ですし…。", romaji: "모- 요루모 오소이데스네. 아시타모 아사카라 시고토데스시...", translation: "벌써 밤도 깊었네요. 내일도 아침부터 일해야 하고...", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。名残惜しいですが、そろそろ帰りましょうか。", romaji: "혼토-데스네. 나고리오시-데스가, 소로소로 카에리마쇼-카.", translation: "그러게요. 아쉽지만, 슬슬 돌아갈까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、そうしましょう。今日は本当にありがとうございました。", romaji: "에에, 소-시마쇼-. 쿄-와 혼토-니 아리가토-고자이마시타.", translation: "네, 그러죠. 오늘은 정말 감사했습니다.", isUserLine: false)
        ],
        171: [ // 감기에 걸렸다고 말하기 - 風邪をひいたと伝える
            ConversationData(speaker: "사토", text: "もしもし、キムさん？声が変ですよ。どうしましたか？", romaji: "모시모시, 기무상? 코에가 헨데스요. 도-시마시타카?", translation: "여보세요, 김 씨? 목소리가 이상해요. 무슨 일 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "おはようございます。すみません、昨日から喉が痛くて、どうやら風邪をひきました。", romaji: "오하요-고자이마스. 스미마센, 키노-카라 노도가 이타쿠테, 도-야라 카제오 히키마시타.", translation: "안녕하세요. 죄송합니다, 어제부터 목이 아픈 게 아무래도 감기에 걸린 것 같아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "それは大変。今日は無理せず、ゆっくり休んでくださいね。", romaji: "소레와 타이헨. 쿄-와 무리세즈, 윳쿠리 야슨데쿠다사이네.", translation: "저런. 오늘은 무리하지 말고 푹 쉬세요.", isUserLine: false)
        ],
        172: [ // 열이 있다고 말하기 - 熱があると伝える
            ConversationData(speaker: "사토", text: "キムさん、顔が真っ赤ですよ。大丈夫ですか？", romaji: "기무상, 카오가 맛카데스요. 다이죠-부데스카?", translation: "김 씨, 얼굴이 새빨개요. 괜찮아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "なんだか体がだるくて…。熱があります。多分38度くらい。", romaji: "난다카 카라다가 다루쿠테... 네츠가 아리마스. 타분 산쥬-하치도 쿠라이.", translation: "왠지 몸이 나른해서... 열이 있어요. 아마 38도 정도.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そんなに高いんですか！すぐに病院に行くべきですよ。", romaji: "손나니 타카인데스카! 스구니 뵤-인니 잇쿠베키데스요.", translation: "그렇게 높아요? 당장 병원에 가야 해요.", isUserLine: false)
        ],
        173: [ // 병원에 가라고 조언하기 - 病院に行くよう助言する
            ConversationData(speaker: "사토", text: "咳がもう一週間も止まらないんです。", romaji: "세키가 모- 잇슈-칸모 토마라나인데스.", translation: "기침이 벌써 일주일째 멈추질 않아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "それはただの風邪じゃないかもしれません。一度、病院に行った方がいいですよ。", romaji: "소레와 타다노 카제쟈나이카모 시레마센. 이치도, 뵤-인니 잇타 호-가 이이데스요.", translation: "그건 그냥 감기가 아닐지도 몰라요. 한번 병원에 가보는 편이 좋겠어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですよね。明日の朝、行ってみることにします。", romaji: "소-데스요네. 아시타노 아사, 잇테미루 코토니 시마스.", translation: "그렇겠죠. 내일 아침에 가보기로 할게요.", isUserLine: false)
        ],
        174: [ // 날씨가 덥다고 말하기 - 天気が暑いと言う
            ConversationData(speaker: "사토", text: "ふう、ちょっと外を歩いただけなのに、汗だくですね。", romaji: "후우, 좃토 소토오 아루이타다케나노니, 아세다쿠데스네.", translation: "휴, 잠깐 밖을 걸었을 뿐인데 땀범벅이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当に。今日は特に暑いですね。湿気も多くて。", romaji: "혼토-니. 쿄-와 토쿠니 아츠이데스네. 싯케모 오-쿠테.", translation: "정말요. 오늘은 특히 덥네요. 습기도 많고요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、こんな日はビールが美味しいでしょうね。", romaji: "에에, 콘나 히와 비-루가 오이시-데쇼-네.", translation: "네, 이런 날은 맥주가 맛있겠네요.", isUserLine: false)
        ],
        175: [ // 날씨가 춥다고 말하기 - 天気が寒いと言う
            ConversationData(speaker: "사토", text: "キムさん、コートを着ないで寒くないですか？", romaji: "기무상, 코-토오 키나이데 사무쿠나이데스카?", translation: "김 씨, 코트도 안 입고 춥지 않아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫だと思ったんですが、風が冷たいですね。今日は寒いですね。", romaji: "다이죠-부다토 오못탄데스가, 카제가 츠메타이데스네. 쿄-와 사무이데스네.", translation: "괜찮을 줄 알았는데, 바람이 차네요. 오늘 춥네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ。天気予報では、雪が降るかもしれないそうですよ。", romaji: "에에. 텐키요호-데와, 유키가 후루카모 시레나이소-데스요.", translation: "네. 일기예보에서는 눈이 올지도 모른대요.", isUserLine: false)
        ],
        176: [ // 에어컨을 켜달라고 요청 - エアコンをつけてと頼む
            ConversationData(speaker: "사토", text: "この部屋、少し空気がこもっていませんか？", romaji: "코노 헤야, 스코시 쿠-키가 코못테이마센카?", translation: "이 방, 공기가 좀 탁하지 않아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、少し蒸し暑いです。すみませんが、エアコンをつけてください。", romaji: "에에, 스코시 무시아츠이데스. 스미마센가, 에아콘오 츠케테쿠다사이.", translation: "네, 조금 후텁지근해요. 죄송하지만 에어컨 좀 켜주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、分かりました。温度は25度くらいでいいですか？", romaji: "하이, 와카리마시타. 온도와 니쥬-고도 쿠라이데 이이데스카?", translation: "네, 알겠습니다. 온도는 25도 정도로 괜찮을까요?", isUserLine: false)
        ],
        177: [ // 난방을 켜달라고 요청 - 暖房をつけてと頼む
            ConversationData(speaker: "사토", text: "なんだか足元が冷えますね。", romaji: "난다카 아시모토가 히에마스네.", translation: "왠지 발 쪽이 춥네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "私もです。すみません、少し寒いので、暖房をつけてください。", romaji: "와타시모데스. 스미마센, 스코시 사무이노데, 단보-오 츠케테쿠다사이.", translation: "저도요. 죄송하지만, 좀 추워서 난방 좀 켜주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、つけますね。これで少しは暖かくなると思います。", romaji: "하이, 츠케마스네. 코레데 스코시와 아타타카쿠 나루토 오모이마스.", translation: "네, 켤게요. 이걸로 좀 따뜻해질 거예요.", isUserLine: false)
        ],
        178: [ // 빈자리인지 묻기 - 空席か尋ねる
            ConversationData(speaker: "다른 손님", text: "(빈 의자 옆에 앉아있다)", romaji: "(빈 의자 옆에 앉아있다)", translation: "(빈 의자 옆에 앉아있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "あの、すみません。この席、空いていますか？", romaji: "아노, 스미마센. 코노 세키, 아이테이마스카?", translation: "저기, 실례합니다. 이 자리, 비어 있나요?", isUserLine: true),
            ConversationData(speaker: "다른 손님", text: "はい、空いてますよ。どうぞ。", romaji: "하이, 아이테마스요. 도-조.", translation: "네, 비어 있어요. 앉으세요.", isUserLine: false)
        ],
        179: [ // 와이파이 유무 묻기 - Wi-Fiの有無を尋ねる
            ConversationData(speaker: "점원", text: "ご注文はお決まりですか？", romaji: "고츄-몬와 오키마리데스카?", translation: "주문하시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、アイスコーヒーを一つ。それと、すみません、Wi-Fiはありますか？", romaji: "하이, 아이스코-히-오 히토츠. 소레토, 스미마센, 와이화이와 아리마스카?", translation: "네, 아이스 커피 하나요. 그리고 죄송하지만, 와이파이 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、ございます。パスワードはテーブルの上の案内にございます。", romaji: "하이, 고자이마스. 파스와-도와 테-부루노 우에노 안나이니 고자이마스.", translation: "네, 있습니다. 비밀번호는 테이블 위 안내문에 있습니다.", isUserLine: false)
        ],
        180: [ // 비밀번호 묻기 - パスワードを尋ねる
            ConversationData(speaker: "사토", text: "キムさん、パソコン使いますか？家のWi-Fi、使ってください。", romaji: "기무상, 파소콘 츠카이마스카? 우치노 와이화이, 츠캇테쿠다사이.", translation: "김 씨, 컴퓨터 쓸 거예요? 우리 집 와이파이 쓰세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます！助かります。パスワードを教えてください。", romaji: "아리가토-고자이마스! 타스카리마스. 파스와-도오 오시에테쿠다사이.", translation: "고맙습니다! 덕분에 살았어요. 비밀번호를 알려주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、メモしますね。「Sato-1234」です。", romaji: "하이, 메모시마스네. 「Sato-1234」데스.", translation: "네, 메모해 줄게요. 'Sato-1234'예요.", isUserLine: false)
        ],
        181: [ // 전적으로 동의하기 - 全面的に同意する
            ConversationData(speaker: "사토", text: "やはり、この問題の根本的な原因は、部署間のコミュニケーション不足にあると思います。", romaji: "야하리, 코노 몬다이노 콘폰테키나 겐인와, 부쇼칸노 코뮤니케-숀부소쿠니 아루토 오모이마스.", translation: "역시 이 문제의 근본적인 원인은 부서 간의 소통 부족에 있다고 생각합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、私もその通りだと思います。各部署が自分の仕事しか見ていないようです。", romaji: "하이, 와타시모 소노 토-리다토 오모이마스. 카쿠부쇼가 지분노 시고토시카 미테이나이요-데스.", translation: "네, 저도 말씀하신 대로라고 생각합니다. 각 부서가 자기 일밖에 보지 않는 것 같습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね。まずは情報共有の仕組みから見直す必要がありそうですね。", romaji: "데스요네. 마즈와 죠-호-쿄-유-노 시쿠미카라 미나오스 히츠요-가 아리소-데스네.", translation: "그렇죠. 우선은 정보 공유 체계부터 재검토할 필요가 있겠네요.", isUserLine: false)
        ],
        182: [ // 정중하게 거절하기 - 丁寧に断る
            ConversationData(speaker: "사토", text: "このレポート、申し訳ないけど、今日の夕方までに仕上げてもらえませんか？", romaji: "코노 레포-토, 모-시와케나이케도, 쿄-노 유-가타마데니 시아게테모라에마센카?", translation: "이 보고서, 미안하지만 오늘 저녁까지 마무리해 줄 수 없을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "今日の夕方までですか…。すみません、他の急ぎの案件もあって、ちょっと難しいですね。", romaji: "쿄-노 유-가타마데데스카... 스미마센, 호카노 이소기노 안켄모 앗테, 좃토 무즈카시-데스네.", translation: "오늘 저녁까지요…. 죄송합니다, 다른 급한 안건도 있어서 조금 어렵겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、そうでしたか。では、明日のできるだけ早い時間でお願いできますか。", romaji: "아아, 소-데시타카. 데와, 아시타노 데키루다케 하야이 지칸데 오네가이데키마스카.", translation: "아, 그랬군요. 그럼 내일 가능한 한 이른 시간까지 부탁할 수 있을까요?", isUserLine: false)
        ],
        183: [ // 다른 사람을 긍정적으로 묘사하기 - 他人を肯定的に描写する
            ConversationData(speaker: "사토", text: "新しく私たちのチームに来た鈴木さんって、どんな人ですか？", romaji: "아타라시쿠 와타시타치노 치-무니 키타 스즈키상테, 돈나 히토데스카?", translation: "새로 우리 팀에 온 스즈키 씨는 어떤 사람이에요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いつも笑顔で、誰にでも親切ですよ。彼は優しい人です。", romaji: "이츠모 에가오데, 다레니데모 신세츠데스요. 카레와 야사시- 히토데스.", translation: "항상 웃는 얼굴이고, 누구에게나 친절해요. 그는 다정한 사람이에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね、安心しました。これから一緒に働くのが楽しみです。", romaji: "소-난데스네, 안신시마시타. 코레카라 잇쇼니 하타라쿠노가 타노시미데스.", translation: "그렇군요, 안심했어요. 앞으로 함께 일하는 게 기대되네요.", isUserLine: false)
        ],
        184: [ // 다른 사람의 능력을 칭찬하기 - 他人の能力を褒める
            ConversationData(speaker: "사토", text: "山本さんは本当に仕事ができますね。どんな問題もすぐに解決してしまいます。", romaji: "야마모토상와 혼토-니 시고토가 데키마스네. 돈나 몬다이모 스구니 카이케츠시테시마이마스.", translation: "야마모토 씨는 정말 일을 잘하네요. 어떤 문제든 바로 해결해 버려요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、本当に。彼女は頭がいいです。いつも感心させられます。", romaji: "에에, 혼토-니. 카노조와 아타마가 이이데스. 이츠모 칸신사세라레마스.", translation: "네, 정말이에요. 그녀는 머리가 좋아요. 항상 감탄하게 돼요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、私たちも見習わないといけませんね。", romaji: "에에, 와타시타치모 미나라와나이토 이케마센네.", translation: "네, 우리도 본받아야겠어요.", isUserLine: false)
        ],
        185: [ // 서둘러 달라고 요청하기 - 急いでと頼む
            ConversationData(speaker: "기사", text: "お客様、道がかなり混んでいますね。", romaji: "오캬쿠사마, 미치가 카나리 콘데이마스네.", translation: "손님, 길이 꽤 막히네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、空港までお願いします。飛行機の時間に間に合わなそうなので、急いでください。", romaji: "스미마센, 쿠-코-마데 오네가이시마스. 히코-키노 지칸니 마니아와나소-나노데, 이소이데쿠다사이.", translation: "죄송합니다, 공항까지 부탁합니다. 비행기 시간에 늦을 것 같으니, 서둘러 주세요.", isUserLine: true),
            ConversationData(speaker: "기사", text: "かしこまりました。少しでも早いルートを探してみます。", romaji: "카시코마리마시타. 스코시데모 하야이 루-토오 사가시테미마스.", translation: "알겠습니다. 조금이라도 빠른 길을 찾아보겠습니다.", isUserLine: false)
        ],
        186: [ // 천천히 해도 된다고 말하기 - ゆっくりでいいと言う
            ConversationData(speaker: "사토", text: "すみません、この作業、思ったより時間がかかってしまって…。", romaji: "스미마센, 코노 사교-, 오못타요리 지칸가 카캇테시맛테...", translation: "죄송합니다, 이 작업, 생각보다 시간이 걸려서...", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫ですよ。特に急いでいるわけではないので、ゆっくりでいいですよ。", romaji: "다이죠-부데스요. 토쿠니 이소이데이루 와케데와 나이노데, 윳쿠리데 이이데스요.", translation: "괜찮아요. 특별히 서두르는 건 아니니, 천천히 하셔도 괜찮아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。そう言っていただけると助かります。", romaji: "아리가토-고자이마스. 소- 잇테이타다케루토 타스카리마스.", translation: "감사합니다. 그렇게 말씀해주시니 도움이 되네요.", isUserLine: false)
        ],
        187: [ // 거스름돈 사양하기 - お釣りを断る
            ConversationData(speaker: "기사", text: "料金は2800円になります。", romaji: "료-킨와 니센핫퍄쿠엔니 나리마스.", translation: "요금은 2800엔입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、これでお願いします。(3000円を渡しながら) お釣りは結構です。", romaji: "하이, 코레데 오네가이시마스. (산젠엔오 와타시나가라) 오츠리와 켓코-데스.", translation: "네, 이걸로 부탁합니다. (3000엔을 건네며) 거스름돈은 괜찮습니다.", isUserLine: true),
            ConversationData(speaker: "기사", text: "よろしいんですか？どうもありがとうございます。", romaji: "요로시-인데스카? 도-모 아리가토-고자이마스.", translation: "괜찮으시겠어요? 정말 감사합니다.", isUserLine: false)
        ],
        188: [ // 예약 사실 알리기 - 予約したことを伝える
            ConversationData(speaker: "점원", text: "いらっしゃいませ。何名様でしょうか？", romaji: "이랏샤이마세. 난메-사마데쇼-카?", translation: "어서 오세요. 몇 분이신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "こんばんは。7時に予約しています。名前はキムです。", romaji: "콘방와. 시치지니 요야쿠시테이마스. 나마에와 기무데스.", translation: "안녕하세요. 7시에 예약했습니다. 이름은 김입니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "キム様ですね。お待ちしておりました。こちらのお席へどうぞ。", romaji: "기무사마데스네. 오마치시테오리마시타. 코치라노 오세키에 도-조.", translation: "김 님이시군요. 기다리고 있었습니다. 이쪽 자리로 안내해 드리겠습니다.", isUserLine: false)
        ],
        189: [ // 자신을 겸손하게 소개하기 - 謙遜して自己紹介する
            ConversationData(speaker: "접수원", text: "本日のご用件をお伺いしてもよろしいでしょうか。", romaji: "혼지츠노 고요-켄오 오우카가이시테모 요로시-데쇼-카.", translation: "오늘 어떤 일로 오셨는지 여쭤봐도 괜찮을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。人事部の田中様と3時にお約束しております、私、キムと申します。", romaji: "하이. 진지부노 타나카사마토 산지니 오야쿠소쿠시테오리마스, 와타시, 기무토 모-시마스.", translation: "네. 인사부의 다나카 님과 3시에 약속이 잡혀있는, 저, 김이라고 합니다.", isUserLine: true),
            ConversationData(speaker: "접수원", text: "キム様ですね。承知いたしました。ただいま繋ぎますので、そちらでお待ちください。", romaji: "기무사마데스네. 쇼-치이타시마시타. 타다이마 츠나기마스노데, 소치라데 오마치쿠다사이.", translation: "김 님이시군요. 알겠습니다. 지금 연결해드릴 테니, 그쪽에서 잠시만 기다려주세요.", isUserLine: false)
        ],
        190: [ // 폐를 끼친 것에 대해 사과하기 - 迷惑をかけたことを謝罪する
            ConversationData(speaker: "사토", text: "(다음 날 아침) 皆さん、昨日は私の確認不足で、大変ご迷惑をおかけしました。", romaji: "미나산, 키노-와 와타시노 카쿠닌부소쿠데, 타이헨 고메-와쿠오 오카케시마시타.", translation: "여러분, 어제는 저의 확인 부족으로 큰 폐를 끼쳤습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、大丈夫ですよ。誰にでもミスはありますから、あまり気にしないでください。", romaji: "사토-상, 다이죠-부데스요. 다레니데모 미스와 아리마스카라, 아마리 키니시나이데쿠다사이.", translation: "사토 씨, 괜찮아요. 누구에게나 실수는 있으니, 너무 신경 쓰지 마세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。今後はこのようなことがないよう、徹底いたします。", romaji: "아리가토-고자이마스. 콘고와 코노요-나 코토가 나이요-, 텟테-이타시마스.", translation: "감사합니다. 앞으로는 이런 일이 없도록 철저히 하겠습니다.", isUserLine: false)
        ],
        191: [ // 시작을 제안하기 - 開始を提案する
            ConversationData(speaker: "사토", text: "皆さん、お揃いのようですね。", romaji: "미나상, 오소로이노요-데스네.", translation: "여러분, 다 모이신 것 같네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、時間もちょうどになりましたので、そろそろ始めましょうか。", romaji: "하이, 지칸모 쵸-도니 나리마시타노데, 소로소로 하지메마쇼-카.", translation: "네, 시간도 딱 되었으니, 슬슬 시작할까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、よろしくお願いします。", romaji: "하이, 요로시쿠 오네가이시마스.", translation: "네, 잘 부탁드립니다.", isUserLine: false)
        ],
        192: [ // 마무리를 제안하기 - 終わりを提案する
            ConversationData(speaker: "사토", text: "これで、予定していた議題は全て終わりましたね。", romaji: "코레데, 요테-시테이타 기다이와 스베테 오와리마시타네.", translation: "이것으로 예정했던 안건은 전부 끝났네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。特に他の意見がなければ、これで終わりにしましょう。", romaji: "하이. 토쿠니 호카노 이켄가 나케레바, 코레데 오와리니 시마쇼-.", translation: "네. 특별히 다른 의견 없으시면 이것으로 끝내도록 하죠.", isUserLine: true),
            ConversationData(speaker: "사토", text: "皆さん、お疲れ様でした。", romaji: "미나상, 오츠카레사마데시타.", translation: "여러분, 수고 많으셨습니다.", isUserLine: false)
        ],
        193: [ // 조심히 가라고 인사하기 - 気をつけて帰るよう挨拶する
            ConversationData(speaker: "사토", text: "では、私はこれで。お先に失礼します。", romaji: "데와, 와타시와 코레데. 오사키니 시츠레-시마스.", translation: "그럼 저는 이만. 먼저 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "お疲れ様でした。外はもう暗いので、気をつけて帰ってくださいね。", romaji: "오츠카레사마데시타. 소토와 모- 쿠라이노데, 키오츠케테 카엣테쿠다사이네.", translation: "수고하셨습니다. 밖은 이제 어두우니, 조심해서 돌아가세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ありがとうございます。キムさんもお気をつけて。", romaji: "하이, 아리가토-고자이마스. 기무상모 오키오츠케테.", translation: "네, 감사합니다. 김 씨도 조심하세요.", isUserLine: false)
        ],
        194: [ // 나중에 하겠다고 말하기 - 後でやると言う
            ConversationData(speaker: "사토", text: "キムさん、このアンケートの集計、お願いできますか？", romaji: "기무상, 코노 안케-토노 슈-케이, 오네가이데키마스카?", translation: "김 씨, 이 설문조사 집계 좀 부탁할 수 있을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、分かりました。今やっている作業が終わり次第、後でやります。", romaji: "하이, 와카리마시타. 이마 얏테이루 사교-가 오와리시다이, 아토데 야리마스.", translation: "네, 알겠습니다. 지금 하고 있는 작업이 끝나는 대로, 나중에 하겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "急ぎではないので、大丈夫です。よろしくお願いします。", romaji: "이소기데와 나이노데, 다이죠-부데스. 요로시쿠 오네가이시마스.", translation: "급한 건 아니니 괜찮습니다. 잘 부탁해요.", isUserLine: false)
        ],
        195: [ // 알레르기 유무 묻기 - アレルギーの有無を尋ねる
            ConversationData(speaker: "사토", text: "来週、新入社員の歓迎会を開きましょう。お店は私が予約しますね。", romaji: "라이슈-, 신뉴-샤인노 칸게-카이오 히라키마쇼-. 오미세와 와타시가 요야쿠시마스네.", translation: "다음 주에 신입사원 환영회를 엽시다. 가게는 제가 예약할게요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。助かります。", romaji: "아리가토-고자이마스. 타스카리마스.", translation: "감사합니다. 도움이 되겠네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "参加する皆さん、何か苦手な食べ物や、アレルギーはありますか？", romaji: "산카스루 미나상, 나니카 니가테나 타베모노야, 아레루기-와 아리마스카?", translation: "참석하는 여러분, 못 먹는 음식이나 알레르기는 있나요?", isUserLine: false)
        ],
        196: [ // 가벼운 제안하기 - 軽い誘い
            ConversationData(speaker: "사토", text: "今日は少し仕事が早く終わりそうですね。", romaji: "쿄-와 스코시 시고토가 하야쿠 오와리소-데스네.", translation: "오늘은 일이 좀 일찍 끝날 것 같네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ。もしよかったらこの後、駅前のカフェでコーヒーでも飲みませんか？", romaji: "에에. 모시 요캇타라 코노 아토, 에키마에노 카페데 코-히-데모 노미마센카?", translation: "네. 괜찮으시면 이따가 역 앞 카페에서 커피라도 한잔하지 않으실래요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "いいですね！ぜひ行きましょう。", romaji: "이이데스네! 제히 이키마쇼-.", translation: "좋아요! 꼭 가요.", isUserLine: false)
        ],
        197: [ // 도움을 제안하기 - 手伝いを申し出る
            ConversationData(speaker: "사토", text: "(무거운 상자를 여러 개 옮기며 힘들어한다) よいしょ…うーん…。", romaji: "(무거운 상자를 여러 개 옮기며 힘들어한다) 요잇쇼... 우-응...", translation: "(무거운 상자를 여러 개 옮기며 힘들어한다) 요잇쇼... 우-응...", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、一人で大丈夫ですか？重そうですね。手伝いましょうか？", romaji: "사토-상, 히토리데 다이죠-부데스카? 오모소-데스네. 테츠다이마쇼-카?", translation: "사토 씨, 혼자 괜찮으세요? 무거워 보이네요. 도와드릴까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、キムさん！ありがとうございます。では、こっちをお願いしてもいいですか？助かります。", romaji: "아, 기무상! 아리가토-고자이마스. 데와, 콧치오 오네가이시테모 이이데스카? 타스카리마스.", translation: "아, 김 씨! 고마워요. 그럼 이쪽을 좀 부탁해도 될까요? 덕분에 살겠네요.", isUserLine: false)
        ],
        198: [ // 제안을 흔쾌히 수락하기 - 誘いを快く承諾する
            ConversationData(speaker: "사토", text: "来週の土曜日、もし予定がなければ、一緒に映画でもどうですか？", romaji: "라이슈-노 도요-비, 모시 요테-가 나케레바, 잇쇼니 에-가데모 도-데스카?", translation: "다음 주 토요일에 혹시 약속 없으면, 같이 영화라도 어때요?", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですか？嬉しいです！ぜひお願いします。", romaji: "혼토-데스카? 우레시-데스! 제히 오네가이시마스.", translation: "정말요? 기뻐요! 꼭 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "よかった！じゃあ、詳細はまた連絡しますね。", romaji: "요캇타! 쟈-, 쇼-사이와 마타 렌라쿠시마스네.", translation: "다행이다! 그럼 자세한 내용은 다시 연락할게요.", isUserLine: false)
        ],
        199: [ // 유감, 아쉬움 표현하기 - 残念な気持ちを表現する
            ConversationData(speaker: "사토", text: "申し訳ありません。明日のイベント、急な出張で参加できなくなりました。", romaji: "모-시와케 아리마센. 아시타노 이벤토, 큐-나 슛쵸-데 산카데키나쿠 나리마시타.", translation: "죄송합니다. 내일 행사, 갑작스러운 출장으로 참석할 수 없게 되었습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうなんですか。佐藤さんと会えるのを楽しみにしていたので、残念です。", romaji: "소-난데스카. 사토-상토 아에루노오 타노시미니 시테이타노데, 잔넨데스.", translation: "그러세요? 사토 씨 만나는 걸 기대하고 있었는데, 아쉽네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私も本当に残念です。この埋め合わせは必ずしますので。", romaji: "와타시모 혼토-니 잔넨데스. 코노 우메아와세와 카나라즈 시마스노데.", translation: "저도 정말 아쉬워요. 이번 건 꼭 보답하겠습니다.", isUserLine: false)
        ],
        200: [ // 부러움 표현하기 - 羨ましい気持ちを表現する
            ConversationData(speaker: "사토", text: "来月の連休、有給も使って10日間ヨーロッパを旅行するんです。", romaji: "라이게츠노 렌큐-, 유-큐-모 츠캇테 토-카칸 요-롯파오 료코-스룬데스.", translation: "다음 달 연휴에 연차도 써서 열흘간 유럽 여행을 가요.", isUserLine: false),
            ConversationData(speaker: "나", text: "へえー、10日間もですか！それは羨ましいです。", romaji: "헤-, 토-카칸모데스카! 소레와 우라야마시-데스.", translation: "헤에, 열흘이나요? 그건 부럽네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "えへへ、今から計画を立てるのが楽しみです。お土産、買ってきますね。", romaji: "에헤헤, 이마카라 케-카쿠오 타테루노가 타노시미데스. 오미야게, 캇테키마스네.", translation: "에헤헤, 지금부터 계획 짜는 게 기대돼요. 선물 사 올게요.", isUserLine: false)
        ],
        201: [ // 물건을 줄 때 - 物をあげる時
            ConversationData(speaker: "사토", text: "キムさん、これ、好きだって言っていましたよね。", romaji: "기무상, 코레, 스키닷테 잇테이마시타요네.", translation: "김 씨, 이거 좋아한다고 말했었죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "あ、このキャラクター！はい、大好きです。", romaji: "아, 코노 캐릭터! 하이, 다이스키데스.", translation: "아, 이 캐릭터! 네, 정말 좋아해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "よかった。UFOキャッチャーで取ったんです。これ、あげます。", romaji: "요캇타. UFO캿챠-데 톳탄데스. 코레, 아게마스.", translation: "다행이다. 인형 뽑기에서 뽑았어요. 이거, 드릴게요.", isUserLine: false)
        ],
        202: [ // 받아도 되는지 물을 때 - もらっていいか尋ねる時
            ConversationData(speaker: "사토", text: "このお菓子、たくさんもらったので、よかったらキムさんもどうぞ。", romaji: "코노 오카시, 타쿠상 모랏타노데, 요캇타라 기무상모 도-조.", translation: "이 과자, 많이 받아서, 괜찮으면 김 씨도 드세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "わあ、いいんですか？本当に、もらってもいいですか？", romaji: "와아, 이인데스카? 혼토-니, 모랏테모 이이데스카?", translation: "와, 괜찮아요? 정말, 받아도 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "もちろんです。遠慮しないでください。", romaji: "모치론데스. 엔료시나이데 쿠다사이.", translation: "물론이죠. 사양하지 마세요.", isUserLine: false)
        ],
        203: [ // 여행 선물을 줄 때 - お土産を渡す時
            ConversationData(speaker: "사토", text: "キムさん、先週は夏休みでしたよね。", romaji: "기무상, 센슈-와 나츠야스미데시타요네.", translation: "김 씨, 지난주는 여름휴가였죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、沖縄に行ってきました。皆さんでどうぞ。これ、お土産です。", romaji: "하이, 오키나와니 잇테키마시타. 미나산데 도-조. 코레, 오미야게데스.", translation: "네, 오키나와에 다녀왔어요. 다 같이 드세요. 이거, 선물입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わあ、ありがとうございます！ちんすこう、大好きです。", romaji: "와아, 아리가토-고자이마스! 친스코-, 다이스키데스.", translation: "와아, 고맙습니다! 친스코, 정말 좋아해요.", isUserLine: false)
        ],
        204: [ // 음식이 맛있어 보일 때 - 食べ物が美味しそうに見える時
            ConversationData(speaker: "사토", text: "今日のランチはあそこの定食屋にしませんか？", romaji: "쿄-노 란치와 아소코노 테-쇼쿠야니 시마센카?", translation: "오늘 점심은 저기 정식집으로 하지 않을래요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいですね。あ、見てください、日替わり定食の天ぷら、とても美味しそうですね。", romaji: "이이데스네. 아, 미테쿠다사이, 히가와리 테-쇼쿠노 텐푸라, 토테모 오이시소-데스네.", translation: "좋아요. 아, 저것 좀 보세요, 오늘의 정식인 튀김, 정말 맛있겠네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当ですね。じゃあ、それにしましょうか。", romaji: "혼토-데스네. 쟈-, 소레니 시마쇼-카.", translation: "그러게요. 그럼, 그걸로 할까요?", isUserLine: false)
        ],
        205: [ // 계획이 재미있어 보일 때 - 計画が楽しそうに見える時
            ConversationData(speaker: "사토", text: "来週、会社の同僚たちとバーベキューをするんです。", romaji: "라이슈-, 카이샤노 도-료-타치토 바-베큐-오 스룬데스.", translation: "다음 주에 회사 동료들이랑 바비큐를 하기로 했어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "へえ、いいですね！それは楽しそうですね。", romaji: "헤에, 이이데스네! 소레와 타노시소-데스네.", translation: "헤에, 좋겠다! 그거 재미있겠네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ。キムさんも都合が合えば来ませんか？", romaji: "에에. 기무상모 츠고-가 아에바 키마센카?", translation: "네. 김 씨도 시간 맞으면 오지 않을래요?", isUserLine: false)
        ],
        206: [ // 졸려 보인다고 말할 때 - 眠そうに見えると言う時
            ConversationData(speaker: "사토", text: "(회의 중에 크게 하품한다) ふわぁ〜あ。", romaji: "(회의 중에 크게 하품한다) 후아아~.", translation: "(회의 중에 크게 하품한다)", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、眠そうですね。昨日の夜、あまり眠れませんでしたか？", romaji: "사토-상, 네무소-데스네. 키노-노 요루, 아마리 네무레마센데시타카?", translation: "사토 씨, 졸려 보이네요. 어젯밤에 잘 못 잤어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ワールドカップの試合を見てしまって…。", romaji: "하이, 와-루도캇푸노 시아이오 미테시맛테...", translation: "네, 월드컵 경기를 봐 버려서...", isUserLine: false)
        ],
        207: [ // 피곤함을 표현할 때 - 疲れていると表現する時
            ConversationData(speaker: "사토", text: "キムさん、なんだか元気がないようですが、大丈夫ですか？", romaji: "기무상, 난다카 겐키가 나이요-데스가, 다이죠-부데스카?", translation: "김 씨, 왠지 기운이 없어 보이는데, 괜찮아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ…今週は残業が多くて、正直、かなり疲れています。", romaji: "에에... 콘슈-와 잔교-가 오-쿠테, 쇼-지키, 카나리 츠카레테이마스.", translation: "네… 이번 주는 야근이 많아서, 솔직히 꽤 피곤합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうでしたか。週末は何も考えずに、ゆっくり休んでくださいね。", romaji: "소-데시타카. 슈-마츠와 나니모 칸가에즈니, 윳쿠리 야슨데쿠다사이네.", translation: "그랬군요. 주말에는 아무 생각 말고 푹 쉬세요.", isUserLine: false)
        ],
        208: [ // 주말 계획 묻기 - 週末の予定を尋ねる
            ConversationData(speaker: "사토", text: "明日で今週も終わりですね。", romaji: "아시타데 콘슈-모 오와리데스네.", translation: "내일이면 이번 주도 끝이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。佐藤さん、今度の週末、何か予定はありますか？", romaji: "하이. 사토-상, 콘도노 슈-마츠, 나니카 요테-와 아리마스카?", translation: "네. 사토 씨, 이번 주말에 무슨 계획 있어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "いえ、まだ何も決まっていませんよ。", romaji: "이에, 마다 나니모 키맛테이마센요.", translation: "아니요, 아직 아무것도 정해진 게 없어요.", isUserLine: false)
        ],
        209: [ // 계획이 없다고 답하기 - 予定がないと答える
            ConversationData(speaker: "사토", text: "今度の三連休、何か計画はありますか？", romaji: "콘도노 산렌큐-, 나니카 케-카쿠와 아리마스카?", translation: "이번 사흘 연휴에 무슨 계획 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いえ、特にないです。多分、家でゴロゴロしていると思います。", romaji: "이에, 토쿠니 나이데스. 타분, 우치데 고로고로시테이루토 오모이마스.", translation: "아니요, 특별히 없어요. 아마 집에서 뒹굴뒹굴하고 있을 것 같아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね。それも最高の休日ですね。", romaji: "소-난데스네. 소레모 사이코-노 큐-지츠데스네.", translation: "그렇군요. 그것도 최고의 휴일이죠.", isUserLine: false)
        ],
        210: [ // 영화 보러 가자고 제안하기 - 映画に誘う
            ConversationData(speaker: "사토", text: "キムさん、週末はいつも何をしていますか？", romaji: "기무상, 슈-마츠와 이츠모 나니오 시테이마스카?", translation: "김 씨, 주말에는 보통 뭐 해요?", isUserLine: false),
            ConversationData(speaker: "나", text: "たいてい家で本を読んでいますね。", romaji: "타이테- 우치데 혼오 욘데이마스네.", translation: "대개 집에서 책을 읽어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか。もしよかったら、今度一緒に映画でも見に行きませんか？", romaji: "소-데스카. 모시 요캇타라, 콘도 잇쇼니 에-가데모 미니 이키마센카?", translation: "그래요? 괜찮으면 다음에 같이 영화라도 보러 가지 않을래요?", isUserLine: false)
        ],
        211: [ // 물 한 잔 요청하기 - お水を一杯頼む
            ConversationData(speaker: "사토", text: "(식사 중 기침을 한다) ケホッ、ケホッ。", romaji: "게홋, 게홋.", translation: "콜록, 콜록.", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫ですか？すみません、店員さん。お水を一杯ください。", romaji: "다이죠-부데스카? 스미마센, 텐인상. 오미즈오 잇파이 쿠다사이.", translation: "괜찮으세요? 죄송합니다, 점원분. 물 한 잔 주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、かしこまりました。すぐにお持ちします。", romaji: "하이, 카시코마리마시타. 스구니 오모치시마스.", translation: "네, 알겠습니다. 바로 가져다드리겠습니다.", isUserLine: false)
        ],
        212: [ // 조미료 부탁하기 - 調味料を頼む
            ConversationData(speaker: "사토", text: "このパスタ、もう少し味が濃くてもいいかもしれませんね。", romaji: "코노 파스타, 모-스코시 아지가 코쿠테모 이이카모 시레마센네.", translation: "이 파스타, 맛이 조금 더 진해도 괜찮겠네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。すみません、テーブルの端にある塩を取ってください。", romaji: "소-데스네. 스미마센, 테-부루노 하시니 아루 시오오 톳테 쿠다사이.", translation: "그러게요. 죄송하지만, 테이블 끝에 있는 소금 좀 집어주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、どうぞ。", romaji: "하이, 도-조.", translation: "네, 여기요.", isUserLine: false)
        ],
        213: [ // 사진 찍어주겠다고 제안하기 - 写真を撮ってあげると提案する
            ConversationData(speaker: "사토", text: "(친구와 함께 풍경을 배경으로 셀카를 찍으려 애쓴다) うーん、うまく入らないな…。", romaji: "우-응, 우마쿠 하이라나이나...", translation: "음, 잘 안 들어오네...", isUserLine: false),
            ConversationData(speaker: "나", text: "あのう、もしよかったら、私が写真を撮りましょうか？", romaji: "아노-, 모시 요캇타라, 와타시가 샤신오 토리마쇼-카?", translation: "저기, 괜찮으시면 제가 사진을 찍어드릴까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "えっ、本当ですか？ありがとうございます！お願いします。", romaji: "엣, 혼토-데스카? 아리가토-고자이마스! 오네가이시마스.", translation: "엣, 정말요? 고맙습니다! 부탁드려요.", isUserLine: false)
        ],
        214: [ // 천천히 걸어달라고 부탁하기 - ゆっくり歩いてと頼む
            ConversationData(speaker: "사토", text: "(앞서가며) ほら、早くしないとバスに乗り遅れちゃいますよ！", romaji: "호라, 하야쿠 시나이토 바스니 노리오쿠레챠이마스요!", translation: "자, 서두르지 않으면 버스를 놓치겠어요!", isUserLine: false),
            ConversationData(speaker: "나", text: "ちょっと待ってください！ヒールを履いているので、もう少しゆっくり歩いてください。", romaji: "좃토 맛테쿠다사이! 히-루오 하이테이루노데, 모-스코시 윳쿠리 아루이테쿠다사이.", translation: "잠깐만요! 힐을 신어서, 조금만 더 천천히 걸어주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、ごめんなさい。全然気づきませんでした。", romaji: "아, 고멘나사이. 젠젠 키즈키마센데시타.", translation: "아, 미안해요. 전혀 몰랐어요.", isUserLine: false)
        ],
        215: [ // 길을 잃은 것 같다고 말하기 - 道に迷ったみたいだと伝える
            ConversationData(speaker: "사토", text: "地図ではこの辺りのはずなのに、目的のカフェが見つからないね。", romaji: "치즈데와 코노 아타리노 하즈나노니, 모쿠테키노 카페가 미츠카라나이네.", translation: "지도상으로는 이 근처일 텐데, 목적지인 카페가 안 보이네.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、周りの景色も全然違います。どうやら、完全に道に迷ったみたいです。", romaji: "에에, 마와리노 케시키모 젠젠 치가이마스. 도-야라, 칸젠니 미치니 마욧타 미타이데스.", translation: "네, 주변 풍경도 전혀 달라요. 아무래도 완전히 길을 잃은 것 같아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "困ったな。あそこの人に道を聞いてみましょう。", romaji: "코맛타나. 아소코노 히토니 미치오 키이테미마쇼-.", translation: "곤란하네. 저기 있는 사람에게 길을 물어봐요.", isUserLine: false)
        ],
        216: [ // 역까지의 거리 묻기 - 駅までの距離を尋ねる
            ConversationData(speaker: "사토", text: "この道をまっすぐ行けば駅だと聞きましたが、結構歩きますね。", romaji: "코노 미치오 맛스구 이케바 에키다토 키키마시타가, 켓코- 아루키마스네.", translation: "이 길로 쭉 가면 역이라고 들었는데, 꽤 걷네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。すみません、ここから駅までどのくらいですか？", romaji: "소-데스네. 스미마센, 코코카라 에키마데 도노쿠라이데스카?", translation: "그러게요. 실례합니다, 여기서부터 역까지는 어느 정도 걸려요?", isUserLine: true),
            ConversationData(speaker: "행인", text: "歩いて15分くらいかかりますよ。", romaji: "아루이테 쥬-고훈 쿠라이 카카리마스요.", translation: "걸어서 15분 정도 걸립니다.", isUserLine: false)
        ],
        217: [ // 현금 결제만 가능한지 묻기 - 現金しか使えないか尋ねる
            ConversationData(speaker: "점원", text: "お会計、1,200円になります。", romaji: "오카이케-, 센니햐쿠엔니 나리마스.", translation: "계산, 1,200엔입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。(카드를 내밀며) あれ、もしかして、現金しか使えませんか？", romaji: "하이. (카-도오 내밀며) 아레, 모시카시테, 겐킨시카 츠카에마센카?", translation: "네. (카드를 내밀며) 어라, 혹시 현금만 사용 가능한가요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、申し訳ございません。当店では現金のみのお取り扱いとなっております。", romaji: "하이, 모-시와케고자이마센. 토-텐데와 겐킨노미노 오토리아츠카이토 낫테오리마스.", translation: "네, 죄송합니다. 저희 가게는 현금만 취급하고 있습니다.", isUserLine: false)
        ],
        218: [ // 데워달라고 부탁하기 - 温めてと頼む
            ConversationData(speaker: "편의점 직원", text: "お弁当、お一つでよろしいですか？", romaji: "오벤토-, 오히토츠데 요로시-데스카?", translation: "도시락, 하나로 괜찮으세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。すみません、これ、温めてください。", romaji: "하이. 스미마센, 코레, 아타타메테쿠다사이.", translation: "네. 죄송하지만, 이거 데워주세요.", isUserLine: true),
            ConversationData(speaker: "편의점 직원", text: "かしこまりました。少々お待ちください。", romaji: "카시코마리마시타. 쇼-쇼- 오마치쿠다사이.", translation: "알겠습니다. 잠시만 기다려주세요.", isUserLine: false)
        ],
        219: [ // 봉투 사양하기 - 袋を断る
            ConversationData(speaker: "편의점 직원", text: "袋にお入れしますか？", romaji: "후쿠로니 오이레시마스카?", translation: "봉투에 넣어드릴까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、袋は結構です。自分のカバンに入れますので。", romaji: "이이에, 후쿠로와 켓코-데스. 지분노 카방니 이레마스노데.", translation: "아니요, 봉투는 괜찮습니다. 제 가방에 넣을 거라서요.", isUserLine: true),
            ConversationData(speaker: "편의점 직원", text: "かしこまりました。シールでよろしいですか？", romaji: "카시코마리마시타. 시-루데 요로시-데스카?", translation: "알겠습니다. 스티커로 괜찮으시겠어요?", isUserLine: false)
        ],
        220: [ // 전언 부탁하기 - 伝言を頼む
            ConversationData(speaker: "다른 직원", text: "申し訳ありません、佐藤はただいま他の電話に出ております。", romaji: "모-시와케 아리마센, 사토-와 타다이마 호카노 덴와니 데테오리마스.", translation: "죄송합니다, 사토는 지금 다른 전화를 받고 있습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですか。では、戻られましたら伝言をお願いできますか？", romaji: "소-데스카. 데와, 모도라레마시타라 덴곤오 오네가이데키마스카?", translation: "그런가요. 그럼, 돌아오시면 메시지 좀 부탁드려도 될까요?", isUserLine: true),
            ConversationData(speaker: "다른 직원", text: "はい、かしこまりました。ご用件をお伺いいたします。", romaji: "하이, 카시코마리마시타. 고요-켄오 오우카가이이타시마스.", translation: "네, 알겠습니다. 용건을 말씀해주십시오.", isUserLine: false)
        ],
        221: [ // 어렵지 않다고 말하기 - 難しくないと伝える
            ConversationData(speaker: "사토", text: "キムさん、この新しいソフトウェア、使いこなせるか心配です。", romaji: "기무상, 코노 아타라시- 소후토웨어, 츠카이코나세루카 신파이데스.", translation: "김 씨, 이 새로운 소프트웨어, 제대로 다룰 수 있을지 걱정이에요.", isUserLine: false),
            ConversationData(speaker: "나", text: "最初は誰でもそうですよ。でも、慣れればそんなに難しくないです。", romaji: "사이쇼와 다레데모 소-데스요. 데모, 나레레바 손나니 무즈카시쿠나이데스.", translation: "처음엔 누구나 그래요. 하지만 익숙해지면 그렇게 어렵지 않아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当ですか？少し安心しました。頑張ってみます。", romaji: "혼토-데스카? 스코시 안신시마시타. 간밧테미마스.", translation: "정말요? 조금 안심했어요. 열심히 해볼게요.", isUserLine: false)
        ],
        222: [ // 걱정 끼친 것에 대해 사과하기 - 心配をかけたことを謝罪する
            ConversationData(speaker: "사토", text: "キムさん！昨日は連絡が取れなくて、みんな心配しましたよ！", romaji: "기무상! 키노-와 렌라쿠가 토레나쿠테, 민나 신파이시마시타요!", translation: "김 씨! 어제는 연락이 안 돼서 다들 걱정했어요!", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません。携帯の電源が切れてしまって…。心配をかけてすみません。", romaji: "스미마센. 케-타이노 덴겐가 키레테시맛테... 신파이오 카케테 스미마센.", translation: "죄송합니다. 휴대폰 전원이 나가버려서... 걱정을 끼쳐 죄송합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですか。何事もなくて、本当によかったです。", romaji: "소-닷탄데스카. 나니고토모 나쿠테, 혼토-니 요캇타데스.", translation: "그랬군요. 아무 일 없어서 정말 다행이에요.", isUserLine: false)
        ],
        223: [ // 설명 요청하기 - 説明を要求する
            ConversationData(speaker: "사토", text: "というわけで、このプランで進めたいと思います。ご賛同いただけますか？", romaji: "토이우 와케데, 코노 푸란데 스스메타이토 오모이마스. 고산도- 이타다케마스카?", translation: "이러한 이유로, 이 플랜으로 진행하고 싶습니다. 찬성해주시겠습니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "申し訳ありません、まだ理解できていない部分があります。このグラフについて、もう一度説明してください。", romaji: "모-시와케 아리마센, 마다 리카이데키테이나이 부분가 아리마스. 코노 구라후니 츠이테, 모-이치도 세츠메-시테 쿠다사이.", translation: "죄송합니다만, 아직 이해하지 못한 부분이 있습니다. 이 그래프에 대해 다시 한번 설명해 주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、かしこまりました。このグラフが示しているのは…。", romaji: "하이, 카시코마리마시타. 코노 구라후가 시메시테이루노와...", translation: "네, 알겠습니다. 이 그래프가 나타내고 있는 것은...", isUserLine: false)
        ],
        224: [ // 의미를 모르겠다고 말하기 - 意味が分からないと伝える
            ConversationData(speaker: "사토", text: "この件は「善処します」とお客様に伝えました。", romaji: "코노 켄와 「젠쇼시마스」토 오캬쿠사마니 츠타에마시타.", translation: "이 건은 '잘 처리하겠습니다'라고 고객님께 전달했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、「善処します」という言葉の、正確な意味が分かりません。", romaji: "스미마센, 「젠쇼시마스」토이우 코토바노, 세-카쿠나 이미가 와카리마센.", translation: "죄송합니다, '젠쇼시마스'라는 말의 정확한 의미를 모르겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "状況に合わせて、適切に対応する、という意味合いで使われますね。", romaji: "죠-쿄-니 아와세테, 테키세츠니 타이오-스루, 토이우 이미아이데 츠카와레마스네.", translation: "상황에 맞춰 적절하게 대응하겠다는 뉘앙스로 사용돼요.", isUserLine: false)
        ],
        225: [ // 도울 일이 있는지 묻기 - 手伝うことがあるか尋ねる
            ConversationData(speaker: "사토", text: "(행사 준비로 바쁘게 움직이며) あれもやらなきゃ、これもやらなきゃ…。", romaji: "아레모 야라나캬, 코레모 야라나캬...", translation: "저것도 해야 하고, 이것도 해야 하고...", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、とてもお忙しそうですね。私に何か手伝うことはありますか？", romaji: "사토-상, 토테모 오이소가시소-데스네. 와타시니 나니카 테츠다우 코토와 아리마스카?", translation: "사토 씨, 무척 바빠 보이시네요. 제가 뭔가 도와드릴 일이라도 있나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "キムさん！ありがとうございます。じゃあ、こちらの荷物をあっちに運んでもらえますか？", romaji: "기무상! 아리가토-고자이마스. 쟈-, 코치라노 니모츠오 앗치니 하콘데모라에마스카?", translation: "김 씨! 고마워요. 그럼 이쪽 짐을 저쪽으로 옮겨줄 수 있어요?", isUserLine: false)
        ],
        226: [ // 우산 빌려달라고 부탁하기 - 傘を貸してと頼む
            ConversationData(speaker: "사토", text: "天気予報では晴れだったのに、すごい雨ですね。", romaji: "텐키요호-데와 하레닷타노니, 스고이 아메데스네.", translation: "일기예보에서는 맑음이었는데, 엄청난 비네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。私、傘を持っていないんです。すみませんが、傘を貸してください。", romaji: "혼토-데스네. 와타시, 카사오 못테이나인데스. 스미마센가, 카사오 카시테 쿠다사이.", translation: "그러게요. 저, 우산을 안 가져왔어요. 죄송하지만 우산 좀 빌려주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "私は折り畳み傘しかありませんが、それでもよければどうぞ。", romaji: "와타시와 오리타타미가사시카 아리마센가, 소레데모 요케레바 도-조.", translation: "저는 접는 우산밖에 없지만, 그래도 괜찮다면 여기요.", isUserLine: false)
        ],
        227: [ // 충전 허락받기 - 充電の許可を求める
            ConversationData(speaker: "사토", text: "どうぞ、ゆっくりしていってくださいね。", romaji: "도-조, 윳쿠리 시테잇테 쿠다사이네.", translation: "자, 편하게 있다 가세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。あの、すみません、携帯の電池がなくなりそうで。ここで充電してもいいですか？", romaji: "아리가토-고자이마스. 아노, 스미마센, 케-타이노 덴치가 나쿠나리소-데. 코코데 쥬-덴시테모 이이데스카?", translation: "감사합니다. 저, 죄송한데, 휴대폰 배터리가 곧 나갈 것 같아서요. 여기서 충전해도 될까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "もちろん。そこのコンセントを使ってください。", romaji: "모치론. 소코노 콘센토오 츠캇테 쿠다사이.", translation: "물론이지. 저기 콘센트 써.", isUserLine: false)
        ],
        228: [ // 콘센트 위치 묻기 - コンセントの場所を尋ねる
            ConversationData(speaker: "사토", text: "カフェで少しパソコン作業をしましょうか。", romaji: "카페데 스코시 파소콘사교-오 시마쇼-카.", translation: "카페에서 잠시 컴퓨터 작업이라도 할까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいですね。すみません、この辺りにコンセントはどこですか？", romaji: "이이데스네. 스미마센, 코노 아타리니 콘센토와 도코데스카?", translation: "좋아요. 실례합니다, 이 근처에 콘센트는 어디에 있나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あそこの壁際の席なら、足元にありますよ。", romaji: "아소코노 카베기와노 세키나라, 아시모토니 아리마스요.", translation: "저쪽 벽가 자리에 가면 발밑에 있어요.", isUserLine: false)
        ],
        229: [ // 택시 불러달라고 부탁하기 - タクシーを呼んでと頼む
            ConversationData(speaker: "호텔 직원", text: "ご利用ありがとうございました。", romaji: "고리요- 아리가토-고자이마시타.", translation: "이용해 주셔서 감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。すみません、空港まで行きたいのですが、タクシーを呼んでください。", romaji: "코치라코소. 스미마센, 쿠-코-마데 이키타이노데스가, 타쿠시-오 욘데쿠다사이.", translation: "저야말로요. 죄송합니다, 공항까지 가고 싶은데, 택시를 불러주세요.", isUserLine: true),
            ConversationData(speaker: "호텔 직원", text: "はい、かしこまりました。ただいま手配いたします。", romaji: "하이, 카시코마리마시타. 타다이마 테하이이타시마스.", translation: "네, 알겠습니다. 지금 바로 준비하겠습니다.", isUserLine: false)
        ],
        230: [ // 머리가 멍한 상태 표현하기 - 頭がぼーっとすると表現する
            ConversationData(speaker: "사토", text: "キムさん、大丈夫ですか？なんだか上の空みたいですよ。", romaji: "기무상, 다이죠-부데스카? 난다카 우와노소라 미타이데스요.", translation: "김 씨, 괜찮아요? 왠지 정신이 딴 데 가 있는 것 같아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、昨夜あまり眠れなくて、朝から頭がぼーっとします。", romaji: "스미마센, 사쿠야 아마리 네무레나쿠테, 아사카라 아타마가 보-っと 시마스.", translation: "죄송합니다, 어젯밤에 잘 못 자서 아침부터 머리가 멍합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですか。眠い時は、一度冷たい水で顔を洗うといいですよ。", romaji: "소-닷탄데스카. 네무이 토키와, 이치도 츠메타이 미즈데 카오오 아라우토 이이데스요.", translation: "그랬군요. 졸릴 때는 일단 찬물로 세수하면 좋아요.", isUserLine: false)
        ],
        231: [ // 굳이 말하자면 어느 한쪽을 선택할 때 - 굳이 말하자면 어느 한쪽을 선택할 때
            ConversationData(speaker: "사토", text: "キムさんは、インドア派ですか、それともアウトドア派ですか？", romaji: "기무상와, 인도아하데스카, 소레토모 아우토도아하데스카?", translation: "김 씨는 집에서 지내는 타입이에요, 아니면 야외 활동 타입이에요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、難しい質問ですね。どちらかと言うと、家で本を読む方が好きなので、インドア派かもしれません。", romaji: "우-응, 무즈카시- 시츠몬데스네. 도치라카토 이우토, 우치데 혼오 요무 호-가 스키나노데, 인도아하카모 시레마센.", translation: "음, 어려운 질문이네요. 굳이 말하자면 집에서 책 읽는 걸 더 좋아해서, 인도어 파일지도 모르겠네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね。私は体を動かすのが好きなので、完全なアウトドア派です。", romaji: "소-난데스네. 와타시와 카라다오 우고카스노가 스키나노데, 칸젠나 아우토도아하데스.", translation: "그렇군요. 저는 몸을 움직이는 걸 좋아해서 완전한 아웃도어 파예요.", isUserLine: false)
        ],
        232: [ // 본 경험에 대해 말하기 - 본 경험에 대해 말하기
            ConversationData(speaker: "사토", text: "この俳優さん、最近ドラマでよく見かけますね。", romaji: "코노 하이유-상, 사이킨 도라마데 요쿠 미카케마스네.", translation: "이 배우, 요즘 드라마에서 자주 보이네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、私も他の映画で見たことがあります。とても演技が上手な方ですよね。", romaji: "에에, 와타시모 호카노 에-가데 미타코토가 아리마스. 토테모 엔기가 죠-즈나 카타데스요네.", translation: "네, 저도 다른 영화에서 본 적이 있어요. 연기를 아주 잘하는 분이죠.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ですよね。すっかりファンになってしまいました。", romaji: "데스요네. 슷카리 환니 낫테시마이마시타.", translation: "그렇죠. 완전히 팬이 되어 버렸어요.", isUserLine: false)
        ],
        233: [ // 들은 경험에 대해 말하기 - 들은 경험에 대해 말하기
            ConversationData(speaker: "사토", text: "「Official髭男dism」というバンド、知っていますか？", romaji: "「오휘샤루히게단디즈무」토이우 반도, 싯테이마스카?", translation: "'오피셜히게단디즘'이라는 밴드, 아세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ああ、名前は聞いたことがあります。でも、曲は詳しく知らなくて。", romaji: "아아, 나마에와 키이타코토가 아리마스. 데모, 쿄쿠와 쿠와시쿠 시라나쿠테.", translation: "아, 이름은 들어본 적이 있어요. 하지만 노래는 자세히 몰라서요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "とてもいい歌が多いですよ。今度、おすすめの曲を教えますね。", romaji: "토테모 이이 우타가 오-이데스요. 콘도, 오스스메노 쿄쿠오 오시에마스네.", translation: "아주 좋은 노래가 많아요. 다음에 추천곡을 알려드릴게요.", isUserLine: false)
        ],
        234: [ // 조용히 해달라고 요청하기 - 조용히 해달라고 요청하기
            ConversationData(speaker: "나", text: "あのう、すみません。映画に集中したいので、もう少し静かにしてください。", romaji: "아노-, 스미마센. 에-가니 슈-츄-시타이노데, 모-스코시 시즈카니 시테쿠다사이.", translation: "저기, 죄송합니다. 영화에 집중하고 싶어서, 조금만 더 조용히 해 주세요.", isUserLine: true),
            ConversationData(speaker: "다른 관객", text: "あ、申し訳ありません。気をつけます。", romaji: "아, 모-시와케 아리마센. 키오츠케마스.", translation: "아, 죄송합니다. 조심하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。", romaji: "아리가토-고자이마스.", translation: "감사합니다.", isUserLine: true)
        ],
        235: [ // 만지지 말라고 경고하기 - 만지지 말라고 경고하기
            ConversationData(speaker: "나", text: "お嬢ちゃん、危ないよ。それは大切な作品だから、触らないでくださいね。", romaji: "오죠-쨩, 아부나이요. 소레와 타이세츠나 사쿠힌다카라, 사와라나이데 쿠다사이네.", translation: "아가씨, 위험해요. 그건 소중한 작품이니까, 만지지 마세요.", isUserLine: true),
            ConversationData(speaker: "아이 엄마", text: "こら！すみません、教えてくださってありがとうございます。", romaji: "코라! 스미마센, 오시에테쿠다삿테 아리가토-고자이마스.", translation: "이놈! 죄송합니다, 알려주셔서 감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、お気になさらずに。", romaji: "이에이에, 오키니나사루즈니.", translation: "아니에요, 신경 쓰지 마세요.", isUserLine: true)
        ],
        236: [ // 짐을 둬도 되는지 허락받기 - 짐을 둬도 되는지 허락받기
            ConversationData(speaker: "사토", text: "では、こちらのテーブルに座りましょうか。", romaji: "데와, 코치라노 테-부루니 스와리마쇼-카.", translation: "그럼, 이쪽 테이블에 앉을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。すみません、このキャリーバッグ、隣の椅子に置いてもいいですか？", romaji: "하이. 스미마센, 코노 캬리-박구, 토나리노 이스니 오이테모 이이데스카?", translation: "네. 죄송하지만, 이 캐리어 가방, 옆 의자에 둬도 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、もちろん大丈夫ですよ。", romaji: "에에, 모치론 다이죠-부데스요.", translation: "네, 물론 괜찮아요.", isUserLine: false)
        ],
        237: [ // 다음 전철 시간 묻기 - 다음 전철 시간 묻기
            ConversationData(speaker: "사토", text: "ああ、目の前で電車が行ってしまいましたね。", romaji: "아아, 메노마에데 덴샤가 잇테시마이마시타네.", translation: "아, 눈앞에서 전철이 가버렸네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。すみません、駅員さん、次の電車は何時ですか？", romaji: "혼토-데스네. 스미마센, 에키인상, 츠기노 덴샤와 난지데스카?", translation: "그러게요. 실례합니다, 역무원님, 다음 전철은 몇 시에 있나요?", isUserLine: true),
            ConversationData(speaker: "역무원", text: "次の普通列車は、5分後の15時10分発です。", romaji: "츠기노 후츠-렛샤와, 고훈고노 쥬-고지 쥿뿐파츠데스.", translation: "다음 보통 열차는 5분 뒤인 15시 10분 출발입니다.", isUserLine: false)
        ],
        238: [ // 전철 행선지 확인하기 - 전철 행선지 확인하기
            ConversationData(speaker: "사토", text: "電車が来ましたよ。急いで乗りましょう。", romaji: "덴샤가 키마시타요. 이소이데 노리마쇼-.", translation: "전철 왔어요. 서둘러 탑시다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ちょっと待ってください。念のため。すみません、この電車は渋谷に行きますか？", romaji: "좃토 맛테쿠다사이. 넨노타메. 스미마센, 코노 덴샤와 시부야니 이키마스카?", translation: "잠깐만요. 만약을 위해서. 실례합니다, 이 전철 시부야에 가나요?", isUserLine: true),
            ConversationData(speaker: "다른 승객", text: "いえ、これは反対方面行きですよ。渋谷行きは向かいのホームです。", romaji: "이에, 코레와 한타이 호-멘 유키데스요. 시부야 유키와 무카이노 호-무데스.", translation: "아니요, 이건 반대 방향 행이에요. 시부야행은 맞은편 승강장입니다.", isUserLine: false)
        ],
        239: [ // 교통카드 충전 요청하기 - 교통카드 충전 요청하기
            ConversationData(speaker: "편의점 직원", text: "いらっしゃいませ。", romaji: "이랏샤이마세.", translation: "어서 오세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、このパスモにチャージしてください。2千円お願いします。", romaji: "스미마센, 코노 파스모니 챠-지시테 쿠다사이. 니센엔 오네가이시마스.", translation: "실례합니다, 이 파스모에 충전해주세요. 2,000엔 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "편의점 직원", text: "かしこまりました。では、こちらの機械にタッチしてください。", romaji: "카시코마리마시타. 데와, 코치라노 키카이니 탓치시테 쿠다사이.", translation: "알겠습니다. 그럼, 이쪽 기계에 터치해주세요.", isUserLine: false)
        ],
        240: [ // 흡연을 삼가달라고 요청하기 - 흡연을 삼가달라고 요청하기
            ConversationData(speaker: "나", text: "佐藤さん、すみません。あそこに書いてある通り、この辺りは喫煙はご遠慮ください、とのことですよ。", romaji: "사토-상, 스미마센. 아소코니 카이테아루 토-리, 코노 아타리와 키츠엔와 고엔료쿠다사이, 토노코토데스요.", translation: "사토 씨, 죄송해요. 저기에 쓰여 있는 대로, 이 근처는 흡연을 삼가달라고 하네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "おっと、本当だ。気づきませんでした。ありがとうございます。", romaji: "옷토, 혼토-다. 키즈키마센데시타. 아리가토-고자이마스.", translation: "おっと, 정말이네. 몰랐어요. 고마워요.", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、お互い様ですから。", romaji: "이에이에, 오타가이사마데스카라.", translation: "아니에요, 서로 도와야죠.", isUserLine: true)
        ],
        241: [ // 의도치 않았음을 해명하기 - 의도치 않았음을 해명하기
            ConversationData(speaker: "사토", text: "キムさんの冗談、少し傷つきましたよ。", romaji: "기무상노 죠-단, 스코시 키즈츠키마시타요.", translation: "김 씨의 농담, 조금 상처받았어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "えっ、すみません！そんなつもりじゃなかったです。本当にごめんなさい。", romaji: "엣, 스미마센! 손나 츠모리쟈 나캇타데스. 혼토-니 고멘나사이.", translation: "엣, 죄송해요! 그럴 생각은 아니었어요. 정말 미안해요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "分かっています。でも、これからはもう少し言葉を選んでくださいね。", romaji: "와캇테이마스. 데모, 코레카라와 모-스코시 코토바오 에란데쿠다사이네.", translation: "알고 있어요. 그래도 앞으로는 말을 좀 더 가려서 해주세요.", isUserLine: false)
        ],
        242: [ // 고의가 아님을 강조하기 - 고의가 아님을 강조하기
            ConversationData(speaker: "사토", text: "あっ、私のパソコンにコーヒーを！", romaji: "앗, 와타시노 파소콘니 코-히-오!", translation: "앗, 내 컴퓨터에 커피를!", isUserLine: false),
            ConversationData(speaker: "나", text: "大変申し訳ありません！わざとじゃないです。手が滑ってしまって…。", romaji: "타이헨 모-시와케 아리마센! 와자토쟈 나이데스. 테가 스벳테시맛테...", translation: "정말 죄송합니다! 일부러 그런 게 아니에요. 손이 미끄러져서...", isUserLine: true),
            ConversationData(speaker: "사토", text: "大丈夫ですか？キムさん、火傷しませんでしたか？パソコンは大丈夫ですから。", romaji: "다이죠-부데스카? 기무상, 야케도시마센데시타카? 파소콘와 다이죠-부데스카라.", translation: "괜찮아요? 김 씨, 데이지 않았어요? 컴퓨터는 괜찮으니까요.", isUserLine: false)
        ],
        243: [ // 자신의 책임임을 인정하기 - 자신의 책임임을 인정하기
            ConversationData(speaker: "부장", text: "どうして、お客様に間違った商品を発送したんだ？", romaji: "도-시테, 오캬쿠사마니 마치갓타 쇼-힌오 핫소-시탄다?", translation: "어째서 고객에게 다른 상품을 발송한 건가?", isUserLine: false),
            ConversationData(speaker: "나", text: "私のせいです。注文番号の確認を怠りました。大変申し訳ございませんでした。", romaji: "와타시노 세-데스. 츄-몬반고-노 카쿠닌오 오코타리마시타. 타이헨 모-시와케 고자이마센데시타.", translation: "제 탓입니다. 주문 번호 확인을 게을리했습니다. 정말 죄송합니다.", isUserLine: true),
            ConversationData(speaker: "부장", text: "言い訳はいい。すぐにお客様に謝罪して、正しい商品を送りなさい。", romaji: "이이와케와 이이. 스구니 오캬쿠사마니 샤자이시테, 타다시- 쇼-힌오 오쿠리나사이.", translation: "변명은 됐다. 당장 고객에게 사과드리고, 올바른 상품을 보내도록 해라.", isUserLine: false)
        ],
        244: [ // 괜찮다고 안심시키기 - 괜찮다고 안심시키기
            ConversationData(speaker: "사토", text: "お待たせしてしまって、本当にすみませんでした。", romaji: "오마타세시테시맛테, 혼토-니 스미마센데시타.", translation: "기다리게 해서 정말 죄송했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫ですよ。どうぞ、気にしないでください。私も本を読んでいたので、時間はあっという間でした。", romaji: "다이죠-부데스요. 도-조, 키니시나이데 쿠다사이. 와타시모 혼오 욘데이타노데, 지칸와 앗토이우마데시타.", translation: "괜찮아요. 부디, 신경 쓰지 마세요. 저도 책을 읽고 있어서 시간은 금방 갔어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そう言っていただけると、心が軽くなります。", romaji: "소- 잇테이타다케루토, 코코로가 카루쿠나리마스.", translation: "그렇게 말씀해주시니 마음이 가벼워지네요.", isUserLine: false)
        ],
        245: [ // 재차 설명 요청하기 - 재차 설명 요청하기
            ConversationData(speaker: "사토", text: "…という流れになります。ご理解いただけましたか。", romaji: "...토이우 나가레니 나리마스. 고리카이 이타다케마시타카.", translation: "...라는 흐름이 됩니다. 이해하셨습니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、途中から少し混乱してしまいました。申し訳ないですが、もう一度、説明してください。", romaji: "스미마센, 토츄-카라 스코시 콘란시테시마이마시타. 모-시와케나이데스가, 모- 이치도, 세츠메-시테 쿠다사이.", translation: "죄송합니다, 중간부터 조금 혼란스러워졌습니다. 미안하지만, 다시 한번 설명해주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、もちろんです。では、今度は図を書きながら説明しますね。", romaji: "하이, 모치론데스. 데와, 콘도와 즈오 카키나가라 세츠메-시마스네.", translation: "네, 물론입니다. 그럼 이번에는 그림을 그려가면서 설명할게요.", isUserLine: false)
        ],
        246: [ // 근처 맛집 묻기 - 근처 맛집 묻기
            ConversationData(speaker: "사토", text: "もうお昼ですね。何を食べましょうか。", romaji: "모- 오히루데스네. 나니오 타베마쇼-카.", translation: "벌써 점심이네요. 뭘 먹을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。すみません、この近くに、いいレストランはありますか？", romaji: "소-데스네. 스미마센, 코노 치카쿠니, 이이 레스토란와 아리마스카?", translation: "그러게요. 실례합니다, 이 근처에 괜찮은 식당 있나요?", isUserLine: true),
            ConversationData(speaker: "행인", text: "それなら、そこの角を曲がった先にある定食屋さんが、安くて美味しいですよ。", romaji: "소레나라, 소코노 카도오 마갓타 사키니 아루 테-쇼쿠야상가, 야스쿠테 오이시-데스요.", translation: "그렇다면 저기 모퉁이를 돈 곳에 있는 정식 가게가 싸고 맛있어요.", isUserLine: false)
        ],
        247: [ // 예약자 이름 밝히기 - 예약자 이름 밝히기
            ConversationData(speaker: "점원", text: "いらっしゃいませ。ご予約はされていますか？", romaji: "이랏샤이마세. 고요야쿠와 사레테이마스카?", translation: "어서 오세요. 예약은 하셨습니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、午後6時に予約したキムです。", romaji: "하이, 고고 로쿠지니 요야쿠시타 기무데스.", translation: "네, 오후 6시에 예약한 김입니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "キム様ですね、お待ちしておりました。お席にご案内いたします。", romaji: "기무사마데스네, 오마치시테오리마시타. 오세키니 고안나이 이타시마스.", translation: "김 님이시군요, 기다리고 있었습니다. 자리로 안내해드리겠습니다.", isUserLine: false)
        ],
        248: [ // 마실 것 권하기 - 마실 것 권하기
            ConversationData(speaker: "사토", text: "どうぞ、こちらにおかけください。", romaji: "도-조, 코치라니 오카케쿠다사이.", translation: "자, 이쪽에 앉으세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "お邪魔します。素敵なお部屋ですね。", romaji: "오자마시마스. 스테키나 오헤야데스네.", translation: "실례합니다. 멋진 방이네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。暑かったでしょう、何か飲む物はいかがですか？", romaji: "아리가토-고자이마스. 아츠캇타데쇼-, 나니카 노무모노와 이카가데스카?", translation: "고맙습니다. 더우셨죠, 뭔가 마실 것은 어떠세요?", isUserLine: false)
        ],
        249: [ // 배려를 사양하기 - 배려를 사양하기
            ConversationData(speaker: "사토", text: "何もありませんが、お茶とお菓子でもお出ししますね。", romaji: "나니모 아리마센가, 오차토 오카시데모 오다시시마스네.", translation: "차린 건 없지만, 차랑 과자라도 내어드릴게요.", isUserLine: false),
            ConversationData(speaker: "나", text: "わあ、ありがとうございます。でも、どうぞ、お構いなく。", romaji: "와아, 아리가토-고자이마스. 데모, 도-조, 오카마이나쿠.", translation: "와, 고맙습니다. 하지만, 부디 신경 쓰지 마세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか？では、お言葉に甘えて。", romaji: "소-데스카? 데와, 오코토바니 아마에테.", translation: "그런가요? 그럼, 말씀대로 편히 있겠습니다.", isUserLine: false)
        ],
        250: [ // 돌아가야 한다고 암시하기 - 돌아가야 한다고 암시하기
            ConversationData(speaker: "사토", text: "話が尽きないですね。本当に楽しいです。", romaji: "하나시가 츠키나이데스네. 혼토-니 타노시-데스.", translation: "이야기가 끝이 없네요. 정말 즐거워요.", isUserLine: false),
            ConversationData(speaker: "나", text: "私もです。あ、でも、もうこんな時間か。そろそろ帰らないと。", romaji: "와타시모데스. 아, 데모, 모- 콘나 지칸카. 소로소로 카에라나이토.", translation: "저도요. 아, 그런데 벌써 시간이 이렇게 됐네. 슬슬 돌아가지 않으면.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当だ。名残惜しいけど、また今度ゆっくり会いましょう。", romaji: "혼토-다. 나고리오시-케도, 마타 콘도 윳쿠리 아이마쇼-.", translation: "그러네. 아쉽지만 다음에 또 느긋하게 만나요.", isUserLine: false)
        ],
        251: [ // 포인트 카드 유무 묻기 (ポイントカードの有無を尋ねる)
            ConversationData(speaker: "점원", text: "お会計は3,500円になります。", romaji: "오카이케-와 산젠고햐쿠엔니 나리마스.", translation: "계산은 3,500엔입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。すみません、こちらの店のポイントカードはありますか？", romaji: "하이. 스미마센, 코치라노 미세노 포인토카-도와 아리마스카?", translation: "네. 죄송하지만, 이 가게의 포인트 카드는 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、ございます。本日、お作りしますか？", romaji: "하이, 고자이마스. 혼지츠, 오츠쿠리시마스카?", translation: "네, 있습니다. 오늘 만들어 드릴까요?", isUserLine: false)
        ],
        252: [ // 봉투에 넣을지 묻기 (袋に入れるか尋ねる)
            ConversationData(speaker: "점원", text: "ありがとうございました。", romaji: "아리가토-고자이마시타.", translation: "감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "(상품을 받으며)", romaji: "상품을 받으며", translation: "상품을 받으며", isUserLine: true),
            ConversationData(speaker: "점원", text: "こちらの商品、袋にお入れしますか？", romaji: "코치라노 쇼-힌, 후쿠로니 오이레시마스카?", translation: "이 상품, 봉투에 넣어드릴까요?", isUserLine: false)
        ],
        253: [ // 따로 계산 요청하기 (別会計を頼む)
            ConversationData(speaker: "점원", text: "お会計は、ご一緒でよろしいでしょうか。", romaji: "오카이케-와, 고잇쇼데 요로시-데쇼-카.", translation: "계산은 함께 해드리면 될까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "あ、すみません。別々でお願いします。", romaji: "아, 스미마센. 베츠베츠데 오네가이시마스.", translation: "아, 죄송합니다. 따로따로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、お一人様ずつお伺いします。", romaji: "카시코마리마시타. 데와, 오히토리사마즈츠 오우카가이시마스.", translation: "알겠습니다. 그럼, 한 분씩 계산해 드리겠습니다.", isUserLine: false)
        ],
        254: [ // 같이 계산 요청하기 (一緒の会計を頼む)
            ConversationData(speaker: "점원", text: "お会計は、別々になさいますか？", romaji: "오카이케-와, 베츠베츠니 나사이마스카?", translation: "계산은 따로따로 하시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いえ、一緒でお願いします。", romaji: "이에, 잇쇼데 오네가이시마스.", translation: "아니요, 같이 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、合計で5,000円になります。", romaji: "카시코마리마시타. 데와, 고-케-데 고센엔니 나리마스.", translation: "알겠습니다. 그럼, 합계 5,000엔입니다.", isUserLine: false)
        ],
        255: [ // 의견 묻기 (意見を尋ねる)
            ConversationData(speaker: "사토", text: "以上が、私が考えた新しい企画案です。", romaji: "이죠-가, 와타시가 칸가에타 아타라시- 키카쿠안데스.", translation: "이상이 제가 생각한 새로운 기획안입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。この案について、皆さん、ご意見を聞かせてください。", romaji: "아리가토-고자이마스. 코노 안니 츠이테, 미나산, 고이켄오 키카세테쿠다사이.", translation: "감사합니다. 이 안에 대해 여러분, 의견을 들려주세요.", isUserLine: true),
            ConversationData(speaker: "동료", text: "全体的に良いと思いますが、予算の面が少し気になりますね。", romaji: "젠타이테키니 이이토 오모이마스가, 요산노 멘가 스코시 키니나리마스네.", translation: "전체적으로 좋다고 생각하지만, 예산 측면이 조금 신경 쓰이네요.", isUserLine: false)
        ],
        256: [ // 좋은 아이디어 묻기 (良いアイデアを尋ねる)
            ConversationData(speaker: "사토", text: "今年の忘年会、いつも同じような内容で少し飽きてきましたね。", romaji: "코토시노 보-넨카이, 이츠모 오나지요-나 나이요-데 스코시 아키테키마시타네.", translation: "올해 송년회, 항상 비슷한 내용이라 조금 질리네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。何かいいアイデアはありますか？", romaji: "소-데스네. 나니카 이이 아이데아와 아리마스카?", translation: "그러게요. 뭔가 좋은 아이디어라도 있나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "うーん、ビンゴ大会の景品を豪華にするのはどうでしょう。", romaji: "우-응, 빙고타이카이노 케-힌오 고-카니 스루노와 도-데쇼-.", translation: "음, 빙고 대회 경품을 호화롭게 하는 건 어떨까요?", isUserLine: false)
        ],
        257: [ // 불가능하다고 말하기 (불가능だと言う)
            ConversationData(speaker: "사토", text: "このレポート、申し訳ないですが、今日中に完成させてください。", romaji: "코노 레포-토, 모-시와케나이데스가, 쿄-쥬-니 칸세-사세테쿠다사이.", translation: "이 보고서, 죄송하지만 오늘 중으로 완성해주세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "今日中ですか？データ分析も残っているので、それは無理です。", romaji: "쿄-쥬-데스카? 데-타분세키모 노콧테이루노데, 소레와 무리데스.", translation: "오늘 중으로요? 데이터 분석도 남아 있어서 그건 무리입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか…。では、明日の朝一番までにお願いします。", romaji: "소-데스카... 데와, 아시타노 아사이치방마데니 오네가이시마스.", translation: "그런가요... 그럼 내일 아침 일찍까지 부탁합니다.", isUserLine: false)
        ],
        258: [ // 아마 갈 수 있을 거라고 답하기 (多分行けると思うと答える)
            ConversationData(speaker: "사토", text: "キムさん、明日の飲み会、参加できますか？", romaji: "기무상, 아시타노 노미카이, 산카데키마스카?", translation: "김 씨, 내일 회식에 참석할 수 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "まだ仕事が残っているので確実ではありませんが、多分、行けると思います。", romaji: "마다 시고토가 노콧테이루노데 카쿠지츠데와 아리마센가, 타분, 이케루토 오모이마스.", translation: "아직 일이 남아서 확실하지는 않지만, 아마 갈 수 있을 것 같아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "分かりました。来られるようになったら、連絡してくださいね。", romaji: "와카리마시타. 코라레루요-니 낫타라, 렌라쿠시테쿠다사이네.", translation: "알겠습니다. 올 수 있게 되면 연락 주세요.", isUserLine: false)
        ],
        259: [ // 휴대폰 전원이 꺼졌다고 말하기 (携帯の電源が切れたと伝える)
            ConversationData(speaker: "사토", text: "キムさん、どうして昨日電話に出なかったんですか？心配しましたよ。", romaji: "기무상, 도-시테 키노- 덴와니 데나캇탄데스카? 신파이시마시타요.", translation: "김 씨, 어제 왜 전화를 안 받았어요? 걱정했다고요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません。外出中に、携帯の電源が切れました。", romaji: "스미마센. 가이슈츠츄-니, 케-타이노 덴겐가 키레마시타.", translation: "죄송합니다. 외출 중에 휴대폰 전원이 꺼졌어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうだったんですね。それなら仕方ないですね。", romaji: "소-닷탄데스네. 소레나라 시카타나이데스네.", translation: "그랬군요. 그럼 어쩔 수 없죠.", isUserLine: false)
        ],
        260: [ // 어떻게 해야 할지 묻기 (どうすればいいか尋ねる)
            ConversationData(speaker: "사토", text: "大変です！お客様から、急な仕様変更の依頼が来ました。", romaji: "타이헨데스! 오캬쿠사마카라, 큐-나 시요-헨코-노 이라이가 키마시타.", translation: "큰일 났어요! 고객으로부터 갑작스러운 사양 변경 요청이 왔습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええっ、今からですか。困りましたね…。どうすればいいですか？", romaji: "엣, 이마카라데스카. 코마리마시타네... 도-스레바 이이데스카?", translation: "엣, 지금부터요? 곤란하네요... 어떻게 하면 좋을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "まずは、技術的に対応可能かどうか、開発部に確認してみましょう。", romaji: "마즈와, 기주츠테키니 타이오-카노-카도-카, 카이하츠부니 카쿠닌시테미마쇼-.", translation: "우선, 기술적으로 대응 가능한지 어떤지 개발부에 확인해 봅시다.", isUserLine: false)
        ],
        261: [ // A보다 B를 더 선호한다고 말하기 (AよりBを好むと表現する)
            ConversationData(speaker: "사토", text: "休憩しましょうか。コーヒーと紅茶、どちらがいいですか？", romaji: "큐-케-시마쇼-카. 코-히-토 코-챠, 도치라가 이이데스카?", translation: "휴식할까요? 커피랑 홍차, 어느 쪽이 좋아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね、ありがとうございます。私は紅茶よりコーヒーの方が好きです。", romaji: "소-데스네, 아리가토-고자이마스. 와타시와 코-챠요리 코-히-노 호-가 스키데스.", translation: "네, 고맙습니다. 저는 홍차보다 커피를 더 좋아합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "了解です。では、コーヒーを淹れますね。", romaji: "료카이데스. 데와, 코-히-오 이레마스네.", translation: "알겠습니다. 그럼 커피를 타 올게요.", isUserLine: false)
        ],
        262: [ // 둘 다 좋다고 말하기 (両方好きだと伝える)
            ConversationData(speaker: "사토", text: "週末のランチですが、イタリアンと中華、どちらがいいですか？", romaji: "슈-마츠노 란치데스가, 이타리안토 츄-카, 도치라가 이이데스카?", translation: "주말 점심 말인데요, 이탈리안이랑 중식 중에 어느 쪽이 좋으세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、悩みますね。どちらも好きです。佐藤さんはどうですか？", romaji: "우-응, 나야미마스네. 도치라모 스키데스. 사토-상와 도-데스카?", translation: "음, 고민되네요. 저는 둘 다 좋아요. 사토 씨는 어떠세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですね…じゃあ、今日は中華の気分かな。", romaji: "소-데스네... 쟈-, 쿄-와 츄-카노 키분카나.", translation: "글쎄요... 그럼 오늘은 중식이 당기네요.", isUserLine: false)
        ],
        263: [ // 단 음식을 못 먹는다고 말하기 (甘いものが苦手だと伝える)
            ConversationData(speaker: "사토", text: "このチョコレートケーキ、とても美味しいですよ。キムさんも一切れいかがですか？", romaji: "코노 초코레-토케-키, 토테모 오이시-데스요. 기무상모 히토키레 이카가데스카?", translation: "이 초콜릿 케이크, 아주 맛있어요. 김 씨도 한 조각 어떠세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。でも、申し訳ないですが、私はあまり甘い物は苦手です。", romaji: "아리가토-고자이마스. 데모, 모-시와케나이데스가, 와타시와 아마리 아마이모노와 니가테데스.", translation: "고맙습니다. 하지만 죄송하게도, 저는 단 음식을 그다지 즐기지 않아서요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あら、そうだったんですね。失礼しました。", romaji: "아라, 소-닷탄데스네. 시츠레-시마시타.", translation: "어머, 그랬군요. 실례했습니다.", isUserLine: false)
        ],
        264: [ // 매운 음식 선호도 묻기 (辛いものの好みを尋ねる)
            ConversationData(speaker: "사토", text: "今日の夕食は、新しくできたタイ料理のお店に行きませんか。", romaji: "쿄-노 유-쇼쿠와, 아타라시쿠 데키타 타이료-리노 오미세니 이키마센카.", translation: "오늘 저녁은 새로 생긴 태국 음식점에 가지 않을래요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいですね！ところで、佐藤さんは辛い物は好きですか？", romaji: "이이데스네! 토코로데, 사토-상와 카라이모노와 스키데스카?", translation: "좋아요! 그런데, 사토 씨는 매운 음식 좋아하세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、大好きです！辛ければ辛いほどいいです。", romaji: "하이, 다이스키데스! 카라케레바 카라이호도 이이데스.", translation: "네, 아주 좋아해요! 매우면 매울수록 좋아요.", isUserLine: false)
        ],
        265: [ // 뜨거운 것을 잘 못 먹는다고 말하기 (熱いものが苦手だと伝える)
            ConversationData(speaker: "사토", text: "キムさん、ラーメンが伸びてしまいますよ。熱いうちにどうぞ。", romaji: "기무상, 라-멘가 노비테시마이마스요. 아츠이 우치니 도-조.", translation: "김 씨, 라면이 불겠어요. 뜨거울 때 드세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、私、極度の猫舌なんです。少し冷まさないと食べられなくて。", romaji: "스미마센, 와타시, 쿄쿠도노 네코지타난데스. 스코시 사마사나이토 타베라레나쿠테.", translation: "죄송해요, 제가 엄청 뜨거운 걸 못 먹어서요. 조금 식히지 않으면 못 먹어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、そうだったんですね。ゆっくり召し上がってください。", romaji: "아아, 소-닷탄데스네. 윳쿠리 메시갓테쿠다사이.", translation: "아아, 그랬군요. 천천히 드세요.", isUserLine: false)
        ],
        266: [ // 사람에 따라 다르다고 답하기 (人によると答える)
            ConversationData(speaker: "사토", text: "日本の方は、皆さん納豆を食べられるんですか？", romaji: "니혼노 카타와, 미나산 낫토-오 타베라레룬데스카?", translation: "일본 분들은 모두 낫토를 드실 수 있나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、それは人によります。私も実は苦手なんです。", romaji: "이에이에, 소레와 히토니 요리마스. 와타시모 지츠와 니가테난데스.", translation: "아니요, 그건 사람에 따라 달라요. 저도 사실 잘 못 먹어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね！てっきり、みんな好きなのかと思っていました。", romaji: "소-난데스네! 텟키리, 민나 스키나노카토 오못테이마시타.", translation: "그렇군요! 저는 당연히 모두 좋아하는 줄 알았어요.", isUserLine: false)
        ],
        267: [ // 경우에 따라 다르다고 답하기 (場合によると答える)
            ConversationData(speaker: "사토", text: "この割引クーポンは、いつでも使えるんですか？", romaji: "코노 와리비키쿠-폰와, 이츠데모 츠카에룬데스카?", translation: "이 할인 쿠폰은 언제든지 쓸 수 있나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、それは場合によります。平日のランチタイム限定など、条件があることが多いです。", romaji: "이에, 소레와 바아이니 요리마스. 헤-지츠노 란치타이무 겐테-나도, 죠-켄가 아루코토가 오-이데스.", translation: "아니요, 그건 경우에 따라 달라요. 평일 점심시간 한정 등, 조건이 있는 경우가 많아요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "なるほど。裏面の注意書きをよく読まないといけませんね。", romaji: "나루호도. 리멘노 츄-이가키오 요쿠 요마나이토 이케마센네.", translation: "그렇군요. 뒷면의 주의사항을 잘 읽어야겠네요.", isUserLine: false)
        ],
        268: [ // 재확인 요청하기 (再確認を頼む)
            ConversationData(speaker: "사토", text: "明日の会議の開始時間は、午前10時で間違いないですね？", romaji: "아시타노 카이기노 카이시지칸와, 고젠 쥬-지데 마치가이나이데스네?", translation: "내일 회의 시작 시간은 오전 10시가 틀림없죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、そうだと思いますが、念のため、もう一度、確認してください。", romaji: "하이, 소-다토 오모이마스가, 넨노타메, 모-이치도, 카쿠닌시테쿠다사이.", translation: "네, 그렇다고 생각하지만, 만약을 위해 다시 한번 확인해주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "わかりました。担当部署に内線で聞いてみます。", romaji: "와카리마시타. 탄토-부쇼니 나이센데 키이테미마스.", translation: "알겠습니다. 담당 부서에 내선으로 물어볼게요.", isUserLine: false)
        ],
        269: [ // 의미를 물어보기 (意味を尋ねる)
            ConversationData(speaker: "사토", text: "この書類の「追って連絡します」という部分は、どういうことでしょうか。", romaji: "코노 쇼루이노 「옷테 렌라쿠시마스」토 이우 부분와, 도-이우 코토데쇼-카.", translation: "이 서류의 '추후 연락하겠습니다'라는 부분은 무슨 뜻인가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、私もよく分からなくて。この意味を教えてください。", romaji: "스미마센, 와타시모 요쿠 와카라나쿠테. 코노 이미오 오시에테쿠다사이.", translation: "죄송합니다, 저도 잘 몰라서요. 이 의미를 가르쳐주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "これは「後日、改めて連絡します」という意味ですね。", romaji: "코레와 「고지츠, 아라타메테 렌라쿠시마스」토 이우 이미데스네.", translation: "이것은 '나중에 다시 연락하겠습니다'라는 의미입니다.", isUserLine: false)
        ],
        270: [ // 한자 읽는 법 묻기 (漢字の読み方を尋ねる)
            ConversationData(speaker: "사토", text: "(메뉴판을 보며) うわ、この魚、美味しそうだけど、名前が読めない…。", romaji: "우와, 코노 사카나, 오이시소-다케도, 나마에가 요메나이...", translation: "우와, 이 생선 맛있어 보이는데, 이름을 못 읽겠어...", isUserLine: false),
            ConversationData(speaker: "나", text: "本当だ。すみません、店員さん。この漢字の読み方は何ですか？", romaji: "혼토-다. 스미마센, 텐인상. 코노 칸지노 요미카타와 난데스카?", translation: "그러네. 실례합니다, 점원분. 이 한자 어떻게 읽나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "それは「かます」と読みます。塩焼きにすると美味しいですよ。", romaji: "소레와 「카마스」토 요미마스. 시오야키니 스루토 오이시-데스요.", translation: "그것은 '카마스'라고 읽습니다. 소금구이를 하면 맛있어요.", isUserLine: false)
        ],
        271: [ // 카드 사용 가능 여부 묻기 (カードが使えるか尋ねる)
            ConversationData(speaker: "점원", text: "お会計は、合計で6,400円です。", romaji: "오카이케-와, 고-케-데 로쿠센욘햐쿠엔데스.", translation: "계산은, 합계 6,400엔입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。すみません、このカード、使えますか？", romaji: "하이. 스미마센, 코노 카-도, 츠카에마스카?", translation: "네. 죄송하지만, 이 카드, 사용할 수 있나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、VISAカードですね。問題なくお使いいただけます。", romaji: "하이, 비자카-도데스네. 몬다이나쿠 오츠카이이타다케마스.", translation: "네, 비자카드네요. 문제없이 사용하실 수 있습니다.", isUserLine: false)
        ],
        272: [ // 수수료 유무 묻기 (手数料の有無を尋ねる)
            ConversationData(speaker: "은행원", text: "では、こちらの機械で海外送金の手続きができます。", romaji: "데와, 코치라노 키카이데 카이가이소-킨노 테츠즈키가 데키마스.", translation: "그럼, 이쪽 기계에서 해외 송금 수속을 할 수 있습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。あの、送金の際に、手数料はかかりますか？", romaji: "아리가토-고자이마스. 아노, 소-킨노 사이니, 테스-료-와 카카리마스카?", translation: "감사합니다. 저, 송금할 때 수수료는 드나요?", isUserLine: true),
            ConversationData(speaker: "은행원", text: "はい、送金額に応じて、所定の手数料をいただいております。", romaji: "하이, 소-킨가쿠니 오-지테, 쇼테-노 테스-료-오 이타다이테오리마스.", translation: "네, 송금액에 따라 정해진 수수료를 받고 있습니다.", isUserLine: false)
        ],
        273: [ // 가게가 이미 닫았다고 말하기 (店が既に閉まったと伝える)
            ConversationData(speaker: "나", text: "(가게 문을 열려고 하며) あれ、開かないな。", romaji: "아레, 아카나이나.", translation: "어라, 안 열리네.", isUserLine: true),
            ConversationData(speaker: "나", text: "すみません！まだ開いていますか？", romaji: "스미마센! 마다 아이테이마스카?", translation: "실례합니다! 아직 영업하시나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "(안에서) 申し訳ありません、もう閉まりました。営業時間は夜9時までなんです。", romaji: "모-시와케 아리마센, 모- 시마리마시타. 에-교-지칸와 요루 쿠지마데난데스.", translation: "죄송합니다, 이미 닫았습니다. 영업시간은 밤 9시까지입니다.", isUserLine: false)
        ],
        274: [ // 아직 영업 중인지 묻기 (まだ営業中か尋ねる)
            ConversationData(speaker: "음식점 직원", text: "(전화로) はい、レストラン「やまびこ」です。", romaji: "하이, 레스토란 「야마비코」데스.", translation: "네, 레스토랑 '야마비코'입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "もしもし、今そちらに向かっているのですが、まだ開いていますか？", romaji: "모시모시, 이마 소치라니 무캇테이루노데스가, 마다 아이테이마스카?", translation: "여보세요, 지금 그쪽으로 가고 있는데, 아직 열었나요?", isUserLine: true),
            ConversationData(speaker: "음식점 직원", text: "はい、まだ大丈夫ですよ。ラストオーダーは10時ですので、お気をつけてお越しください。", romaji: "하이, 마다 다이죠-부데스요. 라스토오-다-와 쥬-지데스노데, 오키오츠케테 오코시쿠다사이.", translation: "네, 아직 괜찮습니다. 마지막 주문은 10시이니, 조심해서 오세요.", isUserLine: false)
        ],
        275: [ // 영업 마감 시간 묻기 (閉店時間を尋ねる)
            ConversationData(speaker: "사토", text: "この本屋さん、面白そうな本がたくさんありますね。", romaji: "코노 혼야상, 오모시로소-나 혼가 타쿠상 아리마스네.", translation: "이 서점, 재미있어 보이는 책이 잔뜩 있네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "本当ですね。すみません、この店は何時まで開いていますか？", romaji: "혼토-데스네. 스미마센, 코노 미세와 난지마데 아이테이마스카?", translation: "그러게요. 실례합니다, 이 가게는 몇 시까지 하나요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "夜の10時まで営業しております。", romaji: "요루노 쥬-지마데 에-교-시테오리마스.", translation: "밤 10시까지 영업하고 있습니다.", isUserLine: false)
        ],
        276: [ // 이상형이 아니라고 말하기 (タイプではないと伝える)
            ConversationData(speaker: "사토", text: "隣の部署の鈴木さん、キムさんのこと、素敵だって言ってたよ。どう思う？", romaji: "토나리노 부쇼노 스즈키상, 기무상노 코토, 스테키닷테 잇테타요. 도-오모우?", translation: "옆 부서의 스즈키 씨, 김 씨를 멋지다고 하던데. 어떻게 생각해?", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、いい人だと思いますが、正直、彼は私のタイプじゃないです。", romaji: "에에, 이이 히토다토 오모이마스가, 쇼-지키, 카레와 와타시노 타이푸쟈 나이데스.", translation: "네, 좋은 사람이라고는 생각하지만, 솔직히 그는 제 타입이 아니에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "あら、そうなの？優しくて、仕事もできるのに。", romaji: "아라, 소-나노? 야사시쿠테, 시고토모 데키루노니.", translation: "어머, 그래? 다정하고 일도 잘하는데.", isUserLine: false)
        ],
        277: [ // 교제 상대 유무 묻기 (交際相手の有無を尋ねる)
            ConversationData(speaker: "사토", text: "キムさん、最近なんだか雰囲気が明るくなったね。何かいいことでもあった？", romaji: "기무상, 사이킨 난다카 훈이키가 아카루쿠낫타네. 나니카 이이코토데모 앗타?", translation: "김 씨, 요즘 왠지 분위기가 밝아졌네. 무슨 좋은 일이라도 있었어?", isUserLine: false),
            ConversationData(speaker: "나", text: "え、そうですか？自分ではよく分からないけど…。", romaji: "에, 소-데스카? 지분데와 요쿠 와카라나이케도...", translation: "에, 그래요? 저는 잘 모르겠는데...", isUserLine: true),
            ConversationData(speaker: "사토", text: "ふふふ、もしかして、付き合っている人はいますか？", romaji: "후후후, 모시카시테, 츠키앗테이루 히토와 이마스카?", translation: "후후후, 혹시 사귀는 사람 있어요?", isUserLine: false)
        ],
        278: [ // 결혼 여부 묻기 (結婚しているか尋ねる)
            ConversationData(speaker: "사토", text: "その左手の指輪、とてもきれいですね。", romaji: "소노 히다리테노 유비와, 토테모 키레-데스네.", translation: "그 왼손의 반지, 아주 예쁘네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。", romaji: "아리가토-고자이마스.", translation: "고맙습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "失礼ですが、もしかして、結婚していますか？", romaji: "시츠레-데스가, 모시카시테, 켓콘시테이마스카?", translation: "실례지만, 혹시 결혼하셨나요?", isUserLine: false)
        ],
        279: [ // 걱정 말라고 안심시키기 (心配しないでと安心させる)
            ConversationData(speaker: "사토", text: "この大事なプレゼン、私一人で大丈夫でしょうか。", romaji: "코노 다이지나 프레젠, 와타시 히토리데 다이죠-부데쇼-카.", translation: "이 중요한 프레젠테이션, 저 혼자서 괜찮을까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "大丈夫です。佐藤さんならできますよ。どうぞ、ご心配なく。", romaji: "다이죠-부데스. 사토-상나라 데키마스요. 도-조, 고신파이나쿠.", translation: "괜찮아요. 사토 씨라면 할 수 있어요. 부디, 걱정 마세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。その言葉で勇気が出ました。", romaji: "아리가토-고자이마스. 소노 코토바데 유-키가 데마시타.", translation: "감사합니다. 그 말에 용기가 생겼어요.", isUserLine: false)
        ],
        280: [ // 외출 시 인사 (出かける時の挨拶)
            ConversationData(speaker: "어머니", text: "もう出かけるの？朝ごはん、食べていきなさい。", romaji: "모- 데카케루노? 아사고항, 타베테이키나사이.", translation: "벌써 나가니? 아침밥 먹고 가렴.", isUserLine: false),
            ConversationData(speaker: "나", text: "ううん、時間がないから大丈夫。じゃあ、行ってきます。", romaji: "우운, 지칸가 나이카라 다이죠-부. 쟈-, 잇테키마스.", translation: "아니, 시간이 없어서 괜찮아. 그럼, 다녀오겠습니다.", isUserLine: true),
            ConversationData(speaker: "어머니", text: "行ってらっしゃい。夜、ご飯は家で食べるの？", romaji: "잇테랏샤이. 요루, 고항와 우치데 타베루노?", translation: "다녀오너라. 저녁은 집에서 먹니?", isUserLine: false)
        ],
        281: [ // 다녀오라고 인사하기 (出かける人への挨拶)
            ConversationData(speaker: "남편", text: "じゃあ、会社に行ってきます。", romaji: "쟈-, 카이샤니 잇테키마스.", translation: "그럼, 회사 다녀올게.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、行ってらっしゃい。今日は帰りが遅くなりますか？", romaji: "하이, 잇테랏샤이. 쿄-와 카에리가 오소쿠나리마스카?", translation: "네, 다녀오세요. 오늘은 늦게 들어와요?", isUserLine: true),
            ConversationData(speaker: "남편", text: "多分。飲み会があるかもしれない。", romaji: "타분. 노미카이가 아루카모 시레나이.", translation: "아마도. 회식이 있을지도 몰라.", isUserLine: false)
        ],
        282: [ // 배탈 났다고 말하기 (お腹の調子が悪いと伝える)
            ConversationData(speaker: "사토", text: "キムさん、昼ごはん、何を食べに行きますか？", romaji: "기무상, 히루고항, 나니오 타베니 이키마스카?", translation: "김 씨, 점심 먹으러 뭐 먹으러 갈래요?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、昨日からちょっとお腹の調子が悪いです。今日は食欲がなくて…。", romaji: "스미마센, 키노-카라 좃토 오나카노 쵸-시가 와루이데스. 쿄-와 쇼쿠요쿠가 나쿠테...", translation: "죄송해요, 어제부터 배 상태가 좀 안 좋아서요. 오늘은 식욕이 없어서...", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですか。大丈夫ですか？無理せず、何か消化にいいものを食べた方がいいですよ。", romaji: "소-난데스카. 다이죠-부데스카? 무리세즈, 나니카 쇼-카니 이이모노오 타베타 호-가 이이데스요.", translation: "그래요? 괜찮아요? 무리하지 말고 소화 잘 되는 걸로 먹는 게 좋겠어요.", isUserLine: false)
        ],
        283: [ // 약속 유무 묻기 (アポイントの有無を尋ねる)
            ConversationData(speaker: "접수원", text: "いらっしゃいませ。本日のご用件は何でしょうか。", romaji: "이랏샤이마세. 혼지츠노 고요-켄와 난데쇼-카.", translation: "어서 오십시오. 오늘 용무는 무엇이십니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "開発部の田中様にお会いしに参りました。", romaji: "카이하츠부노 타나카사마니 오아이시니 마이리마시타.", translation: "개발부의 다나카 님을 뵈러 왔습니다.", isUserLine: true),
            ConversationData(speaker: "접수원", text: "かしこまりました。お客様、アポイントはありますか？", romaji: "카시코마리마시타. 오캬쿠사마, 아포인토와 아리마스카?", translation: "알겠습니다. 손님, 약속은 있으신가요?", isUserLine: false)
        ],
        284: [ // 당연히 안다고 답하기 (もちろん知っていると答える)
            ConversationData(speaker: "사토", text: "キムさんは「鬼滅の刃」というアニメを知っていますか？", romaji: "기무상와 「키메츠노 야이바」토이우 아니메오 싯테이마스카?", translation: "김 씨는 '귀멸의 칼날'이라는 애니메이션을 아세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、もちろんです。日本だけでなく、韓国でものすごく人気ですよ。", romaji: "하이, 모치론데스. 니혼다케데나쿠, 칸코쿠데모 모노스고쿠 닌키데스요.", translation: "네, 물론이죠. 일본뿐만 아니라 한국에서도 엄청난 인기예요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうなんですね！さすがです。", romaji: "소-난데스네! 사스가데스.", translation: "그렇군요! 역시 대단하네요.", isUserLine: false)
        ],
        285: [ // 전혀 몰랐다고 답하기 (全然知らなかったと答える)
            ConversationData(speaker: "사토", text: "田中部長、来月で定年退職されるそうですよ。", romaji: "타나카부쵸-, 라이게츠데 테-넨타이쇼쿠 사레루소-데스요.", translation: "다나카 부장님, 다음 달에 정년퇴직하신대요.", isUserLine: false),
            ConversationData(speaker: "나", text: "えっ、本当ですか？全然知りませんでした。", romaji: "엣, 혼토-데스카? 젠젠 시리마센데시타.", translation: "엣, 정말요? 전혀 몰랐어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、私も昨日聞いて、驚きました。", romaji: "에에, 와타시모 키노- 키이테, 오도로키마시타.", translation: "네, 저도 어제 듣고 놀랐어요.", isUserLine: false)
        ],
        286: [ // 믿기 어려운 사실을 말할 때 (信じ難い事実を伝える時)
            ConversationData(speaker: "사토", text: "キムさんが、あの有名な歌手と知り合いだなんて、冗談ですよね？", romaji: "기무상가, 아노 유-메-나 카슈토 시리아이다난테, 죠-단데스요네?", translation: "김 씨가, 그 유명한 가수랑 아는 사이라니, 농담이죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "信じられないかもしれませんが、本当です。学生時代の同級生なんです。", romaji: "신지라레나이카모 시레마센가, 혼토-데스. 가쿠세-지다이노 도-큐-세-난데스.", translation: "믿을 수 없을지도 모르겠지만, 정말이에요. 학창 시절 동급생이거든요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "すごい！今度サインをもらってください！", romaji: "스고이! 콘도 사인오 모랏테쿠다사이!", translation: "대단하다! 다음에 사인 받아주세요!", isUserLine: false)
        ],
        287: [ // 복사 부탁하기 (コピーを頼む)
            ConversationData(speaker: "사토", text: "キムさん、ちょっといいですか？", romaji: "기무상, 좃토 이이데스카?", translation: "김 씨, 잠시 괜찮아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。この会議資料、20部コピーをお願いします。", romaji: "하이. 코노 카이기시료-, 니짓부 코피-오 오네가이시마스.", translation: "네. 이 회의 자료, 20부 복사 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "かしこまりました。すぐにやります。", romaji: "카시코마리마시타. 스구니 야리마스.", translation: "알겠습니다. 바로 하겠습니다.", isUserLine: false)
        ],
        288: [ // 서명 부탁하기 (サインを頼む)
            ConversationData(speaker: "은행원", text: "以上で、お手続きは完了です。", romaji: "이죠-데, 오테츠즈키와 칸료-데스.", translation: "이상으로 수속은 완료되었습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございました。", romaji: "아리가토-고자이마시타.", translation: "감사합니다.", isUserLine: true),
            ConversationData(speaker: "은행원", text: "最後に、ご確認のため、この書類にサインをお願いします。", romaji: "사이고니, 고카쿠닌노 타메, 코노 쇼루이니 사인오 오네가이시마스.", translation: "마지막으로, 확인을 위해 이 서류에 서명 부탁드립니다.", isUserLine: false)
        ],
        289: [ // 정중하게 앉아도 되는지 묻기 (丁寧に座っていいか尋ねる)
            ConversationData(speaker: "사장", text: "(회의실 빈자리 옆에 앉아있다)", romaji: "회의실 빈자리 옆에 앉아있다", translation: "회의실 빈자리 옆에 앉아있다", isUserLine: false),
            ConversationData(speaker: "나", text: "社長、失礼いたします。お隣、よろしいでしょうか。", romaji: "샤쵸-, 시츠레-이타시마스. 오토나리, 요로시-데쇼-카.", translation: "사장님, 실례하겠습니다. 옆자리, 괜찮겠습니까?", isUserLine: true),
            ConversationData(speaker: "사장", text: "ああ、キム君か。もちろん、ここに座ってもよろしいでしょうか、なんて聞かなくていいよ。どうぞ。", romaji: "아아, 기무쿤카. 모치론, 코코니 스왓테모 요로시-데쇼-카, 난테 키카나쿠테 이이요. 도-조.", translation: "아, 김 군인가. 물론이지, '여기에 앉아도 괜찮겠습니까?' 같은 거 안 물어봐도 돼. 앉게.", isUserLine: false)
        ],
        290: [ // 더 큰 목소리로 말해달라고 요청하기 (もっと大きい声でと頼む)
            ConversationData(speaker: "사토", text: "(시끄러운 공사 현장 옆에서) …それで、明日の件ですが…。", romaji: "...소레데, 아시타노 켄데스가...", translation: "...그래서, 내일 건 말인데요...", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません！よく聞こえません！もう少し大きい声で話してください！", romaji: "스미마센! 요쿠 키코에마센! 모-스코시 오-키- 코에데 하나시테쿠다사이!", translation: "죄송해요! 잘 안 들려요! 조금만 더 큰 소리로 말해주세요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "(소리치며) あ、すみません！明日の会議は中止です！", romaji: "아, 스미마센! 아시타노 카이기와 츄-시데스!", translation: "아, 죄송해요! 내일 회의는 취소예요!", isUserLine: false)
        ],
        291: [ // 상대방 의견에 정중히 동의하기 (相手の意見に丁寧に同意する)
            ConversationData(speaker: "부장", text: "この企画を成功させるには、見た目のインパクトだけでなく、実用性が不可欠だろう。", romaji: "코노 키카쿠오 세-코-사세루니와, 미타메노 인파쿠토다케데나쿠, 지츠요-세-가 후카케츠다로-.", translation: "이 기획을 성공시키려면, 겉모습의 임팩트뿐만 아니라 실용성이 필수불가결하겠지.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、おっしゃる通りです。お客様が実際に使って満足できるものでなければなりません。", romaji: "하이, 옷샤루토-리데스. 오캬쿠사마가 짓사이니 츠캇테 만조쿠데키루 모노데 나케레바 나리마센.", translation: "네, 말씀하신 대로입니다. 고객이 실제로 사용하고 만족할 수 있는 것이어야 합니다.", isUserLine: true),
            ConversationData(speaker: "부장", text: "うむ、その点を踏まえて、もう一度企画を練り直してくれたまえ。", romaji: "우무, 소노 텐오 후마에테, 모- 이치도 키카쿠오 네리나오시테쿠레타마에.", translation: "음, 그 점을 입각해서 다시 한번 기획을 가다듬어 주게.", isUserLine: false)
        ],
        292: [ // 알고 있는지 정중히 묻기 (知っているか丁寧に尋ねる)
            ConversationData(speaker: "사토", text: "来週、新しいソフトウェアの研修があるそうですね。", romaji: "라이슈-, 아타라시- 소후토웨어노 켄슈-가 아루소-데스네.", translation: "다음 주에 새로운 소프트웨어 연수가 있다면서요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。その件ですが、参加は必須だということはご存じですか？", romaji: "하이. 소노 켄데스가, 산카와 힛수다토 이우 코토와 고존지데스카?", translation: "네. 그 건 말입니다만, 참가가 필수라는 것은 알고 계신가요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "いいえ、知りませんでした。教えてくださり、ありがとうございます。", romaji: "이이에, 시리마센데시타. 오시에테쿠다사리, 아리가토-고자이마스.", translation: "아니요, 몰랐습니다. 알려주셔서 감사합니다.", isUserLine: false)
        ],
        293: [ // 모른다고 정중히 답하기 (知らないと丁寧に答える)
            ConversationData(speaker: "고객", text: "以前、こちらの部署にいらっしゃった、田中さんという方をご存じですか？", romaji: "이젠, 코치라노 부쇼니 이랏샷타, 타나카상토이우 카타오 고존지데스카?", translation: "이전에 이쪽 부서에 계셨던, 다나카 씨라는 분을 알고 계신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "申し訳ありません。私が入社する前のことのようでして、存じ上げません。", romaji: "모-시와케 아리마센. 와타시가 뉴-샤스루 마에노 코토노요-데시테, 존지아게마센.", translation: "죄송합니다. 제가 입사하기 전의 일인 것 같아서, 알지 못합니다.", isUserLine: true),
            ConversationData(speaker: "고객", text: "ああ、そうでしたか。失礼いたしました。", romaji: "아아, 소-데시타카. 시츠레-이타시마시타.", translation: "아아, 그랬군요. 실례했습니다.", isUserLine: false)
        ],
        294: [ // 기다리게 한 것에 대해 정중히 사과하기 (待たせたことを丁寧に謝罪する)
            ConversationData(speaker: "손님", text: "(로비에서 기다리고 있다)", romaji: "로비에서 기다리고 있다", translation: "로비에서 기다리고 있다", isUserLine: false),
            ConversationData(speaker: "나", text: "(안내하며) お客様、大変お待たせいたしました。会議室の準備が整いました。", romaji: "오캬쿠사마, 타이헨 오마타세이타시마시타. 카이기시츠노 준비가 토토노이마시타.", translation: "손님, 오래 기다리셨습니다. 회의실 준비가 다 되었습니다.", isUserLine: true),
            ConversationData(speaker: "손님", text: "はい、ありがとうございます。", romaji: "하이, 아리가토-고자이마스.", translation: "네, 감사합니다.", isUserLine: false)
        ],
        295: [ // 부재중이라고 전하기 (不在だと伝える)
            ConversationData(speaker: "외부 발신자", text: "もしもし、営業部の佐藤様いらっしゃいますでしょうか。", romaji: "모시모시, 에-교-부노 사토-사마 이랏샤이마스데쇼-카.", translation: "여보세요, 영업부의 사토 님 계십니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "申し訳ありません、佐藤はただいま、席を外しております。", romaji: "모-시와케 아리마센, 사토-와 타다이마, 세키오 하즈시테오리마스.", translation: "죄송합니다, 사토는 지금 자리를 비웠습니다.", isUserLine: true),
            ConversationData(speaker: "외부 발신자", text: "そうですか。では、戻られましたら折り返しお電話をいただけますでしょうか。", romaji: "소-데스카. 데와, 모도라레마시타라 오리카에시 오덴와오 이타다케마스데쇼-카.", translation: "그런가요. 그럼, 돌아오시면 다시 전화해달라고 해주시겠어요?", isUserLine: false)
        ],
        296: [ // 매우 정중하게 무언가를 부탁할 때 (非常に丁寧に何かを頼む時)
            ConversationData(speaker: "사토", text: "キムさん、このデータ、少し見ていただけますか。", romaji: "기무상, 코노 데-타, 스코시 미테이타다케마스카.", translation: "김 씨, 이 데이터 좀 봐주시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。…なるほど。恐れ入りますが、このグラフの元データも拝見できますでしょうか。", romaji: "하이. ...나루호도. 오소레이리마스가, 코노 구라후노 모토데-타모 하이켄데키마스데쇼-카.", translation: "네. ...그렇군요. 죄송합니다만, 이 그래프의 원본 데이터도 볼 수 있을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、もちろんです。今メールでお送りします。", romaji: "하이, 모치론데스. 이마 메-루데 오오쿠리시마스.", translation: "네, 물론입니다. 지금 메일로 보내드리겠습니다.", isUserLine: false)
        ],
        297: [ // 수고를 끼치는 것을 전제로 부탁할 때 (手間をかける前提で頼む時)
            ConversationData(speaker: "사토", text: "キムさん、何か手伝うことはありますか？", romaji: "기무상, 나니카 테츠다우 코토와 아리마스카?", translation: "김 씨, 뭐 도와드릴 일 있어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。では、お手数ですが、この書類を各部署に配布していただけますか？", romaji: "아리가토-고자이마스. 데와, 오테스-데스가, 코노 쇼루이오 카쿠부쇼니 하이후시테 이타다케마스카?", translation: "감사합니다. 그럼, 수고스러우시겠지만 이 서류를 각 부서에 배부해 주시겠어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、承知しました。", romaji: "하이, 쇼-치시마시타.", translation: "네, 알겠습니다.", isUserLine: false)
        ],
        298: [ // 리필을 권할 때 (お代わりを勧める時)
            ConversationData(speaker: "손님", text: "(마지막 남은 차를 마신다)", romaji: "마지막 남은 차를 마신다", translation: "마지막 남은 차를 마신다", isUserLine: false),
            ConversationData(speaker: "나", text: "お客様、お茶のお代わりはいかがですか？", romaji: "오캬쿠사마, 오차노 오카와리와 이카가데스카?", translation: "손님, 차 리필은 어떠신가요?", isUserLine: true),
            ConversationData(speaker: "손님", text: "あ、ありがとうございます。では、お願いします。", romaji: "아, 아리가토-고자이마스. 데와, 오네가이시마스.", translation: "아, 감사합니다. 그럼 부탁합니다.", isUserLine: false)
        ],
        299: [ // 맛이 싱겁다고 말할 때 (味が薄いと伝える時)
            ConversationData(speaker: "사토", text: "私が作ったお味噌汁、どうですか？お口に合いますか？", romaji: "와타시가 츠쿳타 오미소시루, 도-데스카? 오쿠치니 아이마스카?", translation: "제가 만든 된장국, 어때요? 입에 맞아요?", isUserLine: false),
            ConversationData(speaker: "나", text: "とても美味しいです。ただ、正直に言うと、もうちょっと味が薄いです。", romaji: "토테모 오이시-데스. 타다, 쇼-지키니 이우토, 모- 좃토 아지가 우스이데스.", translation: "아주 맛있어요. 다만, 솔직히 말하면 맛이 조금 싱거워요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですか！教えてくれてありがとう。次から参考にします。", romaji: "소-데스카! 오시에테쿠레테 아리가토-. 츠기카라 산코-니 시마스.", translation: "그래요! 알려줘서 고마워요. 다음부터 참고할게요.", isUserLine: false)
        ],
        300: [ // 맛을 칭찬할 때 (味を褒める時)
            ConversationData(speaker: "사토", text: "こちら、京都の有名な料亭の煮物です。どうぞ。", romaji: "코치라, 쿄-토노 유-메-나 료-테-노 니모노데스. 도-조.", translation: "이쪽은 교토의 유명한 요정의 조림입니다. 드셔보세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。…うーん、大変結構なお味で。出汁が効いていますね。", romaji: "아리가토-고자이마스. ...우-응, 타이헨 켓코-나 오아지데. 다시가 키이테이마스네.", translation: "감사합니다. ...음, 대단히 훌륭한 맛이네요. 육수가 잘 우러났어요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "お口に合ったようで、よかったです。", romaji: "오쿠치니 앗타요-데, 요캇타데스.", translation: "입에 맞으시는 것 같아 다행입니다.", isUserLine: false)
        ],
        301: [ // 강한 부정 또는 놀람의 표현 (強い否定・驚きの表現)
            ConversationData(speaker: "사토", text: "聞きました？田中さん、会社を辞めてユーチューバーになるそうですよ。", romaji: "키키마시타? 타나카상, 카이샤오 야메테 유-츄-바-니 나루소-데스요.", translation: "들었어요? 다나카 씨, 회사를 그만두고 유튜버가 된대요.", isUserLine: false),
            ConversationData(speaker: "나", text: "まさか！あの真面目な田中さんが？何かの冗談でしょう？", romaji: "마사카! 아노 마지메나 타나카상가? 나니카노 죠-단데쇼-?", translation: "설마! 그 성실한 다나카 씨가요? 농담이겠죠?", isUserLine: true),
            ConversationData(speaker: "사토", text: "いいえ、本当だそうです。本人から直接聞きました。", romaji: "이이에, 혼토-다소-데스. 혼닌카라 쵸쿠세츠 키키마시타.", translation: "아니요, 진짜래요. 본인한테 직접 들었어요.", isUserLine: false)
        ],
        302: [ // 예상했던 바를 확인할 때 (予想通りだと確認する時)
            ConversationData(speaker: "사토", text: "今日の会議、やっぱりあの件で部長は怒っていましたね。", romaji: "쿄-노 카이기, 얏파리 아노 켄데 부쵸-와 오콧테이마시타네.", translation: "오늘 회의, 역시 그 건 때문에 부장님이 화나셨네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうだろうとは思っていましたが…。やっぱりそうですか。", romaji: "소-다로-토와 오못테이마시타가... 얏파리 소-데스카.", translation: "그럴 거라고는 생각했지만… 역시 그렇군요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、かなりご立腹のようでした。しばらくは嵐が続きそうです。", romaji: "에에, 카나리 고릿푸쿠노요-데시타. 시바라쿠와 아라시가 츠즈키소-데스.", translation: "네, 꽤 화가 나신 것 같았어요. 당분간은 폭풍이 계속될 것 같네요.", isUserLine: false)
        ],
        303: [ // 그럴 것이라고 추측할 때 (そうなるはずだと推測する時)
            ConversationData(speaker: "사토", text: "注文した商品、今日の午前中に届く予定でしたよね？", romaji: "츄-몬시타 쇼-힌, 쿄-노 고젠츄-니 토도쿠 요테-데시타요네?", translation: "주문한 상품, 오늘 오전에 도착할 예정이었죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、配送状況を確認したら「配達中」になっていたので、そのはずです。", romaji: "하이, 하이소-죠-쿄-오 카쿠닌시타라 「하이타츠츄-」니 낫테이타노데, 소노 하즈데스.", translation: "네, 배송 상황을 확인하니 '배송 중'으로 되어 있었으니, 그럴 겁니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "よかった。もうすぐ届きそうですね。", romaji: "요캇타. 모-스구 토도키소-데스네.", translation: "다행이다. 이제 곧 도착하겠네요.", isUserLine: false)
        ],
        304: [ // 어쩔 수 없다고 체념할 때 (仕方ないと諦める時)
            ConversationData(speaker: "사토", text: "楽しみにしていた野外ライブ、大雨で中止になってしまいました。", romaji: "타노시미니 시테이타 야가이라이부, 오오아메데 츄-시니 낫테시마이마시타.", translation: "기대했던 야외 라이브, 폭우로 취소되어 버렸어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ああ、それは残念ですね。でも、天気のことだから、しょうがないですね。", romaji: "아아, 소레와 잔넨데스네. 데모, 텐키노 코토다카라, 쇼-가나이데스네.", translation: "아아, 그거 안타깝네요. 하지만 날씨 때문이니 어쩔 수 없죠.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、また次の機会を待つしかありません。", romaji: "에에, 마타 츠기노 키카이오 마츠시카 아리마센.", translation: "네, 다음 기회를 기다릴 수밖에 없어요.", isUserLine: false)
        ],
        305: [ // 과거를 추억할 때 (過去を思い出す時)
            ConversationData(speaker: "사토", text: "(옛날 앨범을 보며) この写真、大学の卒業式の時ですね。", romaji: "(옛날 앨범을 보며) 코노 샤신, 다이가쿠노 소츠교-시키노 토키데스네.", translation: "(옛날 앨범을 보며) 이 사진, 대학교 졸업식 때네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "うわあ、懐かしいですね。みんな若いなあ。", romaji: "우와아, 나츠카시-데스네. 민나 와카이나아.", translation: "우와, 그립네요. 다들 젊구나.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、あれからもう10年も経ったなんて、信じられません。", romaji: "에에, 아레카라 모- 쥬-넨모 탓타난테, 신지라레마센.", translation: "네, 그로부터 벌써 10년이나 지났다니, 믿을 수가 없어요.", isUserLine: false)
        ],
        306: [ // 위험을 경고할 때 (危険を警告する時)
            ConversationData(speaker: "사토", text: "(자전거가 달려오는 것을 못 보고 길을 건너려 한다)", romaji: "(자전거가 달려오는 것을 못 보고 길을 건너려 한다)", translation: "(자전거가 달려오는 것을 못 보고 길을 건너려 한다)", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、危ない！", romaji: "사토-상, 아부나이!", translation: "사토 씨, 위험해요!", isUserLine: true),
            ConversationData(speaker: "사토", text: "うわっ！…ありがとうございます。全然気づきませんでした。助かりました。", romaji: "우왓! ...아리가토-고자이마스. 젠젠 키즈키마센데시타. 타스카리마시타.", translation: "우왓! ...고맙습니다. 전혀 눈치채지 못했어요. 덕분에 살았어요.", isUserLine: false)
        ],
        307: [ // 시간에 늦을 것 같다고 말할 때 (時間に間に合わないかもしれないと伝える時)
            ConversationData(speaker: "사토", text: "この渋滞、ひどいですね。これでは約束の時間に…。", romaji: "코노 쥬-타이, 히도이데스네. 코레데와 야쿠소쿠노 지칸니...", translation: "이 교통체증, 심하네요. 이래서는 약속 시간에...", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、このままだと、間に合わないかもしれません。先に一本連絡を入れておきましょうか。", romaji: "에에, 코노마마다토, 마니와나이카모 시레마센. 사키니 잇폰 렌라쿠오 이레테오키마쇼-카.", translation: "네, 이대로라면 제시간에 도착하지 못할지도 몰라요. 먼저 연락 한번 해둘까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "そうですね。それがよさそうです。お願いします。", romaji: "소-데스네. 소레가 요사소-데스. 오네가이시마스.", translation: "그러게요. 그게 좋겠어요. 부탁합니다.", isUserLine: false)
        ],
        308: [ // 시작을 부드럽게 제안할 때 (開始を柔らかく提案する時)
            ConversationData(speaker: "사토", text: "参加予定の方は、これで全員集まりましたね。", romaji: "산카요테-노 카타와, 코레데 젠인 아츠마리마시타네.", translation: "참석 예정인 분들은 이걸로 다 모였네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。では、時間もちょうどいいですし、そろそろ始めませんか？", romaji: "하이. 데와, 지칸모 쵸-도 이이데스시, 소로소로 하지메마센카?", translation: "네. 그럼 시간도 딱 좋으니, 슬슬 시작하지 않을래요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、そうしましょう。本日はお集まりいただき、ありがとうございます。", romaji: "에에, 소-시마쇼-. 혼지츠와 오아츠마리이타다키, 아리가토-고자이마스.", translation: "네, 그렇게 하죠. 오늘 모여주셔서 감사합니다.", isUserLine: false)
        ],
        309: [ // 음식 맛이 어떤지 물을 때 (料理の味がどうか尋ねる時)
            ConversationData(speaker: "나", text: "(내가 만든 요리를 대접하며) 初めて作ってみたんですが、お口に合いますか？", romaji: "하지메테 츠쿳테미탄데스가, 오쿠치니 아이마스카?", translation: "처음 만들어 봤는데, 입에 맞으세요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "とても美味しいですよ！お店で食べるみたいです。", romaji: "토테모 오이시-데스요! 오미세데 타베루미타이데스.", translation: "아주 맛있어요! 가게에서 먹는 것 같아요.", isUserLine: false),
            ConversationData(speaker: "나", text: "よかった！そう言ってもらえると嬉しいです。", romaji: "요캇타! 소- 잇테모라에루토 우레시-데스.", translation: "다행이다! 그렇게 말해주니 기쁘네요.", isUserLine: true)
        ],
        310: [ // 안부를 물을 때의 정석적인 답변 (安否を尋ねられた時の定型的な返事)
            ConversationData(speaker: "사토", text: "キムさん、お久しぶりです。その後、お変わりありませんか。", romaji: "기무상, 오히사시부리데스. 소노고, 오카와리 아리마센카.", translation: "김 씨, 오랜만입니다. 그동안 별일 없으셨어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、おかげさまで、元気です。佐藤さんこそ、お元気そうで何よりです。", romaji: "하이, 오카게사마데, 겐키데스. 사토-상코소, 오겐키소-데 나니요리데스.", translation: "네, 덕분에 잘 지냅니다. 사토 씨야말로 건강해 보여서 무엇보다 다행입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、私も相変わらずですよ。", romaji: "에에, 와타시모 아이카와라즈데스요.", translation: "네, 저도 변함없습니다.", isUserLine: false)
        ],
        311: [ // 컨디션이나 진척 상황 묻기 (調子や進捗を尋ねる)
            ConversationData(speaker: "사토", text: "キムさん、新しい部署にはもう慣れましたか？", romaji: "기무상, 아타라시- 부쇼니와 모- 나레마시타카?", translation: "김 씨, 새로운 부서에는 이제 익숙해졌어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、おかげさまで。そちらのプロジェクトの調子はどうですか？", romaji: "하이, 오카게사마데. 소치라노 프로제쿠토노 쵸-시와 도-데스카?", translation: "네, 덕분에요. 그쪽 프로젝트의 상황은 어때요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "それが、少し問題が発生して、あまり良くないんです。", romaji: "소레가, 스코시 몬다이가 핫세-시테, 아마리 요쿠나인데스.", translation: "그게, 문제가 좀 발생해서 그다지 좋지 않아요.", isUserLine: false)
        ],
        312: [ // 리필이 무료임을 알리기 (お代わりが自由だと知らせる)
            ConversationData(speaker: "사토", text: "この定食、ご飯がすごく美味しいですね。", romaji: "코노 테-쇼쿠, 고항가 스고쿠 오이시-데스네.", translation: "이 정식, 밥이 정말 맛있네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうでしょう。このお店は、ご飯と味噌汁のお代わりは自由ですよ。", romaji: "소-데쇼-. 코노 오미세와, 고항토 미소시루노 오카와리와 지유-데스요.", translation: "그렇죠? 이 가게는 밥이랑 된장국 리필이 무료예요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当ですか！じゃあ、遠慮なくもう一杯いただきます。", romaji: "혼토-데스카! 쟈-, 엔료나쿠 모- 잇파이 이타다키마스.", translation: "정말요? 그럼, 사양 않고 한 그릇 더 먹겠습니다.", isUserLine: false)
        ],
        313: [ // 포장 주문하기 (持ち帰りを頼む)
            ConversationData(speaker: "점원", text: "店内でお召し上がりですか？", romaji: "텐나이데 오메시아가리데스카?", translation: "가게 안에서 드시나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、持ち帰りでお願いします。", romaji: "이이에, 모치카에리데 오네가이시마스.", translation: "아니요, 포장으로 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、5分ほどお待ちいただけますか。", romaji: "카시코마리마시타. 데와, 고훈호도 오마치이타다케마스카.", translation: "알겠습니다. 그럼, 5분 정도 기다려주시겠어요?", isUserLine: false)
        ],
        314: [ // 가게에서 먹고 간다고 말하기 (店内で食べると伝える)
            ConversationData(speaker: "점원", text: "いらっしゃいませ。ご注文をどうぞ。", romaji: "이랏샤이마세. 고츄-몬오 도-조.", translation: "어서 오세요. 주문하시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ハンバーガーセットを一つ。ここで食べます。", romaji: "한바-가-셋토오 히토츠. 코코데 타베마스.", translation: "햄버거 세트 하나요. 여기서 먹고 갈게요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。お飲み物はいかがなさいますか？", romaji: "카시코마리마시타. 오노미모노와 이카가나사이마스카?", translation: "알겠습니다. 음료는 어떻게 하시겠어요?", isUserLine: false)
        ],
        315: [ // 합석 요청하기 (相席を頼む)
            ConversationData(speaker: "사토", text: "(사내 식당에서 혼자 밥을 먹고 있다)", romaji: "(사내 식당에서 혼자 밥을 먹고 있다)", translation: "(사내 식당에서 혼자 밥을 먹고 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さん、お昼ですか。席が空いていないので、ご一緒してもいいですか？", romaji: "사토-상, 오히루데스카. 세키가 아이테이나이노데, 고잇쇼시테모 이이데스카?", translation: "사토 씨, 점심 드시는군요. 자리가 없어서 그런데, 함께 앉아도 괜찮을까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、キムさん。はい、もちろん。どうぞこちらへ。", romaji: "아, 기무상. 하이, 모치론. 도-조 코치라에.", translation: "아, 김 씨. 네, 물론이죠. 이쪽으로 앉으세요.", isUserLine: false)
        ],
        316: [ // 자리 변경 요청하기 (席の変更を頼む)
            ConversationData(speaker: "점원", text: "お客様、何か問題でもございましたか。", romaji: "오캬쿠사마, 나니카 몬다이데모 고자이마시타카.", translation: "손님, 무슨 문제라도 있으셨나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "すみません、この席、少し寒くて。もし空いていたら、席を変えてください。", romaji: "스미마센, 코노 세키, 스코시 사무쿠테. 모시 아이테이타라, 세키오 카에테쿠다사이.", translation: "죄송합니다, 이 자리가 좀 추워서요. 혹시 비어있다면 자리 좀 바꿔주세요.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。では、あちらの窓際の席はいかがでしょうか。", romaji: "카시코마리마시타. 데와, 아치라노 마도기와노 세키와 이카가데쇼-카.", translation: "알겠습니다. 그럼 저쪽 창가 자리는 어떠신가요?", isUserLine: false)
        ],
        317: [ // 정중하게 다른 사람의 주의를 끌 때 (丁寧に相手の注意を引く時)
            ConversationData(speaker: "부장", text: "(자기 자리에서 서류에 집중하고 있다)", romaji: "(자기 자리에서 서류에 집중하고 있다)", translation: "(자기 자리에서 서류에 집중하고 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "部長、お忙しいところ申し訳ありません。ちょっと、よろしいですか？", romaji: "부쵸-, 오이소가시- 토코로 모-시와케 아리마센. 좃토, 요로시-데스카?", translation: "부장님, 바쁘신 와중에 죄송합니다. 잠시, 괜찮으시겠습니까?", isUserLine: true),
            ConversationData(speaker: "부장", text: "おお、キム君か。どうした？", romaji: "오오, 기무쿤카. 도-시타?", translation: "오, 김 군인가. 무슨 일인가?", isUserLine: false)
        ],
        318: [ // 매우 정중한 사과 표현 (非常に丁寧な謝罪表現)
            ConversationData(speaker: "고객", text: "注文した商品と、違う色のものが届いたのですが。", romaji: "츄-몬시타 쇼-힌토, 치가우 이로노 모노가 토도이타노데스가.", translation: "주문한 상품과 다른 색의 물건이 도착했는데요.", isUserLine: false),
            ConversationData(speaker: "나", text: "大変申し訳ございません。こちらの完全な手違いでございます。", romaji: "타이헨 모-시와케 고자이마센. 코치라노 칸젠나 테치가이데 고자이마스.", translation: "대단히 죄송합니다. 저희의 완전한 착오입니다.", isUserLine: true),
            ConversationData(speaker: "고객", text: "すぐに正しい商品と交換してください。", romaji: "스구니 타다시- 쇼-힌토 코-칸시테쿠다사이.", translation: "즉시 올바른 상품으로 교환해주세요.", isUserLine: false)
        ],
        319: [ // 송구스러움을 표현할 때 (恐縮の気持ちを表現する時)
            ConversationData(speaker: "사장", text: "キム君、今回のプロジェクト、本当にご苦労だった。君のおかげで成功したよ。", romaji: "기무쿤, 콘카이노 프로제쿠토, 혼토-니 고쿠로-닷타. 키미노 오카게데 세-코-시타요.", translation: "김 군, 이번 프로젝트 정말 수고 많았네. 자네 덕분에 성공했어.", isUserLine: false),
            ConversationData(speaker: "나", text: "社長直々にそのようなお言葉をいただき、大変恐縮です。", romaji: "샤쵸- 지키지키니 소노요-나 오코토바오 이타다키, 타이헨 쿄-슈쿠데스.", translation: "사장님께 직접 그런 말씀을 들으니, 몸 둘 바를 모르겠습니다.", isUserLine: true),
            ConversationData(speaker: "사장", text: "これからも期待しているから、頑張りなさい。", romaji: "코레카라모 키타이시테이루카라, 간바리나사이.", translation: "앞으로도 기대하고 있으니, 열심히 하게.", isUserLine: false)
        ],
        320: [ // "알겠습니다"의 매우 정중한 표현 (「分かりました」の非常に丁寧な表現)
            ConversationData(speaker: "손님", text: "では、このケーキを二つ、プレゼント用に包んでください。", romaji: "데와, 코노 케-키오 후타츠, 프레젠토요-니 츠츤데쿠다사이.", translation: "그럼, 이 케이크 두 개를 선물용으로 포장해주세요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、かしこまりました。リボンのお色はいかがなさいますか？", romaji: "하이, 카시코마리마시타. 리본노 오이로와 이카가나사이마스카?", translation: "네, 알겠습니다. 리본 색은 어떻게 해드릴까요?", isUserLine: true),
            ConversationData(speaker: "손님", text: "ピンク色でお願いします。", romaji: "핀쿠이로데 오네가이시마스.", translation: "분홍색으로 부탁합니다.", isUserLine: false)
        ],
        321: [ // 일석이조라고 표현하기 (一石二鳥だと表現する)
            ConversationData(speaker: "사토", text: "毎朝、一駅前で降りて、会社まで歩くことにしたんです。", romaji: "마이아사, 히토에키 마에데 오리테, 카이샤마데 아루쿠 코토니 시탄데스.", translation: "매일 아침, 한 정거장 전에 내려서 회사까지 걷기로 했어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "へえ、それはいいですね。運動にもなるし、交通費も節約できるし、一石二鳥ですね。", romaji: "헤에, 소레와 이이데스네. 운도-니모 나루시, 코-츠-히모 세츠야쿠데키루시, 잇세키니쵸-데스네.", translation: "헤에, 그거 좋네요. 운동도 되고 교통비도 절약되고, 일석이조네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、おかげで体も軽くなった気がします。", romaji: "에에, 오카게데 카라다모 카루쿠낫타 키가 시마스.", translation: "네, 덕분에 몸도 가벼워진 기분이 들어요.", isUserLine: false)
        ],
        322: [ // 어느 쪽이라고 단정할 수 없을 때 (どちらとも言えない時)
            ConversationData(speaker: "사토", text: "今年の新入社員は、優秀だと思いますか？", romaji: "코토시노 신뉴-샤인와, 유-슈-다토 오모이마스카?", translation: "올해 신입사원은 우수하다고 생각하세요?", isUserLine: false),
            ConversationData(speaker: "나", text: "うーん、まだ配属されたばかりですからね。どちらとも言えません。", romaji: "우-응, 마다 하이조쿠사레타 바카리데스카라네. 도치라토모 이에마센.", translation: "음, 아직 배치된 지 얼마 안 돼서요. 어느 쪽이라고도 말할 수 없네요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "まあ、そうですよね。これからの活躍に期待しましょう。", romaji: "마아, 소-데스요네. 코레카라노 카츠야쿠니 키타이시마쇼-.", translation: "뭐, 그렇겠죠. 앞으로의 활약을 기대해 보죠.", isUserLine: false)
        ],
        323: [ // 일단 맥주를 주문할 때 (とりあえずビールを頼む時)
            ConversationData(speaker: "점원", text: "お飲み物は何になさいますか？", romaji: "오노미모노와 나니니 나사이마스카?", translation: "음료는 무엇으로 하시겠어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね、じゃあ、とりあえず、ビールで。生を二つお願いします。", romaji: "소-데스네, 쟈-, 토리아에즈, 비-루데. 나마오 후타츠 오네가이시마스.", translation: "글쎄요, 그럼 우선은 맥주로. 생맥주 두 잔 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "점원", text: "かしこまりました。生ビール二つですね。", romaji: "카시코마리마시타. 나마비-루 후타츠데스네.", translation: "알겠습니다. 생맥주 두 잔이요.", isUserLine: false)
        ],
        324: [ // 모임을 마칠 것을 제안할 때 (会を終えることを提案する時)
            ConversationData(speaker: "사토", text: "皆さん、話も盛り上がっていますが、もう夜も遅いですね。", romaji: "미나상, 하나시모 모리아갓테이마스가, 모- 요루모 오소이데스네.", translation: "여러분, 이야기도 무르익었지만 벌써 밤도 깊었네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね。では、名残惜しいですが、この辺でそろそろお開きにしましょうか。", romaji: "소-데스네. 데와, 나고리오시-데스가, 코노 헨데 소로소로 오히라키니 시마쇼-카.", translation: "그러게요. 그럼, 아쉽지만 이쯤에서 슬슬 마칠까요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、そうしましょう。本日はお集まりいただき、ありがとうございました！", romaji: "하이, 소-시마쇼-. 혼지츠와 오아츠마리이타다키, 아리가토-고자이마시타!", translation: "네, 그렇게 하죠. 오늘 모여주셔서 감사합니다!", isUserLine: false)
        ],
        325: [ // 화제를 바꿀 때 (話題を変える時)
            ConversationData(speaker: "사토", text: "…というわけで、来週の出張の件は以上です。", romaji: "...토이우 와케데, 라이슈-노 슛쵸-노 켄와 이죠-데스.", translation: "...라는 이유로, 다음 주 출장 건은 이상입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "承知しました。話は変わりますが、来月の社内コンペの準備は進んでいますか？", romaji: "쇼-치시마시타. 하나시와 카와리마스가, 라이게츠노 샤나이콘페노 준비와 스슨데이마스카?", translation: "알겠습니다. 이야기가 바뀝니다만, 다음 달 사내 경쟁 프레젠테이션 준비는 잘 되어가나요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "ああ、その件ですね。今、資料を作成しているところです。", romaji: "아아, 소노 켄데스네. 이마, 시료-오 사쿠세-시테이루 토코로데스.", translation: "아, 그 건 말이죠. 지금 자료를 작성하고 있는 중입니다.", isUserLine: false)
        ],
        326: [ // 만약을 위해 확인할 때 (念のため確認する時)
            ConversationData(speaker: "사토", text: "明日の待ち合わせ場所は、渋谷駅のハチ公前で合っていますよね？", romaji: "아시타노 마치아와세바쇼와, 시부야에키노 하치코-마에데 앗테이마스요네?", translation: "내일 약속 장소는 시부야역 하치코 동상 앞이 맞죠?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、そうですが、念のため、確認します。…ええ、間違いありません。", romaji: "하이, 소-데스가, 넨노타메, 카쿠닌시마스. ...에에, 마치가이 아리마센.", translation: "네, 그렇지만 만약을 위해 확인해 보겠습니다. …네, 틀림없습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。では、また明日。", romaji: "아리가토-고자이마스. 데와, 마타 아시타.", translation: "고맙습니다. 그럼 내일 봬요.", isUserLine: false)
        ],
        327: [ // 도움을 받고 감사할 때 (助けてもらって感謝する時)
            ConversationData(speaker: "사토", text: "キムさん、さっきは重い荷物を運ぶのを手伝ってくれて、ありがとうございました。", romaji: "기무상, 삿키와 오모이 니모츠오 하코부노오 테츠닷테쿠레테, 아리가토-고자이마시타.", translation: "김 씨, 아까 무거운 짐 옮기는 거 도와줘서 고마웠어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "いえいえ、とんでもないです。", romaji: "이에이에, 톤데모나이데스.", translation: "아니에요, 천만에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "一人じゃ大変だったので、本当に助かりました。", romaji: "히토리쟈 타이헨닷타노데, 혼토-니 타스카리마시타.", translation: "혼자서는 힘들었어서, 정말 도움이 됐어요.", isUserLine: false)
        ],
        328: [ // 유익한 정보를 얻었을 때 (有益な情報を得た時)
            ConversationData(speaker: "사토", text: "(선배로서 업무 노하우를 설명해 준다)", romaji: "(선배로서 업무 노하우를 설명해 준다)", translation: "(선배로서 업무 노하우를 설명해 준다)", isUserLine: false),
            ConversationData(speaker: "나", text: "なるほど、そんな方法があったんですね。とても勉強になりました。ありがとうございます。", romaji: "나루호도, 손나 호-호-가 앗탄데스네. 토테모 벤쿄-니 나리마시타. 아리가토-고자이마스.", translation: "그렇군요, 그런 방법이 있었네요. 많이 배웠습니다. 감사합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "よかったです。また何かあれば、いつでも聞いてくださいね。", romaji: "요캇타데스. 마타 나니카 아레바, 이츠데모 키이테쿠다사이네.", translation: "다행이네요. 또 뭔가 있으면 언제든지 물어보세요.", isUserLine: false)
        ],
        329: [ // 다음에 또 초대해달라고 말할 때 (また誘ってほしいと伝える時)
            ConversationData(speaker: "사토", text: "今日のホームパーティー、楽しんでいただけましたか？", romaji: "쿄-노 호-무파-티-, 타노신데 이타다케마시타카?", translation: "오늘 홈파티, 즐거우셨나요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、とても楽しかったです。お料理も全部美味しかったですし。また誘ってください。", romaji: "하이, 토테모 타노시캇타데스. 오료-리모 젠부 오이시캇타데스시. 마타 사솟테쿠다사이.", translation: "네, 아주 즐거웠어요. 음식도 전부 맛있었고요. 다음에 또 불러주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "もちろんです！いつでも大歓迎ですよ。", romaji: "모치론데스! 이츠데모 다이칸게-데스요.", translation: "물론이죠! 언제든지 대환영입니다.", isUserLine: false)
        ],
        330: [ // 중립적인 입장을 표명할 때 (中立的な立場を表明する時)
            ConversationData(speaker: "사회자", text: "このA社との提携案について、キムさんはどう思われますか？", romaji: "코노 에-샤토노 테-케-안니 츠이테, 기무상와 도- 오모와레마스카?", translation: "이 A사와의 제휴안에 대해, 김 씨는 어떻게 생각하십니까?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね、メリットもデメリットもあるかと存じますので、現時点では賛成も反対もしません。", romaji: "소-데스네, 메릿토모 데메릿토모 아루카토 존지마스노데, 겐지텐데와 산세-모 한타이모 시마센.", translation: "글쎄요, 장점도 단점도 있다고 생각하므로, 현시점에서는 찬성도 반대도 하지 않겠습니다.", isUserLine: true),
            ConversationData(speaker: "사회자", text: "なるほど、慎重なご意見ですね。ありがとうございます。", romaji: "나루호도, 신쵸-나 고이켄데스네. 아리가토-고자이마스.", translation: "그렇군요, 신중한 의견이시네요. 감사합니다.", isUserLine: false)
        ],
        331: [ // 대화를 마무리할 때 (会話を締めくくる時)
            ConversationData(speaker: "사토", text: "皆さん、たくさんのご意見ありがとうございました。", romaji: "미나상, 타쿠상노 고이켄 아리가토-고자이마시타.", translation: "여러분, 많은 의견 감사합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そろそろ時間ですので、本日の会議はこの辺で終わりにしたいと思います。", romaji: "소로소로 지칸데스노데, 혼지츠노 카이기와 코노헨데 오와리니 시타이토 오모이마스.", translation: "슬슬 시간이 되었으므로, 오늘 회의는 이쯤에서 마치도록 하겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "了解しました。続きはまた明日、話し合いましょう。", romaji: "료카이시마시타. 츠즈키와 마타 아시타, 하나시아이마쇼-.", translation: "알겠습니다. 다음 내용은 내일 다시 이야기합시다.", isUserLine: false)
        ],
        332: [ // 다시 연락하겠다고 말하기 (また連絡すると伝える)
            ConversationData(speaker: "사토", text: "ご提案ありがとうございます。一度、社内で検討させていただきます。", romaji: "고테-안 아리가토-고자이마스. 이치도, 샤나이데 켄토-사세테이타다키마스.", translation: "제안 감사합니다. 일단 사내에서 검토하도록 하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、ぜひお願いします。結果が出ましたら、また連絡します。", romaji: "하이, 제히 오네가이시마스. 켓카가 데마시타라, 마타 렌라쿠시마스.", translation: "네, 부디 부탁드립니다. 결과가 나오면 다시 연락드리겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "かしこまりました。お待ちしております。", romaji: "카시코마리마시타. 오마치시테오리마스.", translation: "알겠습니다. 기다리고 있겠습니다.", isUserLine: false)
        ],
        333: [ // 상대방의 건강한 모습에 안도하기 (相手の元気な姿に安堵する)
            ConversationData(speaker: "사토", text: "キムさん、ご無沙汰しております。お変わりありませんか。", romaji: "기무상, 고부사타시테오리마스. 오카와리 아리마센카.", translation: "김 씨, 오랜만입니다. 별일 없으신지요?", isUserLine: false),
            ConversationData(speaker: "나", text: "佐藤さんこそ。お元気そうで何よりです。", romaji: "사토-상코소. 오겐키소-데 나니요리데스.", translation: "사토 씨야말로. 건강해 보이셔서 무엇보다 다행입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。キムさんもお元気そうで安心しました。", romaji: "아리가토-고자이마스. 기무상모 오겐키소-데 안신시마시타.", translation: "감사합니다. 김 씨도 건강해 보여서 안심했습니다.", isUserLine: false)
        ],
        334: [ // 정중하고 간접적으로 반대하기 (丁寧かつ間接的に反対する)
            ConversationData(speaker: "부장", text: "このプロジェクトのリーダーは、新人の田中君に任せようと思うんだが、どうだろうか。", romaji: "코노 프로제쿠토노 리-다-와, 신진노 타나카쿤니 마카세요-토 오모운다가, 도-다로-카.", translation: "이 프로젝트의 리더는 신입인 다나카 군에게 맡기려고 하는데, 어떤가?", isUserLine: false),
            ConversationData(speaker: "나", text: "恐れながら申し上げますが、そのご意見には賛成しかねます。まだ経験が浅すぎると存じます。", romaji: "오소레나가라 모-시아게마스가, 소노 고이켄니와 산세-시카네마스. 마다 케-켄가 아사스기루토 존지마스.", translation: "외람된 말씀이지만, 그 의견에는 찬성하기 어렵습니다. 아직 경험이 너무 부족하다고 생각합니다.", isUserLine: true),
            ConversationData(speaker: "부장", text: "うーん、そうか。君の言うことにも一理あるな。", romaji: "우-응, 소-카. 키미노 이우코토니모 이치리 아루나.", translation: "음, 그런가. 자네 말에도 일리가 있군.", isUserLine: false)
        ],
        335: [ // 검토하겠다고 답하기 (検討すると答える)
            ConversationData(speaker: "거래처", text: "こちらが新しい提案書です。いかがでしょうか。", romaji: "코치라가 아타라시- 테-안쇼데스. 이카가데쇼-카.", translation: "이쪽이 새로운 제안서입니다. 어떠신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "ありがとうございます。すぐには判断できかねますので、一度持ち帰って検討します。", romaji: "아리가토-고자이마스. 스구니와 한단데키카네마스노데, 이치도 모치카엣테 켄토-시마스.", translation: "감사합니다. 바로 판단하기는 어려우니, 일단 가지고 돌아가 검토하겠습니다.", isUserLine: true),
            ConversationData(speaker: "거래처", text: "かしこまりました。良いお返事をお待ちしております。", romaji: "카시코마리마시타. 요이 오헨지오 오마치시테오리마스.", translation: "알겠습니다. 좋은 답변 기다리고 있겠습니다.", isUserLine: false)
        ],
        336: [ // 화제 전환하기 (話題を転換する)
            ConversationData(speaker: "사토", text: "いやあ、昨日のサッカーの試合は本当に興奮しましたね。", romaji: "이야아, 키노-노삿카-노 시아이와 혼토-니 코-훈시마시타네.", translation: "이야, 어제 축구 시합은 정말 흥분됐네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "ええ、本当に。…まあ、それはさておき、今日の午後の会議の準備は終わりましたか？", romaji: "에에, 혼토-니. ...마아, 소레와 사테오키, 쿄-노 고고노 카이기노 준비와 오와리마시타카?", translation: "네, 정말요. …뭐, 그건 그렇고, 오늘 오후 회의 준비는 끝났어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "あ、すみません、まだです。今から急いでやります。", romaji: "아, 스미마센, 마다데스. 이마카라 이소이데 야리마스.", translation: "아, 죄송해요, 아직이요. 지금부터 서둘러서 할게요.", isUserLine: false)
        ],
        337: [ // 요약해서 말하기 (要約して話す)
            ConversationData(speaker: "사토", text: "（長く複雑な説明をしている）", romaji: "（문제의 배경과 경과를 길고 복잡하게 설명한다）", translation: "（문제의 배경과 경과를 길고 복잡하게 설명한다）", isUserLine: false),
            ConversationData(speaker: "나", text: "なるほど、よく分かりました。要するに、予算不足で計画が中断している、ということですね？", romaji: "나루호도, 요쿠 와카리마시타. 요-스루니, 요산부소쿠데 케-카쿠가 츄-단시테이루, 토이우 코토데스네?", translation: "그렇군요, 잘 알겠습니다. 요컨대, 예산 부족으로 계획이 중단되었다는 것이죠?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ご明察の通りです。", romaji: "하이, 고메-사츠노 토-리데스.", translation: "네, 명찰하신 그대로입니다.", isUserLine: false)
        ],
        338: [ // 어디까지나 개인적인 의견임을 밝힐 때 (あくまで個人的な意見だと前置きする時)
            ConversationData(speaker: "사토", text: "このA案とB案、どちらで進めるべきでしょうか。", romaji: "코노 에-안토 비-안, 도치라데 스스메루베키데쇼-카.", translation: "이 A안과 B안, 어느 쪽으로 진행해야 할까요?", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですね…。あくまでも私の意見ですが、長期的に見ればB案の方がメリットが大きいと思います。", romaji: "소-데스네... 아쿠마데모 와타시노 이켄데스가, 쵸-키테키니 미레바 비-안노 호-가 메릿토가 오-키이토 오모이마스.", translation: "글쎄요… 어디까지나 제 개인적인 의견이지만, 장기적으로 보면 B안 쪽이 장점이 크다고 생각합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "なるほど、참고にします。ありがとうございます。", romaji: "나루호도, 산코-니 시마스. 아리가토-고자이마스.", translation: "그렇군요, 참고하겠습니다. 감사합니다.", isUserLine: false)
        ],
        339: [ // 상대방 의견에 대한 존중 표현 (相手の意見への尊重を表現)
            ConversationData(speaker: "동료", text: "この企画について、私はちょっと不安があります。", romaji: "코노 키카쿠니 츠이테, 와타시와 쵸-토 후안가 아리마스.", translation: "이 기획에 대해서, 저는 좀 불안이 있어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そのお気持ち、よく理解できます。どういった点がご心配でしょうか？", romaji: "소노 오키모치, 요쿠 리카이데키마스. 도-이쟛타 텐가 고신파이데쇼-카?", translation: "그런 마음, 잘 이해할 수 있어요. 어떤 점이 걱정되시나요?", isUserLine: true),
            ConversationData(speaker: "동료", text: "ありがとうございます。スケジュールがタイトすぎる気がするんです。", romaji: "아리가토-고자이마스. 스케쥴가 타이토스기루 키가 스룬데스.", translation: "고마워요. 일정이 너무 빡빡한 것 같아요.", isUserLine: false)
        ],
        340: [ // 상대방을 격려할 때 (相手を励ます時)
            ConversationData(speaker: "동료", text: "最近、仕事がうまくいかないんです。自信を失ってしまって…。", romaji: "사이킨, 시고토가 우마쿠이카나인데스. 지신오 우시낫테시맛테...", translation: "요즘 일이 잘 안 돼요. 자신감을 잃어버려서…", isUserLine: false),
            ConversationData(speaker: "나", text: "そんなことないですよ。あなたの頑張りを皆が認めています。時間がかかっても大丈夫です。", romaji: "손나 코토나이데스요. 아나타노 간바리오 민나가 미토메테이마스. 지칸가 카캇테모 다이죠-부데스.", translation: "그런 거 없어요. 당신의 노력을 모두가 인정하고 있어요. 시간이 걸려도 괜찮습니다.", isUserLine: true),
            ConversationData(speaker: "동료", text: "ありがとうございます。そう言ってもらえて心強いです。", romaji: "아리가토-고자이마스. 소- 잇테모라에테 코코로즈요이데스.", translation: "감사합니다. 그렇게 말씀해 주셔서 든든해요.", isUserLine: false)
        ],
        341: [ // 호의를 받아들일 때 (好意を受け入れる時)
            ConversationData(speaker: "사토", text: "今日は私がご馳走しますよ。いつもお世話になっていますから。", romaji: "쿄-와 와타시가 고치소-시마스요. 이츠모 오세와니 낫테이마스카라.", translation: "오늘은 제가 대접할게요. 항상 신세 지고 있으니까요.", isUserLine: false),
            ConversationData(speaker: "나", text: "そんな、悪いですよ。でも…では、お言葉に甘えて。ご馳走になります。", romaji: "손나, 와루이데스요. 데모... 데와, 오코토바니 아마에테. 고치소-니 나리마스.", translation: "아유, 미안한데요. 하지만… 그럼, 말씀대로. 잘 먹겠습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、遠慮なさらずに、たくさん注文してくださいね。", romaji: "하이, 엔료나사라즈니, 타쿠상 츄-몬시테쿠다사이네.", translation: "네, 사양하지 말고 많이 주문하세요.", isUserLine: false)
        ],
        342: [ // 가볍게 헤어질 때 (軽く別れる時)
            ConversationData(speaker: "사토", text: "今日は付き合ってくれてありがとう。そろそろ失礼しますね。", romaji: "쿄-와 츠키앗테쿠레테 아리가토-. 소로소로 시츠레-시마스네.", translation: "오늘 함께해줘서 고마워요. 슬슬 실례할게요.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。楽しかったです。では、また今度。", romaji: "코치라코소. 타노시캇타데스. 데와, 마타 콘도.", translation: "저야말로요. 즐거웠어요. 그럼, 다음에 또 봐요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、近いうちにまた連絡します。", romaji: "에에, 치카이 우치니 마타 렌라쿠시마스.", translation: "네, 조만간 또 연락할게요.", isUserLine: false)
        ],
        343: [ // 가까운 시일 내에 다시 만나자고 할 때 (近いうちに再会を約束する時)
            ConversationData(speaker: "사토", text: "今日は時間がなくて残念でした。もっと話したかったです。", romaji: "쿄-와 지칸가 나쿠테 잔넨데시타. 못토 하나시타캇타데스.", translation: "오늘은 시간이 없어서 아쉬웠어요. 더 이야기하고 싶었는데.", isUserLine: false),
            ConversationData(speaker: "나", text: "私もです。ぜひ、近いうちにまた会いましょう。", romaji: "와타시모데스. 제히, 치카이 우치니 마타 아이마쇼-.", translation: "저도요. 꼭, 조만간 다시 만나요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい！来週あたり、いかがですか？", romaji: "하이! 라이슈- 아타리, 이카가데스카?", translation: "네! 다음 주쯤 어떠세요?", isUserLine: false)
        ],
        344: [ // 좋은 하루 보내라고 인사할 때 (良い一日をと挨拶する時)
            ConversationData(speaker: "사토", text: "では、私はここで。お先に失礼します。", romaji: "데와, 와타시와 코코데. 오사키니 시츠레-시마스.", translation: "그럼 저는 여기서. 먼저 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、お疲れ様でした。良い一日を。", romaji: "하이, 오츠카레사마데시타. 요이 이치니치오.", translation: "네, 수고하셨습니다. 좋은 하루 보내세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。キムさんも。", romaji: "아리가토-고자이마스. 기무상모.", translation: "고맙습니다. 김 씨도요.", isUserLine: false)
        ],
        345: [ // 좋은 주말 보내라고 인사할 때 (良い週末をと挨拶する時)
            ConversationData(speaker: "사토", text: "キムさん、一週間お疲れ様でした。お先に失礼します。", romaji: "기무상, 잇슈-칸 오츠카레사마데시타. 오사키니 시츠레-시마스.", translation: "김 씨, 한 주간 수고 많았어요. 먼저 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、お疲れ様でした。良い週末を。", romaji: "하이, 오츠카레사마데시타. 요이 슈-마츠오.", translation: "네, 수고하셨습니다. 좋은 주말 보내세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。キムさんも、ゆっくり休んでくださいね。", romaji: "아리가토-고자이마스. 기무상모, 윳쿠리 야슨데쿠다사이네.", translation: "고맙습니다. 김 씨도 푹 쉬세요.", isUserLine: false)
        ],
        346: [ // 오랫동안 못 볼 사람에게 인사할 때 (長く会えない人への挨拶)
            ConversationData(speaker: "사토", text: "いよいよ明日、海外に赴任します。今まで、大変お世話になりました。", romaji: "이요이요 아시타, 카이가이니 후닌시마스. 이마마데, 타이헨 오세와니 나리마시타.", translation: "드디어 내일 해외로 부임합니다. 그동안 정말 신세 많이 졌습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。寂しくなりますね。どうぞ、お元気で。", romaji: "코치라코소. 사비시쿠나리마스네. 도-조, 오겐키데.", translation: "저야말로요. 서운해지겠네요. 부디, 몸 건강히 지내세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。キムさんも、お体を大切に。", romaji: "아리가토-고자이마스. 기무상모, 오카라다오 타이세츠니.", translation: "고맙습니다. 김 씨도 몸 건강히 챙기세요.", isUserLine: false)
        ],
        347: [ // 제3자에게 안부 전해달라고 부탁할 때 (第三者への安否伝達を頼む時)
            ConversationData(speaker: "사토", text: "では、そろそろこれで失礼いたします。", romaji: "데와, 소로소로 코레데 시츠레-이타시마스.", translation: "그럼, 슬슬 이만 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい。奥様にもくれぐれもよろしくお伝えください。", romaji: "하이. 오쿠사마니모 쿠레구레모 요로시쿠 오츠타에쿠다사이.", translation: "네. 사모님께도 부디 안부 전해주세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ありがとうございます。必ず申し伝えます。", romaji: "아리가토-고자이마스. 카나라즈 모-시츠타에마스.", translation: "감사합니다. 꼭 전하겠습니다.", isUserLine: false)
        ],
        348: [ // 오랜만에 만난 사람에게 안부를 물을 때 (久しぶりに会った人に安否を尋ねる時)
            ConversationData(speaker: "사토", text: "キムさん、ご無沙汰しております。", romaji: "기무상, 고부사타시테오리마스.", translation: "김 씨, 오랜만입니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "ああ、佐藤さん！お久しぶりです。その後、何かお変わりありませんか？", romaji: "아아, 사토-상! 오히사시부리데스. 소노고, 나니카 오카와리 아리마센카?", translation: "아아, 사토 씨! 오랜만이에요. 그동안 별일 없으셨어요?", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、おかげさまで。元気にやっております。", romaji: "하이, 오카게사마데. 겐키니 얏테오리마스.", translation: "네, 덕분에요. 잘 지내고 있습니다.", isUserLine: false)
        ],
        349: [ // 별일 없다고 답할 때 (変わりないと答える時)
            ConversationData(speaker: "사토", text: "キムさん、お久しぶりです。お変わりありませんか？", romaji: "기무상, 오히사시부리데스. 오카와리 아리마센카?", translation: "김 씨, 오랜만입니다. 별일 없으신가요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、おかげさまで、変わりありません。佐藤さんこそ、お元気そうで何よりです。", romaji: "하이, 오카게사마데, 카와리 아리마센. 사토-상코소, 오겐키소-데 나니요리데스.", translation: "네, 덕분에 변함없습니다. 사토 씨야말로 건강해 보여서 다행입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、私も元気に過ごしていますよ。", romaji: "에에, 와타시모 겐키니 스고시테이마스요.", translation: "네, 저도 건강하게 잘 지내고 있어요.", isUserLine: false)
        ],
        350: [ // 앞으로도 잘 부탁한다고 말할 때 (今後もよろしくと伝える時)
            ConversationData(speaker: "사토", text: "今年度も大変お世話になりました。", romaji: "콘넨도모 타이헨 오세와니 나리마시타.", translation: "올 한 해도 정말 신세 많이 졌습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ、いつもありがとうございます。来年度も、今後ともよろしくお願いします。", romaji: "코치라코소, 이츠모 아리가토-고자이마스. 라이넨도모, 콘고토모 요로시쿠 오네가이시마스.", translation: "저야말로, 항상 감사합니다. 내년에도, 앞으로도 잘 부탁드립니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "こちらこそ、よろしくお願いいたします。良いお年を。", romaji: "코치라코소, 요로시쿠 오네가이이타시마스. 요이 오토시오.", translation: "저야말로 잘 부탁드립니다. 좋은 새해 맞으세요.", isUserLine: false)
        ],
        351: [ // 큰 신세를 졌을 때의 감사 표현 (大変お世話になった時の感謝表現)
            ConversationData(speaker: "부장", text: "キム君、今日でうちの部署も最後だな。今まで本当にご苦労だった。", romaji: "기무쿤, 쿄-데 우치노 부쇼모 사이고다나. 이마마데 혼토-니 고쿠로-닷타.", translation: "김 군, 오늘로 우리 부서도 마지막이군. 그동안 정말 수고 많았네.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ。部長には、言葉では言い尽くせないほど、大変お世話になりました。", romaji: "이이에. 부쵸-니와, 코토바데와 이이츠쿠세나이호도, 타이헨 오세와니 나리마시타.", translation: "아닙니다. 부장님께는 말로는 다 할 수 없을 만큼, 정말 신세 많이 졌습니다.", isUserLine: true),
            ConversationData(speaker: "부장", text: "新しい部署に行っても、君ならきっとうまくやれる。応援しているよ。", romaji: "아타라시- 부쇼니 잇테모, 키미나라 킷토 우마쿠 야레루. 오-엔시테이루요.", translation: "새로운 부서에 가서도 자네라면 분명 잘 해낼 거야. 응원하고 있겠네.", isUserLine: false)
        ],
        352: [ // 재회를 기약하는 정중한 인사 (再会を期する丁寧な挨拶)
            ConversationData(speaker: "거래처", text: "本日は、貴重なお時間をいただき、ありがとうございました。", romaji: "혼지츠와, 키쵸-나 오지칸오 이타다키, 아리가토-고자이마시타.", translation: "오늘은 귀중한 시간을 내주셔서 감사했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ、有意義な会議でした。またお会いできるのを楽しみにしております。", romaji: "코치라코소, 유-이기나 카이기데시타. 마타 오아이데키루노오 타노시미니 시테오리마스.", translation: "저희야말로, 유익한 회의였습니다. 다시 뵐 수 있기를 기대하고 있겠습니다.", isUserLine: true),
            ConversationData(speaker: "거래처", text: "ええ、ぜひ。今後とも、どうぞよろしくお願いいたします。", romaji: "에에, 제히. 콘고토모, 도-조 요로시쿠 오네가이이타시마스.", translation: "네, 물론입니다. 앞으로도 부디 잘 부탁드립니다.", isUserLine: false)
        ],
        353: [ // 윗사람에게 무리하지 말라고 할 때 (目上の人に無理しないように言う時)
            ConversationData(speaker: "부장", text: "(기침하며) 少し体調が優れないが、このレポートは今日中に仕上げないといけないんだ。", romaji: "(기침하며) 스코시 타이쵸-가 스구레나이가, 코노 레포-토와 쿄-쥬-니 시아게나이토 이케나인다.", translation: "(기침하며) 몸 상태가 조금 좋지 않지만, 이 보고서는 오늘 중으로 마무리해야만 해.", isUserLine: false),
            ConversationData(speaker: "나", text: "部長、どうぞ無理なさらないでください。残りは私たちがやりますので、お休みください。", romaji: "부쵸-, 도-조 무리나사라나이데쿠다사이. 노코리와 와타시타치가 야리마스노데, 오야스미쿠다사이.", translation: "부장님, 부디 무리하지 마십시오. 나머지는 저희가 할 테니, 쉬십시오.", isUserLine: true),
            ConversationData(speaker: "부장", text: "…そうか。すまないな、では言葉に甘えさせてもらうよ。", romaji: "...소-카. 스마나이나, 데와 코토바니 아마에사세테모라우요.", translation: "...그런가. 미안하군, 그럼 자네들 말대로 하지.", isUserLine: false)
        ],
        354: [ // 상대의 무사를 기뻐할 때 (相手の無事を喜ぶ時)
            ConversationData(speaker: "사토", text: "昨日の地震、かなり揺れましたね。キムさんのご自宅は大丈夫でしたか？", romaji: "키노-노 지신, 카나리 유레마시타네. 기무상노 고지타쿠와 다이죠-부데시타카?", translation: "어제 지진, 꽤 흔들렸죠. 김 씨 댁은 괜찮았어요?", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、うちは大丈夫でした。佐藤さんこそ、ご無事で何よりです。", romaji: "하이, 우치와 다이죠-부데시타. 사토-상코소, 고부지데 나니요리데스.", translation: "네, 저희 집은 괜찮았어요. 사토 씨야말로, 무사하셔서 무엇보다 다행입니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "ええ、本当に。物が少し落ちただけで、被害はありませんでした。", romaji: "에에, 혼토-니. 모노가 스코시 오치타다케데, 히가이와 아리마센데시타.", translation: "네, 정말요. 물건이 좀 떨어졌을 뿐, 피해는 없었어요.", isUserLine: false)
        ],
        355: [ // 언제든 도와주겠다고 말할 때 (いつでも助けると伝える時)
            ConversationData(speaker: "후배", text: "新しい業務、覚えることが多すぎて、何から手をつければいいか…。", romaji: "아타라시- 교-무, 오보에루코토가 오-스기테, 나니카라 테오 츠케레바 이이카...", translation: "새로운 업무, 외울 게 너무 많아서 뭐부터 손대야 할지...", isUserLine: false),
            ConversationData(speaker: "나", text: "最初はみんなそうだよ。困ったことがあったら、いつでも声をかけてください。", romaji: "사이쇼와 민나 소-다요. 코맛타 코토가 앗타라, 이츠데모 코에오 카케테쿠다사이.", translation: "처음엔 다 그래. 곤란한 일 있으면 언제든지 말 걸어.", isUserLine: true),
            ConversationData(speaker: "후배", text: "先輩…。ありがとうございます！そのお言葉だけで心強いです。", romaji: "센파이... 아리가토-고자이마스! 소노 오코토바다케데 코코로즈요이데스.", translation: "선배님... 감사합니다! 그 말씀만으로도 든든합니다.", isUserLine: false)
        ],
        356: [ // 도움을 준 것에 대한 기쁨 표현 (助けたことへの喜びの表現)
            ConversationData(speaker: "사토", text: "キムさん、この間は相談に乗ってくれてありがとうございました。おかげで、問題が解決しました。", romaji: "기무상, 코노 아이다와 소-단니 놋테쿠레테 아리가토-고자이마시타. 오카게데, 몬다이가 카이케츠시마시타.", translation: "김 씨, 지난번에 상담해줘서 고마웠어요. 덕분에 문제가 해결됐어요.", isUserLine: false),
            ConversationData(speaker: "나", text: "それはよかったです。少しでもお力になれて嬉しいです。", romaji: "소레와 요캇타데스. 스코시데모 오치카라니 나레테 우레시-데스.", translation: "그거 다행이네요. 조금이라도 도움이 되어서 기쁩니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "本当に感謝しています。今度、お礼させてください。", romaji: "혼토-니 칸샤시테이마스. 콘도, 오레-사세테쿠다사이.", translation: "정말 감사하고 있어요. 다음에 보답하게 해주세요.", isUserLine: false)
        ],
        357: [ // 헤어질 때의 강한 감사 표현 (別れ際の強い感謝表現)
            ConversationData(speaker: "사토", text: "今日はお招きいただき、ありがとうございました。そろそろ失礼します。", romaji: "쿄-와 오마네키이타다키, 아리가토-고자이마시타. 소로소로 시츠레-시마스.", translation: "오늘 초대해주셔서 감사합니다. 슬슬 실례하겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "こちらこそ。今日は本当にありがとうございました。気をつけてお帰りください。", romaji: "코치라코소. 쿄-와 혼토-니 아리가토-고자이마시타. 키오츠케테 오카에리쿠다사이.", translation: "저야말로요. 오늘은 정말로 감사했습니다. 조심히 돌아가세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ではまた。", romaji: "하이, 데와 마타.", translation: "네, 그럼 또 봬요.", isUserLine: false)
        ],
        358: [ // 기본 인사 "잘 부탁합니다" (基本の挨拶「よろしくお願いします」)
            ConversationData(speaker: "사토", text: "はじめまして。今日からこちらでお世話になります、佐藤と申します。", romaji: "하지메마시테. 쿄-카라 코치라데 오세와니 나리마스, 사토-토 모-시마스.", translation: "처음 뵙겠습니다. 오늘부터 이곳에서 신세 지게 된 사토라고 합니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "キムです。こちらこそ、よろしくお願いします。", romaji: "기무데스. 코치라코소, 요로시쿠 오네가이시마스.", translation: "김입니다. 저야말로 잘 부탁합니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、分からないことばかりですが、一生懸命頑張りますので、よろしくお願いします。", romaji: "하이, 와카라나이코토 바카리데스가, 잇쇼-켄메- 간바리마스노데, 요로시쿠 오네가이시마스.", translation: "네, 모르는 것뿐이지만, 열심히 노력할 테니 잘 부탁드립니다.", isUserLine: false)
        ],
        359: [ // "천만에요"의 다른 표현 (どういたしましての他の表現)
            ConversationData(speaker: "사토", text: "先日は、本当にありがとうございました。", romaji: "센지츠와, 혼토-니 아리가토-고자이마시타.", translation: "지난번에는 정말 감사했습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "いいえ、どういたしまして。", romaji: "이이에, 도-이타시마시테.", translation: "아니에요, 천만에요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "おかげさまで、助かりました。", romaji: "오카게사마데, 타스카리마시타.", translation: "덕분에 큰 도움이 되었습니다.", isUserLine: false)
        ],
        360: [ // 다용도 표현 "실례합니다" (多用途表現「すみません」)
            ConversationData(speaker: "점원", text: "(바쁘게 움직이고 있다)", romaji: "(바쁘게 움직이고 있다)", translation: "(바쁘게 움직이고 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "あのう、すみません。注文、お願いできますか？", romaji: "아노-, 스미마센. 츄-몬, 오네가이데키마스카?", translation: "저기, 실례합니다. 주문, 부탁드려도 될까요?", isUserLine: true),
            ConversationData(speaker: "점원", text: "はい、ただいま！少々お待ちください！", romaji: "하이, 타다이마! 쇼-쇼- 오마치쿠다사이!", translation: "네, 지금 가겠습니다! 잠시만 기다려주세요!", isUserLine: false)
        ],
        361: [ // 먼저 자리를 뜰 때의 인사 (先に席を立つ時の挨拶)
            ConversationData(speaker: "동료들", text: "(아직 업무에 집중하고 있다)", romaji: "(아직 업무에 집중하고 있다)", translation: "(아직 업무에 집중하고 있다)", isUserLine: false),
            ConversationData(speaker: "나", text: "皆さん、お疲れ様です。では、お先に失礼します。", romaji: "미나상, 오츠카레사마데스. 데와, 오사키니 시츠레-시마스.", translation: "여러분, 수고 많으십니다. 그럼, 먼저 실례하겠습니다.", isUserLine: true),
            ConversationData(speaker: "동료", text: "はい、お疲れ様でした。", romaji: "하이, 오츠카레사마데시타.", translation: "네, 수고하셨습니다.", isUserLine: false)
        ],
        362: [ // 상대의 건강을 염려하는 인사 (相手の健康を気遣う挨拶)
            ConversationData(speaker: "사토", text: "では、明日から一週間の海外出張に行ってまいります。", romaji: "데와, 아시타카라 잇슈-칸노 카이가이슛쵸-니 잇테마이리마스.", translation: "그럼, 내일부터 일주일간 해외 출장 다녀오겠습니다.", isUserLine: false),
            ConversationData(speaker: "나", text: "そうですか。あちらは寒いと聞きましたので、どうぞお体に気をつけて。", romaji: "소-데스카. 아치라와 사무이토 키키마시타노데, 도-조 오카라다니 키오츠케테.", translation: "그러세요? 그곳은 춥다고 들었으니, 부디 몸조심하세요.", isUserLine: true),
            ConversationData(speaker: "사토", text: "はい、ありがとうございます。行ってまいります。", romaji: "하이, 아리가토-고자이마스. 잇테마이리마스.", translation: "네, 감사합니다. 다녀오겠습니다.", isUserLine: false)
        ],
        363: [ // 외출 인사 (出かける時の挨拶)
            ConversationData(speaker: "가족", text: "今日は帰り、遅くなるの？", romaji: "쿄-와 카에리, 오소쿠나루노?", translation: "오늘 늦게 들어와?", isUserLine: false),
            ConversationData(speaker: "나", text: "うん、たぶん。じゃあ、行ってきます。", romaji: "응, 타분. 쟈-, 잇테키마스.", translation: "응, 아마도. 그럼, 다녀올게.", isUserLine: true),
            ConversationData(speaker: "가족", text: "行ってらっしゃい。鍵は持った？", romaji: "잇테랏샤이. 카기와 못타?", translation: "다녀와. 열쇠는 챙겼어?", isUserLine: false)
        ],
        364: [ // 외출하는 사람에게 하는 인사 (出かける人への挨拶)
            ConversationData(speaker: "나", text: "じゃあ、学校に行ってきます。", romaji: "쟈-, 각코-니 잇테키마스.", translation: "그럼, 학교 다녀오겠습니다.", isUserLine: true),
            ConversationData(speaker: "나", text: "はい、行ってらっしゃい。車に気をつけてね。", romaji: "하이, 잇테랏샤이. 쿠루마니 키오츠케테네.", translation: "그래, 다녀오렴. 차 조심하고.", isUserLine: true),
            ConversationData(speaker: "나", text: "はーい！", romaji: "하-이!", translation: "네~!", isUserLine: true)
        ],
        365: [ // 일을 마쳤을 때의 인사 (仕事が終わった時の挨拶)
            ConversationData(speaker: "사토", text: "ふう、今日の仕事はこれで全部終わりですね。", romaji: "후우, 쿄-노 시고토와 코레데 젠부 오와리데스네.", translation: "휴, 오늘 일은 이걸로 전부 끝났네요.", isUserLine: false),
            ConversationData(speaker: "나", text: "はい、お疲れ様でした。", romaji: "하이, 오츠카레사마데시타.", translation: "네, 수고하셨습니다.", isUserLine: true),
            ConversationData(speaker: "사토", text: "お疲れ様でした。では、また明日。", romaji: "오츠카레사마데시타. 데와, 마타 아시타.", translation: "수고하셨습니다. 그럼, 내일 봬요.", isUserLine: false)
        ]
    ]
}