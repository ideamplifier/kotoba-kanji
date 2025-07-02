//

//  JapanesePhrase.swift
//  kotoba_kanji
//
//  Created by EUIHYUNG JUNG on 6/26/25.
//

import Foundation
import SwiftData

@Model
final class JapanesePhrase: Identifiable {
    var id: Int
    var japaneseSentence: String
    var hiragana: String
    var koreanSentence: String
    var romaji: String
    var koreanPronunciation: String
    var grammar: String
    var isFavorite: Bool = false
    var category: String = "기본회화"
    
    init(id: Int, japaneseSentence: String, hiragana: String, koreanSentence: String, romaji: String, koreanPronunciation: String, grammar: String) {
        self.id = id
        self.japaneseSentence = japaneseSentence
        self.hiragana = hiragana
        self.koreanSentence = koreanSentence
        self.romaji = romaji
        self.koreanPronunciation = koreanPronunciation
        self.grammar = grammar
    }
}

// 초기 데이터 생성 함수
extension JapanesePhrase {
    static func createInitialData() -> [JapanesePhrase] {
        return [
            JapanesePhrase(
                id: 1,
                japaneseSentence: "おはようございます",
                hiragana: "おはようございます",
                koreanSentence: "좋은 아침입니다. / 안녕하세요.",
                romaji: "Ohayō gozaimasu",
                koreanPronunciation: "오하요-고자이마스",
                grammar: "아침에 사용하는 가장 일반적인 정중한 인사말입니다. 형용사 早い(はやい)(이르다)에서 유래했으며, ございます가 붙어 정중함을 나타냅니다. 친구나 가족에게는 おはよう라고 짧게 말합니다."
            ),
            JapanesePhrase(
                id: 2,
                japaneseSentence: "こんにちは",
                hiragana: "こんにちは",
                koreanSentence: "안녕하세요.",
                romaji: "Konnichiwa",
                koreanPronunciation: "곤니치와",
                grammar: "낮 시간에 사용하는 가장 일반적인 인사말입니다. 원래 今日(こんにち)는ご機嫌いかがですか(오늘은 기분이 어떠신가요?)라는 문장에서 앞부분만 남아 굳어진 표현입니다. 조사 は는 'wa'로 발음됩니다."
            ),
            JapanesePhrase(
                id: 3,
                japaneseSentence: "ありがとうございます",
                hiragana: "ありがとうございます",
                koreanSentence: "감사합니다. / 고맙습니다.",
                romaji: "Arigatō gozaimasu",
                koreanPronunciation: "아리가토-고자이마스",
                grammar: "감사를 표현하는 가장 표준적인 정중체입니다. 과거의 일에 대한 감사라면 ありがとうございました(아리가토-고자이마시타)라고 표현합니다."
            ),
            JapanesePhrase(
                id: 4,
                japaneseSentence: "すみません",
                hiragana: "すみません",
                koreanSentence: "실례합니다. / 죄송합니다. / 저기요.",
                romaji: "Sumimasen",
                koreanPronunciation: "스미마셍",
                grammar: "가벼운 사과, 누군가를 부를 때, 감사를 표할 때(신세를 졌네요) 등 다양한 상황에서 쓰이는 매우 중요한 만능 표현입니다. 마음이 편치 않다는 뉘앙스를 가집니다."
            ),
            JapanesePhrase(
                id: 5,
                japaneseSentence: "お願いします",
                hiragana: "おねがいします",
                koreanSentence: "부탁합니다. / ~으로 주세요.",
                romaji: "Onegai shimasu",
                koreanPronunciation: "오네가이시마스",
                grammar: "무언가를 요청하거나 부탁할 때 사용합니다. 동사 願う(ねがう)(바라다)의 명사형 お願い에 します(합니다)가 붙은 형태입니다. 가게에서 물건을 가리키며 これ、お願いします라고 하면 '이걸로 주세요'라는 뜻이 됩니다."
            ),
            JapanesePhrase(
                id: 6,
                japaneseSentence: "いくらですか",
                hiragana: "いくらですか",
                koreanSentence: "얼마예요?",
                romaji: "Ikura desu ka?",
                koreanPronunciation: "이쿠라데스카?",
                grammar: "가격을 묻는 가장 기본적인 표현입니다. いくら는 '얼마'라는 뜻의 의문사이며, 문장 끝의 か는 의문을 나타냅니다. 보통 これはいくらですか？(이건 얼마예요?) 형태로 많이 사용됩니다."
            ),
            JapanesePhrase(
                id: 7,
                japaneseSentence: "トイレはどこですか",
                hiragana: "トイレはどこですか",
                koreanSentence: "화장실은 어디예요?",
                romaji: "Toire wa doko desu ka?",
                koreanPronunciation: "토이레와 도코데스카?",
                grammar: "장소나 사물의 위치를 물을 때 사용하는 [명사] + はどこですか？ 패턴입니다. どこ는 '어디'라는 뜻의 의문사입니다. (예: 駅(えき)はどこですか？ - 역은 어디예요?)"
            ),
            JapanesePhrase(
                id: 8,
                japaneseSentence: "大丈夫です",
                hiragana: "だいじょうぶです",
                koreanSentence: "괜찮아요.",
                romaji: "Daijōbu desu",
                koreanPronunciation: "다이죠-부데스",
                grammar: "'괜찮다'는 뜻의 大丈夫(だいじょうぶ)를 사용한 표현입니다. 상대방이 걱정해줄 때 '문제없어요'라는 긍정의 의미와, 무언가를 권유받았을 때 '사양할게요'라는 거절의 의미 두 가지로 모두 쓰일 수 있어 상황에 맞는 이해가 필요합니다."
            ),
            JapanesePhrase(
                id: 9,
                japaneseSentence: "分かりました",
                hiragana: "わかりました",
                koreanSentence: "알겠습니다. / 이해했습니다.",
                romaji: "Wakarimashita",
                koreanPronunciation: "와카리마시타",
                grammar: "分かる(わかる)(알다, 이해하다) 동사의 정중 과거형입니다. 상대방의 말을 듣고 이해했음을 나타내는 긍정의 대답으로 매우 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 10,
                japaneseSentence: "はじめまして",
                hiragana: "はじめまして",
                koreanSentence: "처음 뵙겠습니다.",
                romaji: "Hajimemashite",
                koreanPronunciation: "하지메마시테",
                grammar: "누군가를 처음 만났을 때 사용하는 고정된 인사말입니다. 始める(はじめる)(시작하다)라는 동사에서 파생되었으며, 보통 자기소개 바로 전에 말합니다."
            ),
            JapanesePhrase(
                id: 11,
                japaneseSentence: "どういたしまして",
                hiragana: "どういたしまして",
                koreanSentence: "천만에요. / 별말씀을요.",
                romaji: "Dōitashimashite",
                koreanPronunciation: "도-이타시마시테",
                grammar: "ありがとうございます(감사합니다)에 대한 가장 정중하고 표준적인 답변입니다. '제가 무엇을 했다고 이러십니까'라는 겸손의 의미가 담겨 있습니다."
            ),
            JapanesePhrase(
                id: 12,
                japaneseSentence: "ごめんなさい",
                hiragana: "ごめんなさい",
                koreanSentence: "미안해요.",
                romaji: "Gomennasai",
                koreanPronunciation: "고멘나사이",
                grammar: "すみません보다 조금 더 개인적이고 감정적인 사과의 표현입니다. ごめん(용서) + なさい(가벼운 명령/권유)의 형태로, 주로 가까운 사이에서 사용하며 비즈니스 상황에서는 잘 쓰지 않습니다."
            ),
            JapanesePhrase(
                id: 13,
                japaneseSentence: "いらっしゃいませ",
                hiragana: "いらっしゃいませ",
                koreanSentence: "어서 오세요.",
                romaji: "Irasshaimase",
                koreanPronunciation: "이랏샤이마세",
                grammar: "가게나 식당 등에서 손님을 맞이할 때 사용하는 고정된 인사말입니다. '오다'의 최고 존경어인 いらっしゃる에서 온 표현으로, 극진한 환영의 뜻을 담고 있습니다."
            ),
            JapanesePhrase(
                id: 14,
                japaneseSentence: "いただきます",
                hiragana: "いただきます",
                koreanSentence: "잘 먹겠습니다.",
                romaji: "Itadakimasu",
                koreanPronunciation: "이타다키마스",
                grammar: "식사 시작 전에 하는 고정된 인사말입니다. '받다'의 겸양어 いただく에서 왔으며, 음식이 된 생명과 만들어준 사람 모두에게 감사하며 '생명을 잘 받겠습니다'라는 깊은 뜻을 지닌 일본의 중요한 문화입니다."
            ),
            JapanesePhrase(
                id: 15,
                japaneseSentence: "ごちそうさまでした",
                hiragana: "ごちそうさまでした",
                koreanSentence: "잘 먹었습니다.",
                romaji: "Gochisōsama deshita",
                koreanPronunciation: "고치소-사마데시타",
                grammar: "식사를 마친 후에 하는 고정된 인사말입니다. ご馳走(ちそう)는 '진수성찬'이라는 뜻으로, 맛있는 음식을 대접받았음에 대한 감사를 표현합니다."
            ),
            JapanesePhrase(
                id: 16,
                japaneseSentence: "分かりません",
                hiragana: "わかりません",
                koreanSentence: "모르겠습니다. / 이해가 안 돼요.",
                romaji: "Wakarimasen",
                koreanPronunciation: "와카리마셍",
                grammar: "分かる(알다) 동사의 정중 부정형입니다. 상대방의 말이나 내용을 이해하지 못했을 때 사용합니다. 分かりました(알겠습니다)의 반대 표현입니다."
            ),
            JapanesePhrase(
                id: 17,
                japaneseSentence: "もう一度お願いします",
                hiragana: "もういちどおねがいします",
                koreanSentence: "한 번 더 부탁합니다.",
                romaji: "Mō ichido onegai shimasu",
                koreanPronunciation: "모- 이치도 오네가이시마스",
                grammar: "もう(더, 또) + 一度(いちど)(한 번) + お願いします(부탁합니다)의 조합입니다. 상대방의 말을 잘 못 들었거나 다시 한번 듣고 싶을 때 사용하는 매우 정중하고 유용한 표현입니다."
            ),
            JapanesePhrase(
                id: 18,
                japaneseSentence: "ゆっくりお願いします",
                hiragana: "ゆっくりおねがいします",
                koreanSentence: "천천히 부탁합니다.",
                romaji: "Yukkuri onegai shimasu",
                koreanPronunciation: "육쿠리 오네가이시마스",
                grammar: "상대방의 말이 너무 빠를 때 속도를 늦춰달라고 요청하는 표현입니다. ゆっくり는 '천천히, 푹'이라는 뜻의 부사입니다. (예: ゆっくり話してください - 천천히 말해주세요)"
            ),
            JapanesePhrase(
                id: 19,
                japaneseSentence: "お疲れ様です",
                hiragana: "おつかれさまです",
                koreanSentence: "수고하십니다. / 수고하셨습니다.",
                romaji: "Otsukaresama desu",
                koreanPronunciation: "오츠카레사마데스",
                grammar: "お+疲れ(피로)+様(님)의 조합으로, 상대의 노고를 위로하고 인정하는 일본 특유의 인사말입니다. 만났을 때, 헤어질 때, 업무 중에 언제든 사용할 수 있는 만능 표현입니다."
            ),
            JapanesePhrase(
                id: 20,
                japaneseSentence: "失礼します",
                hiragana: "しつれいします",
                koreanSentence: "실례하겠습니다. / 먼저 들어가 보겠습니다.",
                romaji: "Shitsurei shimasu",
                koreanPronunciation: "시츠레-시마스",
                grammar: "失礼(しつれい)(실례) + します(합니다)의 형태입니다. 다른 사람의 공간에 들어가거나 나올 때, 먼저 자리를 뜰 때, 전화를 끊을 때 등 다양한 상황에서 '예의에 어긋나는 행동을 하겠습니다'라는 겸손의 의미로 사용됩니다."
            ),
            JapanesePhrase(
                id: 21,
                japaneseSentence: "お名前は何ですか",
                hiragana: "おなまえはなんですか",
                koreanSentence: "성함(이름)이 어떻게 되세요?",
                romaji: "O-namae wa nan desu ka?",
                koreanPronunciation: "오나마에와 난데스카?",
                grammar: "상대방의 이름을 정중하게 물을 때 사용하는 표준 질문입니다. 名前(なまえ)(이름) 앞에 존경의 접두어 お를 붙여 예의를 갖춥니다. 何(なん)은 '무엇'을 의미합니다."
            ),
            JapanesePhrase(
                id: 22,
                japaneseSentence: "韓国から来ました",
                hiragana: "かんこくからきました",
                koreanSentence: "한국에서 왔어요.",
                romaji: "Kankoku kara kimashita",
                koreanPronunciation: "칸코쿠카라 키마시타",
                grammar: "출신 국가나 지역을 밝힐 때 사용하는 표현입니다. ~から는 '~로부터, ~에서'라는 출처를 나타내는 조사이며, 来ました(きました)는 '오다'라는 동사 来る(くる)의 정중체 과거형입니다."
            ),
            JapanesePhrase(
                id: 23,
                japaneseSentence: "趣味は何ですか",
                hiragana: "しゅみはなんですか",
                koreanSentence: "취미가 무엇인가요?",
                romaji: "Shumi wa nan desu ka?",
                koreanPronunciation: "슈미와 난데스카?",
                grammar: "상대방과 가벼운 대화를 시작할 때 사용하기 좋은 질문입니다. 趣味(しゅみ)는 '취미'라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 24,
                japaneseSentence: "おすすめは何ですか",
                hiragana: "おすすめはなんですか",
                koreanSentence: "추천 메뉴(상품)는 무엇인가요?",
                romaji: "Osusume wa nan desu ka?",
                koreanPronunciation: "오스스메와 난데스카?",
                grammar: "식당이나 가게에서 추천을 받고 싶을 때 사용하는 매우 유용한 표현입니다. おすすめ는 '추천'이라는 뜻의 명사로, 동사 勧める(すすめる)(권하다)에서 왔습니다."
            ),
            JapanesePhrase(
                id: 25,
                japaneseSentence: "お会計お願いします",
                hiragana: "おかいけいおねがいします",
                koreanSentence: "계산 부탁합니다.",
                romaji: "O-kaikei onegai shimasu",
                koreanPronunciation: "오카이케- 오네가이시마스",
                grammar: "식당 등에서 식사를 마친 후 계산을 요청할 때 쓰는 표현입니다. 会計(かいけい)는 '회계, 계산'이라는 뜻이며, 앞에 お를 붙여 정중하게 말합니다."
            ),
            JapanesePhrase(
                id: 26,
                japaneseSentence: "カードで払えますか",
                hiragana: "カードではらえますか",
                koreanSentence: "카드로 계산할 수 있나요?",
                romaji: "Kādo de haraemasu ka?",
                koreanPronunciation: "카-도데 하라에마스카?",
                grammar: "カード(카드) + で(수단을 나타내는 조사) + 払えますか？(지불할 수 있나요?)의 구조입니다. 払えますか는 '지불하다'는 동사 払う(はらう)의 가능형 의문입니다."
            ),
            JapanesePhrase(
                id: 27,
                japaneseSentence: "写真を撮ってもいいですか",
                hiragana: "しゃしんをとってもいいですか",
                koreanSentence: "사진을 찍어도 되나요?",
                romaji: "Shashin o totte mo ii desu ka?",
                koreanPronunciation: "샤신오 톳테모 이-데스카?",
                grammar: "동사의 て형 + もいいですか？는 '~해도 괜찮을까요?'라고 상대방에게 허락을 구할 때 쓰는 중요한 문법입니다. 写真(しゃしん)を撮る(とる)는 '사진을 찍다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 28,
                japaneseSentence: "楽しかったです",
                hiragana: "たのしかったです",
                koreanSentence: "즐거웠어요.",
                romaji: "Tanoshikatta desu",
                koreanPronunciation: "타노시캇타데스",
                grammar: "'즐겁다'는 い형용사 楽しい(たのしい)의 과거형입니다. 어미 い를 かった로 바꿔 과거를 나타냅니다. 여행이나 행사 등이 끝난 후 감상을 말할 때 자주 사용합니다."
            ),
            JapanesePhrase(
                id: 29,
                japaneseSentence: "気をつけてください",
                hiragana: "きをつけてください",
                koreanSentence: "조심하세요. / 잘 가요.",
                romaji: "Ki o tsukete kudasai",
                koreanPronunciation: "키오 츠케테 쿠다사이",
                grammar: "気をつける(조심하다)라는 관용구의 て형 + ください 형태입니다. 헤어질 때 '조심해서 가세요'라는 인사말로도, 위험한 상황에서 '조심하세요'라는 경고로도 쓰입니다."
            ),
            JapanesePhrase(
                id: 30,
                japaneseSentence: "大変ですね",
                hiragana: "たいへんですね",
                koreanSentence: "힘드시겠네요. / 고생이 많으시네요.",
                romaji: "Taihen desu ne",
                koreanPronunciation: "타이헨데스네",
                grammar: "상대방의 어려운 상황에 대해 공감과 위로를 표현하는 말입니다. 大変(たいへん)은 '힘듦, 고생스러움'을 나타내는 な형용사이며, ね를 붙여 부드러운 공감의 뉘앙스를 더합니다."
            ),
            JapanesePhrase(
                id: 31,
                japaneseSentence: "どうしましたか",
                hiragana: "どうしましたか",
                koreanSentence: "무슨 일이에요? / 왜 그러세요?",
                romaji: "Dō shimashita ka?",
                koreanPronunciation: "도-시마시타카?",
                grammar: "상대방의 표정이 안 좋거나, 곤란해 보일 때 무슨 일이 있는지 묻는 표현입니다. どう(어떻게) + しましたか(했습니까?)의 형태로 '어떻게 되신 건가요?'라는 걱정의 뉘앙스가 담겨 있습니다."
            ),
            JapanesePhrase(
                id: 32,
                japaneseSentence: "大丈夫ですか",
                hiragana: "だいじょうぶですか",
                koreanSentence: "괜찮으세요?",
                romaji: "Daijōbu desu ka?",
                koreanPronunciation: "다이죠-부데스카?",
                grammar: "31번 どうしましたか？와 함께 상대방의 안부를 묻는 필수 표현입니다. 大丈夫です(괜찮아요)의 의문형으로, 상대가 넘어졌거나 아파 보일 때 등 걱정되는 상황에 사용합니다."
            ),
            JapanesePhrase(
                id: 33,
                japaneseSentence: "お腹がすきました",
                hiragana: "おなかがすきました",
                koreanSentence: "배고파요.",
                romaji: "O-naka ga sukimashita",
                koreanPronunciation: "오나카가 스키마시타",
                grammar: "'배가 고프다'는 お腹(なか)がすく라는 관용구입니다. 배가 고픈 상태가 되었음을 나타내기 때문에 보통 과거형 すきました나 상태를 나타내는 すいています를 사용합니다."
            ),
            JapanesePhrase(
                id: 34,
                japaneseSentence: "喉が渇きました",
                hiragana: "のどがかわきました",
                koreanSentence: "목말라요.",
                romaji: "Nodo ga kawakimashita",
                koreanPronunciation: "노도가 카와키마시타",
                grammar: "'목이 마르다'는 喉(のど)が渇く(かわく)라는 관용구입니다. 목이 마른 상태가 되었음을 나타내며, 33번과 마찬가지로 보통 과거형 渇きました나 상태를 나타내는 渇いています를 씁니다."
            ),
            JapanesePhrase(
                id: 35,
                japaneseSentence: "楽しみにしています",
                hiragana: "たのしみにしています",
                koreanSentence: "기대하고 있어요.",
                romaji: "Tanoshimi ni shite imasu",
                koreanPronunciation: "타노시미니 시테이마스",
                grammar: "楽しみ(즐거움, 기대) + にしています의 형태로, 미래의 약속이나 이벤트에 대한 기대감을 표현하는 말입니다. -て います는 '~하고 있다'는 현재 진행/상태를 나타냅니다."
            ),
            JapanesePhrase(
                id: 36,
                japaneseSentence: "お先に失礼します",
                hiragana: "おさきにしつれいします",
                koreanSentence: "먼저 실례하겠습니다.",
                romaji: "O-saki ni shitsurei shimasu",
                koreanPronunciation: "오사키니 시츠레-시마스",
                grammar: "お先に(먼저) + 失礼します(실례하겠습니다)의 조합입니다. 직장이나 모임에서 다른 사람들보다 먼저 자리를 떠날 때 사용하는 필수 인사말로, 남은 사람들에게 양해를 구하는 표현입니다."
            ),
            JapanesePhrase(
                id: 37,
                japaneseSentence: "猫が好きです",
                hiragana: "ねこがすきです",
                koreanSentence: "고양이를 좋아해요.",
                romaji: "Neko ga suki desu",
                koreanPronunciation: "네코가 스키데스",
                grammar: "좋아하는 대상을 말할 때 [대상] + が好きです 패턴을 사용합니다. 목적격 조사 を가 아니라 주격 조사 が를 쓰는 것이 특징입니다. 好き(すき)는 '좋아함'을 나타냅니다."
            ),
            JapanesePhrase(
                id: 38,
                japaneseSentence: "ピーマンが嫌いです",
                hiragana: "ピーマンがきらいです",
                koreanSentence: "피망을 싫어해요.",
                romaji: "Pīman ga kirai desu",
                koreanPronunciation: "피-망가 키라이데스",
                grammar: "싫어하는 대상을 말할 때 [대상] + が嫌いです 패턴을 사용합니다. 好きです와 마찬가지로 조사 が를 사용합니다. 嫌い(きらい)는 '싫어함'을 나타냅니다."
            ),
            JapanesePhrase(
                id: 39,
                japaneseSentence: "日本語が上手ですね",
                hiragana: "にほんごがじょうずですね",
                koreanSentence: "일본어를 잘하시네요!",
                romaji: "Nihongo ga jōzu desu ne",
                koreanPronunciation: "니혼고가 죠-즈데스네",
                grammar: "상대방의 능력을 칭찬할 때 사용합니다. 上手(じょうず)는 '능숙함, 잘함'을 뜻하는 な형용사입니다. 보통 [기술/능력] + が上手ですね 형태로 사용됩니다."
            ),
            JapanesePhrase(
                id: 40,
                japaneseSentence: "すごいですね",
                hiragana: "すごいですね",
                koreanSentence: "대단하네요! / 굉장하네요!",
                romaji: "Sugoi desu ne!",
                koreanPronunciation: "스고이데스네!",
                grammar: "상대방의 능력, 이야기, 혹은 눈앞의 광경 등 인상 깊은 무언가에 감탄할 때 쓰는 폭넓은 칭찬 표현입니다. 긍정적인 반응을 보일 때 매우 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 41,
                japaneseSentence: "どう思いますか",
                hiragana: "どうおもいますか",
                koreanSentence: "어떻게 생각해요?",
                romaji: "Dō omoimasu ka?",
                koreanPronunciation: "도- 오모이마스카?",
                grammar: "상대방의 의견을 물을 때 쓰는 정중하고 일반적인 표현입니다. どう는 '어떻게', 思いますか(おもいますか)는 '생각하다'라는 동사 思う(おもう)의 정중 의문형입니다."
            ),
            JapanesePhrase(
                id: 42,
                japaneseSentence: "私もそう思います",
                hiragana: "わたしもそうおもいます",
                koreanSentence: "저도 그렇게 생각해요.",
                romaji: "Watashi mo sō omoimasu",
                koreanPronunciation: "와타시모 소- 오모이마스",
                grammar: "상대방의 의견에 동의를 표하는 말입니다. 私(わたし)も는 '나도', そう는 '그렇게'라는 뜻으로, \"나도 그렇게 생각합니다\"라는 의미의 간결한 동의 표현입니다."
            ),
            JapanesePhrase(
                id: 43,
                japaneseSentence: "どうしてですか",
                hiragana: "どうしてですか",
                koreanSentence: "왜요? / 어째서요?",
                romaji: "Dōshite desu ka?",
                koreanPronunciation: "도-시테데스카?",
                grammar: "이유를 묻는 가장 일반적인 구어체 질문입니다. なぜですか(나제데스카)보다 좀 더 부드럽고 일상적인 대화에서 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 44,
                japaneseSentence: "なるほど",
                hiragana: "なるほど",
                koreanSentence: "그렇군요. / 과연.",
                romaji: "Naruhodo",
                koreanPronunciation: "나루호도",
                grammar: "상대방의 설명을 듣고 몰랐던 사실을 이해하거나 납득했을 때 사용하는 맞장구 표현입니다. '아, 그래서 그랬군요' 와 같은 깨달음의 뉘앙스를 담고 있어 대화를 자연스럽게 이어줍니다."
            ),
            JapanesePhrase(
                id: 45,
                japaneseSentence: "おめでとうございます",
                hiragana: "おめでとうございます",
                koreanSentence: "축하합니다.",
                romaji: "Omedetō gozaimasu",
                koreanPronunciation: "오메데토-고자이마스",
                grammar: "생일, 결혼, 합격, 졸업 등 상대방의 기쁜 일을 축하할 때 사용하는 고정된 인사말입니다. 앞에 ご結婚(ごけっこん)(결혼), お誕生日(おたんじょうび)(생일) 등을 붙여 활용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 46,
                japaneseSentence: "うれしいです",
                hiragana: "うれしいです",
                koreanSentence: "기뻐요.",
                romaji: "Ureshii desu",
                koreanPronunciation: "우레시-데스",
                grammar: "선물이나 좋은 소식 등, 외부의 요인으로 인해 느끼는 개인적인 '기쁨'을 표현하는 い형용사입니다. 楽しい(たのしい)가 어떤 활동 자체의 '즐거움'을 나타낸다면, うれしい는 감정적인 '기쁨'에 더 가깝습니다."
            ),
            JapanesePhrase(
                id: 47,
                japaneseSentence: "悲しいです",
                hiragana: "かなしいです",
                koreanSentence: "슬퍼요.",
                romaji: "Kanashii desu",
                koreanPronunciation: "카나시-데스",
                grammar: "'슬프다'는 뜻의 い형용사 悲しい(かなしい)를 사용한 감정 표현입니다. うれしいです(기뻐요)의 반대말로, 슬픈 감정을 나타낼 때 사용합니다."
            ),
            JapanesePhrase(
                id: 48,
                japaneseSentence: "お腹がいっぱいです",
                hiragana: "おなかがいっぱいです",
                koreanSentence: "배불러요.",
                romaji: "O-naka ga ippai desu",
                koreanPronunciation: "오나카가 입빠이데스",
                grammar: "お腹(なか)(배) + が + いっぱい(가득)의 구조입니다. お腹がすきました(배고파요)의 반대 표현으로, 식사 후 배가 부른 상태를 나타냅니다."
            ),
            JapanesePhrase(
                id: 49,
                japaneseSentence: "もちろん、いいですよ",
                hiragana: "もちろん、いいですよ",
                koreanSentence: "물론, 괜찮아요.",
                romaji: "Mochiron, ii desu yo",
                koreanPronunciation: "모치론, 이-데스요",
                grammar: "상대방의 요청이나 질문에 대해 흔쾌히 수락할 때 사용하는 표현입니다. もちろん은 '물론', いいです는 '좋아요/괜찮아요'라는 뜻입니다. 문장 끝의 よ는 상대방에게 정보를 확인시켜 주는 느낌을 더해줍니다."
            ),
            JapanesePhrase(
                id: 50,
                japaneseSentence: "一緒に行きませんか",
                hiragana: "いっしょにいきませんか",
                koreanSentence: "같이 가지 않을래요?",
                romaji: "Issho ni ikimasen ka?",
                koreanPronunciation: "잇쇼니 이키마셍카?",
                grammar: "동사의 ます형 + ませんか？는 '~하지 않겠습니까?'라고 부드럽게 권유하거나 제안하는 중요한 패턴입니다. 一緒(いっしょ)に는 '함께, 같이'라는 뜻의 부사입니다."
            ),
            JapanesePhrase(
                id: 51,
                japaneseSentence: "ちょっといいですか",
                hiragana: "ちょっといいですか",
                koreanSentence: "잠깐 괜찮으세요? / 잠시 시간 있으세요?",
                romaji: "Chotto ii desu ka?",
                koreanPronunciation: "춋토 이-데스카?",
                grammar: "다른 사람에게 말을 걸거나 무언가를 부탁하기 전에 사용하는, 매우 정중하고 배려 깊은 표현입니다. ちょっと(잠깐) + いいですか(괜찮습니까?)의 형태로, 상대방의 시간을 뺏어도 괜찮은지 물어보는 뉘앙스입니다."
            ),
            JapanesePhrase(
                id: 52,
                japaneseSentence: "お待たせしました",
                hiragana: "おまたせしました",
                koreanSentence: "오래 기다리셨습니다. / 기다리게 해서 죄송합니다.",
                romaji: "Omatase shimashita",
                koreanPronunciation: "오마타세시마시타",
                grammar: "누군가를 기다리게 한 후에 사용하는 정중한 사과 표현입니다. 待たせる(기다리게 하다)라는 동사에서 온 말로, 식당 종업원이나 약속 상대 등 다양한 상황에서 쓰입니다."
            ),
            JapanesePhrase(
                id: 53,
                japaneseSentence: "ゆっくりしていってね。",
                hiragana: "おそくなってすみません",
                koreanSentence: "늦어서 죄송합니다.",
                romaji: "Osoku natte sumimasen",
                koreanPronunciation: "오소쿠낫테 스미마셍",
                grammar: "遅い(늦다)라는 형용사가 遅くなる(늦어지다)로 동사화되고, -て 형태로 연결되어 '늦어져서'라는 이유를 나타냅니다. 약속 시간에 늦었을 때 사용하는 가장 직접적인 사과 표현입니다."
            ),
            JapanesePhrase(
                id: 54,
                japaneseSentence: "それは本当ですか？",
                hiragana: "がんばってください",
                koreanSentence: "힘내세요! / 열심히 하세요!",
                romaji: "Ganbatte kudasai",
                koreanPronunciation: "감밧테 쿠다사이",
                grammar: "상대방을 응원할 때 쓰는 말입니다. '최선을 다하다, 힘내다'라는 동사 頑張る(がんばる)의 て형 + ください형태로, '~해주세요'라는 요청보다는 '힘내세요'라는 격려의 의미로 굳어진 표현입니다."
            ),
            JapanesePhrase(
                id: 55,
                japaneseSentence: "信じられません！",
                hiragana: "たすけてください",
                koreanSentence: "도와주세요!",
                romaji: "Tasukete kudasai",
                koreanPronunciation: "타스케테 쿠다사이",
                grammar: "위급하거나 곤란한 상황에서 도움을 요청하는 표현입니다. 助ける(たすける)는 '돕다, 구하다'라는 뜻의 동사입니다. 일상적인 작은 부탁보다는 좀 더 절실한 상황에서 사용됩니다."
            ),
            JapanesePhrase(
                id: 56,
                japaneseSentence: "また来ます",
                hiragana: "またきます",
                koreanSentence: "다음에 또 올게요.",
                romaji: "Mata kimasu",
                koreanPronunciation: "마타 키마스",
                grammar: "가게 등에서 물건을 바로 사지 않고 나올 때, '다음에 다시 방문하겠습니다'라고 여지를 남기는 부드러운 표현입니다. また는 '또, 다시', 来ます(きます)는 '오겠습니다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 57,
                japaneseSentence: "ごゆっくりどうぞ",
                hiragana: "ごゆっくりどうぞ",
                koreanSentence: "편히 계세요. / 천천히 하세요.",
                romaji: "Go-yukkuri dōzo",
                koreanPronunciation: "고윳쿠리 도-조",
                grammar: "ゆっくり(천천히, 푹)에 정중함을 더하는 ご를 붙인 형태입니다. 손님에게 '편히 계세요'라고 하거나, 식당에서 손님에게 '천천히 드세요'라고 하는 등 상대방이 여유를 갖도록 배려하는 따뜻한 표현입니다."
            ),
            JapanesePhrase(
                id: 58,
                japaneseSentence: "こちらこそ",
                hiragana: "こちらこそ",
                koreanSentence: "저야말로요.",
                romaji: "Kochira koso",
                koreanPronunciation: "코치라코소",
                grammar: "상대방의 감사나 인사에 대해 '저야말로 그렇습니다'라고 겸손하게 화답하는 표현입니다. こちら(이쪽) + こそ(이야말로)의 형태로, よろしくお願いします나 ありがとうございます에 대한 답변으로 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 59,
                japaneseSentence: "予約をお願いします",
                hiragana: "よやくをおねがいします",
                koreanSentence: "예약을 부탁합니다.",
                romaji: "Yoyaku o onegai shimasu",
                koreanPronunciation: "요야쿠오 오네가이시마스",
                grammar: "식당, 호텔, 병원 등을 이용하기 위해 예약을 하고 싶을 때 사용하는 정중한 표현입니다. 予約(よやく)는 '예약'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 60,
                japaneseSentence: "どのくらいかかりますか",
                hiragana: "どのくらいかかりますか",
                koreanSentence: "어느 정도 걸려요? (시간/비용)",
                romaji: "Dono kurai kakarimasu ka?",
                koreanPronunciation: "도노쿠라이 카카리마스카?",
                grammar: "시간이나 비용이 얼마나 드는지 물을 때 사용하는 필수 질문입니다. どのくらい는 '어느 정도'라는 뜻의 의문사이며, 동사 かかります는 '걸리다, 들다'라는 의미를 가집니다."
            ),
            JapanesePhrase(
                id: 61,
                japaneseSentence: "これでいいですか？",
                hiragana: "これでいいですか？",
                koreanSentence: "이걸로 괜찮을까요? / 이걸로 될까요?",
                romaji: "Kore de ii desu ka?",
                koreanPronunciation: "코레데 이-데스카?",
                grammar: "これ(이것) + で(수단을 나타내는 조사) + いいですか(괜찮습니까?)의 구조입니다. 물건을 고르거나, 서류를 제출하는 등 어떤 것을 선택하고 상대방의 확인이나 동의를 구할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 62,
                japaneseSentence: "たぶん大丈夫です。",
                hiragana: "たぶん大丈夫です",
                koreanSentence: "아마 괜찮을 거예요.",
                romaji: "Tabun daijōbu desu",
                koreanPronunciation: "타분 다이죠-부데스",
                grammar: "100% 확신은 없지만 그럴 가능성이 높다고 생각할 때 사용하는 표현입니다. たぶん은 '아마도'라는 뜻의 부사로, 추측의 뉘앙스를 더해줍니다."
            ),
            JapanesePhrase(
                id: 63,
                japaneseSentence: "試着してもいいですか？",
                hiragana: "しちゃくしてもいいですか？",
                koreanSentence: "입어봐도 될까요?",
                romaji: "Shichaku shite mo ii desu ka?",
                koreanPronunciation: "시차쿠시테모 이-데스카?",
                grammar: "옷 가게에서 사용하는 필수 표현입니다. 試着(しちゃく)する는 '입어보다'라는 뜻의 동사이며, 동사의 て형 + もいいですか？(~해도 괜찮을까요?) 패턴을 사용해 점원에게 허락을 구합니다."
            ),
            JapanesePhrase(
                id: 64,
                japaneseSentence: "他の色はありませんか？",
                hiragana: "ほかのいろはありませんか？",
                koreanSentence: "다른 색은 없나요?",
                romaji: "Hoka no iro wa arimasen ka?",
                koreanPronunciation: "호카노 이로와 아리마셍카?",
                grammar: "마음에 드는 상품의 다른 버전을 찾을 때 사용합니다. 他の(ほかの)는 '다른', 色(いろ)는 '색'이라는 뜻입니다. ありませんか는 '없습니까?'라는 정중한 질문입니다."
            ),
            JapanesePhrase(
                id: 65,
                japaneseSentence: "結構です。",
                hiragana: "けっこうです",
                koreanSentence: "괜찮습니다. (사양합니다)",
                romaji: "Kekkō desu",
                koreanPronunciation: "켓코-데스",
                grammar: "상대방의 제안이나 권유를 정중하게 거절할 때 사용하는 표현입니다. '충분합니다, 더는 필요 없습니다'라는 뉘앙스를 가집니다. いいです가 긍정과 부정의 의미를 모두 가질 수 있는 반면, 結構です는 거절의 의미가 더 명확합니다."
            ),
            JapanesePhrase(
                id: 66,
                japaneseSentence: "一番近い駅はどこですか？",
                hiragana: "いちばんちかいえきはどこですか？",
                koreanSentence: "가장 가까운 역은 어디인가요?",
                romaji: "Ichiban chikai eki wa doko desu ka?",
                koreanPronunciation: "이치반 치카이 에키와 도코데스카?",
                grammar: "一番(いちばん)은 '가장, 제일'이라는 뜻으로 최상급을 만드는 부사입니다. 형용사 近い(ちかい)(가까운)와 함께 쓰여 '가장 가까운'이라는 의미를 만듭니다. 길을 찾을 때 매우 유용합니다."
            ),
            JapanesePhrase(
                id: 67,
                japaneseSentence: "これは誰の傘ですか？",
                hiragana: "これはだれのかさですか？",
                koreanSentence: "이건 누구의 우산이에요?",
                romaji: "Kore wa dare no kasa desu ka?",
                koreanPronunciation: "코레와 다레노 카사데스카?",
                grammar: "誰(だれ)(누구) + 조사 の가 합쳐져 '누구의'라는 소유를 묻는 표현이 됩니다. 傘(かさ)는 '우산'이라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 68,
                japaneseSentence: "間に合いますか？",
                hiragana: "まにあいますか？",
                koreanSentence: "시간에 맞출 수 있을까요?",
                romaji: "Ma ni aimasu ka?",
                koreanPronunciation: "마니아이마스카?",
                grammar: "약속이나 교통수단 출발 시각에 늦지 않을지 물어보는 표현입니다. 間に合う(まにあう)는 '시간에 대다, 맞추다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 69,
                japaneseSentence: "お手洗いはどこですか？",
                hiragana: "おてあらいはどこですか？",
                koreanSentence: "화장실은 어디인가요?",
                romaji: "O-tearai wa doko desu ka?",
                koreanPronunciation: "오테아라이와 도코데스카?",
                grammar: "トイレ(토이레)보다 더 정중하고 격식 있는 표현입니다. 手(て)(손)를 洗う(あらう)(씻다)는 의미에서 온 말로, 특히 공공장소나 격식 있는 자리에서 사용하면 좋은 인상을 줄 수 있습니다."
            ),
            JapanesePhrase(
                id: 70,
                japaneseSentence: "ここで降ろしてください。",
                hiragana: "ここでおろしてください",
                koreanSentence: "여기서 내려주세요.",
                romaji: "Koko de oroshite kudasai",
                koreanPronunciation: "코코데 오로시테 쿠다사이",
                grammar: "택시를 탔을 때 내리고 싶은 장소에서 사용하는 필수 표현입니다. ここで는 '여기서', 降ろして(おろして)ください는 '내리게 하다'는 동사 降ろす(おろす)의 て형 + ください 형태입니다."
            ),
            JapanesePhrase(
                id: 71,
                japaneseSentence: "もしもし。",
                hiragana: "もしもし",
                koreanSentence: "여보세요?",
                romaji: "Moshi moshi",
                koreanPronunciation: "모시모시",
                grammar: "전화 통화에서만 사용하는 고유한 인사말입니다. 전화를 걸 때나 받을 때 모두 사용할 수 있습니다. 대면 상황에서는 사용하지 않습니다."
            ),
            JapanesePhrase(
                id: 72,
                japaneseSentence: "鈴木さんをお願いします。",
                hiragana: "すずきさんをおねがいします",
                koreanSentence: "스즈키 씨 부탁합니다. (스즈키 씨와 통화할 수 있을까요?)",
                romaji: "Suzuki-san o onegai shimasu",
                koreanPronunciation: "스즈키상오 오네가이시마스",
                grammar: "전화로 특정 인물을 바꿔달라고 요청할 때 사용하는 정중하고 표준적인 표현입니다. [이름]さん + をお願いします 형태로 사용합니다."
            ),
            JapanesePhrase(
                id: 73,
                japaneseSentence: "どちら様ですか？",
                hiragana: "どちらさまですか？",
                koreanSentence: "어느 분이십니까?",
                romaji: "Dochira-sama desu ka?",
                koreanPronunciation: "도치라사마데스카?",
                grammar: "誰ですか(누구세요?)보다 훨씬 정중하게 상대방이 누구인지 물어보는 표현입니다. 様(さま)는 さん(씨)보다 높은 극존칭입니다. 전화나 방문객에게 주로 사용합니다."
            ),
            JapanesePhrase(
                id: 74,
                japaneseSentence: "もう一度、書いてください。",
                hiragana: "もういちど、かいてください",
                koreanSentence: "다시 한번, 써주세요.",
                romaji: "Mō ichido, kaite kudasai",
                koreanPronunciation: "모- 이치도, 카이테 쿠다사이",
                grammar: "상대방의 말을 알아듣기 어려울 때, 글로 써달라고 요청하는 유용한 표현입니다. 書く(かく)(쓰다) 동사의 て형 + ください 형태입니다."
            ),
            JapanesePhrase(
                id: 75,
                japaneseSentence: "これは何という花ですか？",
                hiragana: "これはなんというはなですか？",
                koreanSentence: "이것은 뭐라고 하는 꽃인가요?",
                romaji: "Kore wa nan to iu hana desu ka?",
                koreanPronunciation: "코레와 난토 유- 하나데스카?",
                grammar: "사물의 이름을 물을 때 사용하는 패턴입니다. 何(なん)という + [명사] + ですか？ 형태로, '[명사]의 이름이 무엇인가요?'라는 의미입니다. これは何ですか？(이건 뭐예요?)보다 더 구체적인 질문입니다."
            ),
            JapanesePhrase(
                id: 76,
                japaneseSentence: "よく分かりません。",
                hiragana: "よくわかりません",
                koreanSentence: "잘 모르겠어요.",
                romaji: "Yoku wakarimasen",
                koreanPronunciation: "요쿠 와카리마셍",
                grammar: "分かりません(모르겠습니다) 앞에 부사 よく(잘)을 붙여, '완전히 모르는 것은 아니지만, 명확하게는 모르겠다'는 뉘앙스를 주는 부드러운 표현입니다."
            ),
            JapanesePhrase(
                id: 77,
                japaneseSentence: "連絡先を教えてください。",
                hiragana: "れんらくさきをおしえてください",
                koreanSentence: "연락처를 알려주세요.",
                romaji: "Renrakusaki o oshiete kudasai",
                koreanPronunciation: "렌라쿠사키오 오시에테 쿠다사이",
                grammar: "連絡先(れんらくさき)는 '연락처'라는 명사입니다. 教える(おしえる)는 '가르치다' 외에 '알려주다'는 뜻도 있어, 정보를 요청할 때 자주 사용됩니다. て형 + ください 패턴입니다."
            ),
            JapanesePhrase(
                id: 78,
                japaneseSentence: "現金で払います。",
                hiragana: "げんきんではらいます",
                koreanSentence: "현금으로 낼게요.",
                romaji: "Genkin de haraimasu",
                koreanPronunciation: "겐킨데 하라이마스",
                grammar: "現金(げんきん)은 '현금'이라는 뜻입니다. 조사 で는 '수단, 방법'을 나타내어 '현금으로'라는 의미를 만듭니다. 払います(はらいます)는 '지불합니다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 79,
                japaneseSentence: "領収書をください。",
                hiragana: "りょうしゅうしょをください",
                koreanSentence: "영수증 주세요.",
                romaji: "Ryōshūsho o kudasai",
                koreanPronunciation: "료-슈-쇼오 쿠다사이",
                grammar: "領収書(りょうしゅうしょ)는 '영수증'이라는 명사입니다. ~をください는 '~을 주세요'라는 가장 기본적인 요청 표현입니다."
            ),
            JapanesePhrase(
                id: 80,
                japaneseSentence: "そろそろ時間です。",
                hiragana: "そろそろじかんです",
                koreanSentence: "슬슬 시간이네요.",
                romaji: "Sorosoro jikan desu",
                koreanPronunciation: "소로소로 지칸데스",
                grammar: "약속된 시간이 거의 다 되었음을 알릴 때 사용하는 표현입니다. そろそろ는 '슬슬, 이제 곧'이라는 뜻의 부사로, 무언가 시작하거나 끝낼 때가 가까워졌음을 나타냅니다."
            ),
            JapanesePhrase(
                id: 81,
                japaneseSentence: "私がごちそうします。",
                hiragana: "わたしがごちそうします",
                koreanSentence: "제가 대접할게요. / 제가 살게요.",
                romaji: "Watashi ga gochisō shimasu",
                koreanPronunciation: "와타시가 고치소-시마스",
                grammar: "ごちそう는 '진수성찬, 맛있는 음식'이라는 명사지만, します(합니다)를 붙여 '대접하다, 한턱내다'라는 동사로 사용할 수 있습니다. 감사의 표현인 ごちそうさまでした(잘 먹었습니다)와 연관 지어 기억하면 좋습니다."
            ),
            JapanesePhrase(
                id: 82,
                japaneseSentence: "どういう意味ですか？",
                hiragana: "どういういみですか？",
                koreanSentence: "무슨 뜻이에요?",
                romaji: "Dōiu imi desu ka?",
                koreanPronunciation: "도-유- 이미데스카?",
                grammar: "상대방이 사용한 단어나 문장의 뜻을 모를 때, 그 의미를 직접적으로 물어보는 표현입니다. どういう는 '어떤', 意味(いみ)는 '의미, 뜻'을 나타냅니다."
            ),
            JapanesePhrase(
                id: 83,
                japaneseSentence: "東京タワーに行きたいです。",
                hiragana: "とうきょうタワーにいきたいです",
                koreanSentence: "도쿄 타워에 가고 싶어요.",
                romaji: "Tōkyō Tawā ni ikitai desu",
                koreanPronunciation: "토-쿄-타와-니 이키타이데스",
                grammar: "동사의 ます형에서 ます를 빼고 ~たいです를 붙이면 '~하고 싶어요'라는 희망을 나타내는 표현이 됩니다. 行きます(갑니다) -> 行きたいです(가고 싶습니다)."
            ),
            JapanesePhrase(
                id: 84,
                japaneseSentence: "道に迷いました。",
                hiragana: "みちにまよいました",
                koreanSentence: "길을 잃었어요.",
                romaji: "Michi ni mayoimashita",
                koreanPronunciation: "미치니 마요이마시타",
                grammar: "道(みち)는 '길'이라는 뜻입니다. 동사 迷う(まよう)는 '헤매다, 길을 잃다'는 뜻으로, 길을 잃었을 때 경찰이나 행인에게 도움을 요청하기 위해 사용하는 중요한 표현입니다."
            ),
            JapanesePhrase(
                id: 85,
                japaneseSentence: "このバスは新宿に行きますか？",
                hiragana: "このバスはしんじゅくにいきますか？",
                koreanSentence: "이 버스는 신주쿠에 가나요?",
                romaji: "Kono basu wa Shinjuku ni ikimasu ka?",
                koreanPronunciation: "코노 바스와 신주쿠니 이키마스카?",
                grammar: "[교통수단]は[장소]に行きますか？ 패턴으로, 원하는 목적지로 가는지 확인할 때 사용합니다. バス(버스), 電車(でんしゃ)(전철) 등 다양한 단어를 넣어 활용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 86,
                japaneseSentence: "そばアレルギーがあります。",
                hiragana: "そばアレルギーがあります",
                koreanSentence: "메밀 알레르기가 있어요.",
                romaji: "Soba arerugī ga arimasu",
                koreanPronunciation: "소바 아레루기-가 아리마스",
                grammar: "안전을 위해 반드시 알아둬야 할 표현입니다. [식재료] + アレルギー(아레루기-) + があります 형태로 자신의 알레르기 정보를 전달할 수 있습니다. (예: 卵(たまご)-달걀, 牛乳(ぎゅうにゅう)-우유)"
            ),
            JapanesePhrase(
                id: 87,
                japaneseSentence: "もう少々お待ちください。",
                hiragana: "もうしょうしょうおまちください",
                koreanSentence: "잠시만 더 기다려주세요.",
                romaji: "Mō shōshō o-machi kudasai",
                koreanPronunciation: "모- 쇼-쇼- 오마치 쿠다사이",
                grammar: "주로 점원이나 직원이 손님에게 사용하는 매우 정중한 표현입니다. もう少々(もうしょうしょう)는 '조금만 더'라는 뜻이며, お待ちください는 '기다리다'의 매우 정중한 명령형입니다."
            ),
            JapanesePhrase(
                id: 88,
                japaneseSentence: "ただいま。",
                hiragana: "ただいま",
                koreanSentence: "다녀왔습니다.",
                romaji: "Tadaima",
                koreanPronunciation: "타다이마",
                grammar: "'단지 지금'이라는 뜻의 ただ今(いま)에서 온 말로, '지금 막 돌아왔습니다'라는 의미의 귀가 인사입니다. 집에 들어오면서 하는 고정된 표현입니다."
            ),
            JapanesePhrase(
                id: 89,
                japaneseSentence: "おかえりなさい。",
                hiragana: "おかえりなさい",
                koreanSentence: "어서 와요. / 잘 다녀왔어요?",
                romaji: "Okaerinasai",
                koreanPronunciation: "오카에리나사이",
                grammar: "ただいま(다녀왔습니다)에 대한 표준적인 답변입니다. 집에 있던 사람이 돌아온 사람에게 하는 따뜻한 맞이 인사입니다. 친구나 가족에게는 おかえり라고 짧게 말하기도 합니다."
            ),
            JapanesePhrase(
                id: 90,
                japaneseSentence: "お邪魔します。",
                hiragana: "おじゃまします",
                koreanSentence: "실례하겠습니다. / 폐를 끼치겠습니다.",
                romaji: "O-jama shimasu",
                koreanPronunciation: "오자마시마스",
                grammar: "다른 사람의 집에 방문하여 안으로 들어갈 때 사용하는 고정된 인사말입니다. 邪魔(じゃま)는 '방해'라는 뜻으로, '당신의 공간(시간)을 방해하겠습니다'라는 겸손의 의미가 담겨있습니다."
            ),
            JapanesePhrase(
                id: 91,
                japaneseSentence: "お邪魔しました。",
                hiragana: "おじゃましました",
                koreanSentence: "실례 많았습니다.",
                romaji: "O-jama shimashita",
                koreanPronunciation: "오자마시마시타",
                grammar: "다른 사람의 집에 방문했다가 떠날 때 사용하는 고정된 인사말입니다. 들어갈 때 사용한 お邪魔します(실례하겠습니다)의 과거형으로, '당신의 공간(시간)을 방해했습니다'라는 겸손과 감사의 의미를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 92,
                japaneseSentence: "そんなことないです。",
                hiragana: "そんなことないです",
                koreanSentence: "그렇지 않아요. / 별말씀을요.",
                romaji: "Sonna koto nai desu",
                koreanPronunciation: "손나 코토 나이데스",
                grammar: "칭찬을 받았을 때 겸손하게 답하는 대표적인 표현입니다. 직역하면 '그런 것은 없습니다'라는 뜻으로, '아니에요, 과찬이세요'라는 뉘앙스로 사용됩니다."
            ),
            JapanesePhrase(
                id: 93,
                japaneseSentence: "どうぞ、召し上がってください。",
                hiragana: "どうぞ、めしあがってください",
                koreanSentence: "자, 드세요.",
                romaji: "Dōzo, meshiagatte kudasai",
                koreanPronunciation: "도-조, 메시아갓테 쿠다사이",
                grammar: "召し上がる(めしあがる)는 '먹다'라는 동사 食べる(たべる)의 최고 존경어입니다. 손님이나 윗사람에게 음식을 정중하게 권할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 94,
                japaneseSentence: "よく眠れましたか？",
                hiragana: "よくねむれましたか？",
                koreanSentence: "잘 주무셨어요?",
                romaji: "Yoku nemuremashita ka?",
                koreanPronunciation: "요쿠 네무레마시타카?",
                grammar: "아침 인사 후 안부를 물을 때 사용할 수 있는 표현입니다. 眠る(ねむる)(자다)의 가능형 眠れる(잘 수 있다)의 과거형으로, '편안히 잘 수 있었나요?'라는 뉘앙스의 질문입니다."
            ),
            JapanesePhrase(
                id: 95,
                japaneseSentence: "おかげさまで。",
                hiragana: "おかげさまで",
                koreanSentence: "덕분에요.",
                romaji: "Okagesama de",
                koreanPronunciation: "오카게사마데",
                grammar: "상대방의 도움이나 배려 덕분에 좋은 결과가 있었음을 나타내는 매우 정중하고 따뜻한 표현입니다. お陰様(おかげさま)는 직역하면 '존경하는 그늘님'으로, 보이지 않는 도움에 대한 감사를 의미합니다. \"네, 덕분에 잘 지내요\" (はい、おかげさまで元気です) 처럼 안부를 물었을 때의 답변으로도 자주 쓰입니다."
            ),
            JapanesePhrase(
                id: 96,
                japaneseSentence: "相変わらずです。",
                hiragana: "あいかわらずです",
                koreanSentence: "늘 똑같죠 뭐. / 여전합니다.",
                romaji: "Aikawarazu desu",
                koreanPronunciation: "아이카와라즈데스",
                grammar: "'잘 지내요?'(お元気ですか？)라는 질문에 '특별한 변화 없이 늘 똑같이 지낸다'고 답할 때 사용하는 표현입니다. 相変わらず(あいかわらず)는 '변함없이, 여전히'라는 뜻의 부사입니다."
            ),
            JapanesePhrase(
                id: 97,
                japaneseSentence: "そろそろ行きましょうか。",
                hiragana: "そろそろいきましょうか",
                koreanSentence: "슬슬 갈까요?",
                romaji: "Sorosoro ikimashō ka",
                koreanPronunciation: "소로소로 이키마쇼-카",
                grammar: "함께 있는 사람들에게 이제 이동할 시간임을 부드럽게 제안하는 표현입니다. そろそろ(슬슬) + ~ましょうか(~할까요?) 패턴으로, 상대방의 의사를 확인하며 행동을 제안하는 정중한 방식입니다."
            ),
            JapanesePhrase(
                id: 98,
                japaneseSentence: "ご無沙汰しております。",
                hiragana: "ごぶさたしております",
                koreanSentence: "오랜만입니다. (정중)",
                romaji: "Go-busata shite orimasu",
                koreanPronunciation: "고부사타시테 오리마스",
                grammar: "お久しぶりです(오랜만입니다)보다 훨씬 격식 있고 정중한 표현입니다. 無沙汰(ぶさた)는 '소식을 전하거나 방문하지 않음'을 의미하며, 오랫동안 연락드리지 못한 것에 대한 미안함과 반가움을 동시에 나타냅니다."
            ),
            JapanesePhrase(
                id: 99,
                japaneseSentence: "お大事に。",
                hiragana: "おだいじに",
                koreanSentence: "몸조리 잘 하세요. / 쾌유를 빕니다.",
                romaji: "O-daiji ni",
                koreanPronunciation: "오다이지니",
                grammar: "아프거나 다친 사람에게 하는 위로와 격려의 인사말입니다. 大事(だいじ)는 '소중함, 큰일'을 뜻하며, '몸을 소중히 하세요'라는 의미를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 100,
                japaneseSentence: "これからもよろしくお願いします。",
                hiragana: "これからもよろしくおねがいします",
                koreanSentence: "앞으로도 잘 부탁드립니다.",
                romaji: "Kore kara mo yoroshiku onegai shimasu",
                koreanPronunciation: "코레카라모 요로시쿠 오네가이시마스",
                grammar: "これからも는 '앞으로도'라는 뜻입니다. 자기소개의 마지막이나, 관계를 시작하거나, 한 해를 마무리하고 시작하는 등 앞으로의 지속적인 관계를 기원할 때 사용하는 매우 중요하고 긍정적인 표현입니다."
            ),
            JapanesePhrase(
                id: 101,
                japaneseSentence: "これをください。",
                hiragana: "これをください",
                koreanSentence: "이것을 주세요.",
                romaji: "Kore o kudasai",
                koreanPronunciation: "코레오 쿠다사이",
                grammar: "가게에서 물건을 살 때 가장 기본적으로 사용하는 요청 표현입니다. [명사] + をください 형태로, 원하는 것을 직접적으로 가리키며 말할 수 있습니다."
            ),
            JapanesePhrase(
                id: 102,
                japaneseSentence: "あれを見せてください。",
                hiragana: "あれをみせてください",
                koreanSentence: "저것을 보여주세요.",
                romaji: "Are o misete kudasai",
                koreanPronunciation: "아레오 미세테 쿠다사이",
                grammar: "見せる(みせる)는 '보여주다'라는 뜻의 동사입니다. 동사의 て형 + ください(~해주세요) 패턴을 사용하여, 진열된 상품 등을 더 자세히 보고 싶을 때 사용합니다. これ(이것), それ(그것), あれ(저것)의 거리감을 구분하여 사용하면 좋습니다."
            ),
            JapanesePhrase(
                id: 103,
                japaneseSentence: "もう一つください。",
                hiragana: "もうひとつください",
                koreanSentence: "하나 더 주세요.",
                romaji: "Mō hitotsu kudasai",
                koreanPronunciation: "모- 히토츠 쿠다사이",
                grammar: "もう는 '더, 또'라는 뜻의 부사이며, 一つ(ひとつ)는 물건 한 개를 세는 단위입니다. 같은 물건을 추가로 원할 때 간단하게 사용할 수 있는 편리한 표현입니다."
            ),
            JapanesePhrase(
                id: 104,
                japaneseSentence: "どちらがいいですか？",
                hiragana: "どちらがいいですか？",
                koreanSentence: "어느 쪽이 좋으세요?",
                romaji: "Dochira ga ii desu ka?",
                koreanPronunciation: "도치라가 이-데스카?",
                grammar: "두 가지 선택지 중에서 상대방의 선호를 물을 때 사용하는 질문입니다. どちら는 '어느 쪽'이라는 뜻의 의문사입니다. 세 개 이상의 선택지 중에서는 どれ(어느 것)를 사용합니다."
            ),
            JapanesePhrase(
                id: 105,
                japaneseSentence: "どちらでもいいです。",
                hiragana: "どちらでもいいです",
                koreanSentence: "어느 쪽이든 괜찮아요.",
                romaji: "Dochira demo ii desu",
                koreanPronunciation: "도치라데모 이-데스",
                grammar: "104번 질문에 대한 대표적인 답변입니다. 의문사 + でも는 '~(이)라도, ~든지'라는 의미를 만듭니다. (예: いつでも 언제든지, どこでも 어디든지) 따라서 どちらでも는 '어느 쪽이든'이라는 뜻이 됩니다."
            ),
            JapanesePhrase(
                id: 106,
                japaneseSentence: "ちょっと考えます。",
                hiragana: "ちょっとかんがえます",
                koreanSentence: "좀 생각해 볼게요.",
                romaji: "Chotto kangaemasu",
                koreanPronunciation: "춋토 캉가에마스",
                grammar: "가게 등에서 구매를 바로 결정하기 어려울 때 사용하는 완곡한 표현입니다. 考える(かんがえる)는 '생각하다'라는 뜻의 동사입니다. '지금 바로는 결정하기 어렵다'는 의사를 정중하게 전달할 수 있습니다."
            ),
            JapanesePhrase(
                id: 107,
                japaneseSentence: "今日は何日ですか？",
                hiragana: "きょうはなんにちですか？",
                koreanSentence: "오늘은 며칠이에요?",
                romaji: "Kyō wa nan-nichi desu ka?",
                koreanPronunciation: "쿄-와 난니치데스카?",
                grammar: "날짜를 물어보는 질문입니다. 何日(なんにち)는 '며칠'이라는 뜻입니다. 何曜日(なんようび)(무슨 요일)와 헷갈리지 않도록 주의해야 합니다. 일본에서는 날짜를 읽는 방법이 1일부터 10일까지 특히 불규칙하므로 주의가 필요합니다."
            ),
            JapanesePhrase(
                id: 108,
                japaneseSentence: "誕生日はいつですか？",
                hiragana: "たんじょうびはいつですか？",
                koreanSentence: "생일은 언제예요?",
                romaji: "Tanjōbi wa itsu desu ka?",
                koreanPronunciation: "탄죠-비와 이츠데스카?",
                grammar: "誕生日(たんじょうび)는 '생일'이라는 뜻입니다. いつ는 '언제'라는 시간을 묻는 의문사입니다. 상대방의 생일을 물으며 친목을 다질 수 있는 질문입니다."
            ),
            JapanesePhrase(
                id: 109,
                japaneseSentence: "Tシャツはありますか？",
                hiragana: "Tシャツはありますか？",
                koreanSentence: "티셔츠는 있나요?",
                romaji: "T-shatsu wa arimasu ka?",
                koreanPronunciation: "티-샤츠와 아리마스카?",
                grammar: "[명사] + はありますか？ 패턴으로, 가게에 특정 상품이 있는지 재고를 물어볼 때 사용합니다. あります는 사물이나 식물 등의 존재를 나타내는 동사입니다."
            ),
            JapanesePhrase(
                id: 110,
                japaneseSentence: "すみません、もう一度言ってください。",
                hiragana: "すみません、もういちどいってください",
                koreanSentence: "죄송하지만, 다시 한번 말해주세요.",
                romaji: "Sumimasen, mō ichido itte kudasai",
                koreanPronunciation: "스미마셍, 모- 이치도 잇테 쿠다사이",
                grammar: "すみません(실례합니다)으로 먼저 양해를 구하고, もう一度(다시 한번) + 言ってください(말해주세요)로 요청하는, 매우 정중하고 실용적인 조합입니다. 言う(いう)는 '말하다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 111,
                japaneseSentence: "頭が痛いです。",
                hiragana: "あたまがいたいです",
                koreanSentence: "머리가 아파요.",
                romaji: "Atama ga itai desu",
                koreanPronunciation: "아타마가 이타이데스",
                grammar: "[신체 부위] + が痛い(いたい)です 패턴으로, 아픈 곳을 표현할 수 있습니다. 頭(あたま)는 '머리', 痛い는 '아프다'라는 い형용사입니다. (예: お腹(なか)が痛いです - 배가 아파요)"
            ),
            JapanesePhrase(
                id: 112,
                japaneseSentence: "気分が悪いです。",
                hiragana: "きぶんがわるいです",
                koreanSentence: "속이 안 좋아요. / 컨디션이 안 좋아요.",
                romaji: "Kibun ga warui desu",
                koreanPronunciation: "키분가 와루이데스",
                grammar: "気分が悪い(きぶんがわるい)는 '기분이 나쁘다'는 직역 외에, 몸이 아파 '속이 메스껍거나 컨디션이 좋지 않다'는 의미로 매우 자주 사용되는 관용구입니다."
            ),
            JapanesePhrase(
                id: 113,
                japaneseSentence: "犬と猫と、どちらが好きですか？",
                hiragana: "いぬとねこと、どちらがすきですか？",
                koreanSentence: "개와 고양이 중, 어느 쪽을 더 좋아해요?",
                romaji: "Inu to neko to, dochira ga suki desu ka?",
                koreanPronunciation: "이누토 네코토, 도치라가 스키데스카?",
                grammar: "AとBと、どちらが ~か 패턴은 두 가지를 비교하여 상대방의 선호를 물을 때 사용합니다. と는 '~와/과'를 의미하며, どちら는 '어느 쪽'을 뜻합니다."
            ),
            JapanesePhrase(
                id: 114,
                japaneseSentence: "猫のほうが好きです。",
                hiragana: "ねこのほうがすきです",
                koreanSentence: "고양이 쪽을 더 좋아해요.",
                romaji: "Neko no hō ga suki desu",
                koreanPronunciation: "네코노 호-가 스키데스",
                grammar: "113번 질문에 대한 대표적인 답변입니다. ~のほう는 '~의 쪽'이라는 뜻으로, 비교 대상 중에서 하나를 선택하여 더 선호함을 나타낼 때 사용합니다."
            ),
            JapanesePhrase(
                id: 115,
                japaneseSentence: "これは何ですか？",
                hiragana: "これはなんですか？",
                koreanSentence: "이것은 무엇인가요?",
                romaji: "Kore wa nan desu ka?",
                koreanPronunciation: "코레와 난데스카?",
                grammar: "사물의 정체를 묻는 가장 기본적인 질문입니다. これ는 '이것', 何(なん)은 '무엇'을 의미합니다. 일상 회화의 기초 중의 기초라고 할 수 있습니다."
            ),
            JapanesePhrase(
                id: 116,
                japaneseSentence: "趣味は映画を見ることです。",
                hiragana: "しゅみはえいがをみることです",
                koreanSentence: "취미는 영화를 보는 것입니다.",
                romaji: "Shumi wa eiga o miru koto desu",
                koreanPronunciation: "슈미와 에-가오 미루 코토데스",
                grammar: "동사 원형 + こと는 동사를 명사처럼 만들어 '~하는 것'이라는 의미를 가집니다. 見ること는 '보는 것'이 됩니다. '취미는 무엇인가요?'라는 질문에 구체적으로 답할 때 유용한 패턴입니다."
            ),
            JapanesePhrase(
                id: 117,
                japaneseSentence: "後で連絡します。",
                hiragana: "あとでれんらくします",
                koreanSentence: "나중에 연락할게요.",
                romaji: "Ato de renraku shimasu",
                koreanPronunciation: "아토데 렌라쿠시마스",
                grammar: "지금 당장이 아닌 나중에 연락하겠다는 의사를 전달할 때 사용합니다. 後で(あとで)는 '나중에', 連絡します(れんらくします)는 '연락합니다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 118,
                japaneseSentence: "荷物をお願いします。",
                hiragana: "にもつをおねがいします",
                koreanSentence: "짐을 부탁합니다. (맡아주세요)",
                romaji: "Nimotsu o onegai shimasu",
                koreanPronunciation: "니모츠오 오네가이시마스",
                grammar: "荷物(にもつ)는 '짐'이라는 뜻입니다. 호텔이나 특정 장소에서 짐을 잠시 보관해달라고 요청할 때 사용하는 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 119,
                japaneseSentence: "チェックインをお願いします。",
                hiragana: "チェックインをおねがいします",
                koreanSentence: "체크인 부탁합니다.",
                romaji: "Chekku-in o onegai shimasu",
                koreanPronunciation: "첵크인오 오네가이시마스",
                grammar: "호텔이나 공항에서 수속을 밟을 때 사용하는 필수 표현입니다. チェックイン은 영어 'Check-in'에서 온 외래어입니다."
            ),
            JapanesePhrase(
                id: 120,
                japaneseSentence: "チェックアウトをお願いします。",
                hiragana: "チェックアウトをおねがいします",
                koreanSentence: "체크아웃 부탁합니다.",
                romaji: "Chekku-auto o onegai shimasu",
                koreanPronunciation: "첵크아우토오 오네가이시마스",
                grammar: "호텔에서 퇴실 수속을 밟을 때 사용하는 표현입니다. チェックイン과 마찬가지로 영어 'Check-out'에서 온 외래어이며, ~をお願いします 패턴으로 정중하게 요청합니다."
            ),
            JapanesePhrase(
                id: 121,
                japaneseSentence: "今日の予定は何ですか？",
                hiragana: "きょうのよていはなんですか？",
                koreanSentence: "오늘 예정은 뭐예요?",
                romaji: "Kyō no yotei wa nan desu ka?",
                koreanPronunciation: "쿄-노 요테-와 난데스카?",
                grammar: "상대방의 하루 계획을 물을 때 사용하는 표현입니다. 今日(きょう)는 '오늘', 予定(よてい)는 '예정'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 122,
                japaneseSentence: "今、時間はありますか？",
                hiragana: "いま、じかんはありますか？",
                koreanSentence: "지금, 시간 있으세요?",
                romaji: "Ima, jikan wa arimasu ka?",
                koreanPronunciation: "이마, 지칸와 아리마스카?",
                grammar: "ちょっといいですか？보다 조금 더 직접적으로 상대방에게 시간이 있는지 물어보는 표현입니다. 今(いま)는 '지금', 時間(じかん)은 '시간'이라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 123,
                japaneseSentence: "何時ごろがいいですか？",
                hiragana: "なんじごろがいいですか？",
                koreanSentence: "몇 시쯤이 좋아요?",
                romaji: "Nan-ji goro ga ii desu ka?",
                koreanPronunciation: "난지고로가 이-데스카?",
                grammar: "약속 시간을 정할 때 상대방의 의견을 묻는 유용한 질문입니다. 何時(なんじ)는 '몇 시'라는 뜻이며, ごろ는 시간 뒤에 붙어 '~쯤, ~경'이라는 대략적인 시각을 나타냅니다."
            ),
            JapanesePhrase(
                id: 124,
                japaneseSentence: "仕事は何をしていますか？",
                hiragana: "しごとはなにをしていますか？",
                koreanSentence: "무슨 일을 하세요?",
                romaji: "Shigoto wa nani o shite imasu ka?",
                koreanPronunciation: "시고토와 나니오 시테이마스카?",
                grammar: "상대방의 직업을 물을 때 사용하는 일반적인 표현입니다. 仕事(しごと)는 '일, 직업'이라는 뜻이며, -て いますか 형태로 현재 하고 있는 일(직업)에 대해 묻습니다."
            ),
            JapanesePhrase(
                id: 125,
                japaneseSentence: "もうすぐ着きます。",
                hiragana: "もうすぐつきます",
                koreanSentence: "이제 곧 도착해요.",
                romaji: "Mō sugu tsukimasu",
                koreanPronunciation: "모- 스구 츠키마스",
                grammar: "약속 장소에 거의 다 와 간다는 것을 알릴 때 사용합니다. もうすぐ는 '이제 곧, 금방'이라는 뜻의 부사이며, 着きます(つきます)는 '도착합니다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 126,
                japaneseSentence: "禁煙席をお願いします。",
                hiragana: "きんえんせきをおねがいします",
                koreanSentence: "금연석으로 부탁합니다.",
                romaji: "Kin'en-seki o onegai shimasu",
                koreanPronunciation: "킨엔세키오 오네가이시마스",
                grammar: "식당 등에서 좌석을 요청할 때 사용합니다. 禁煙席(きんえんせき)는 '금연석'이라는 뜻의 명사입니다. ~をお願いします 패턴으로 정중하게 요청합니다."
            ),
            JapanesePhrase(
                id: 127,
                japaneseSentence: "喫煙席をお願いします。",
                hiragana: "きつえんせきをおねがいします",
                koreanSentence: "흡연석으로 부탁합니다.",
                romaji: "Kitsuen-seki o onegai shimasu",
                koreanPronunciation: "키츠엔세키오 오네가이시마스",
                grammar: "126번의 반대 표현입니다. 喫煙席(きつえんせき)는 '흡연석'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 128,
                japaneseSentence: "窓側の席をお願いします。",
                hiragana: "まどがわのせきをおねがいします",
                koreanSentence: "창가 자리로 부탁합니다.",
                romaji: "Madogawa no seki o onegai shimasu",
                koreanPronunciation: "마도가와노 세키오 오네가이시마스",
                grammar: "비행기, 기차, 식당 등에서 창가 자리를 원할 때 사용합니다. 窓側(まどがわ)는 '창문 쪽', 席(せき)는 '자리, 좌석'이라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 129,
                japaneseSentence: "通路側の席をお願いします。",
                hiragana: "つうろがわのせきをおねがいします",
                koreanSentence: "통로 쪽 자리로 부탁합니다.",
                romaji: "Tsūro-gawa no seki o onegai shimasu",
                koreanPronunciation: "츠-로가와노 세키오 오네가이시마스",
                grammar: "128번의 반대 표현으로, 비행기나 기차 등에서 통로 쪽 자리를 원할 때 사용합니다. 通路側(つうろがわ)는 '통로 쪽'을 의미합니다."
            ),
            JapanesePhrase(
                id: 130,
                japaneseSentence: "別に。",
                hiragana: "べつに",
                koreanSentence: "별로요. / 딱히 없어요.",
                romaji: "Betsu ni",
                koreanPronunciation: "베츠니",
                grammar: "질문에 대해 '특별히 그렇지 않다' 또는 '특별히 하고 싶은 것이 없다'고 답할 때 사용하는 짧은 표현입니다. (예: \"뭐 먹고 싶어?\" -> \"別に。\") 때로는 무관심하거나 퉁명스러운 뉘앙스를 줄 수 있으므로 상황에 맞게 사용하는 것이 좋습니다."
            ),
            JapanesePhrase(
                id: 131,
                japaneseSentence: "私はコーヒーのほうがいいです。",
                hiragana: "わたしはコーヒーのほうがいいです",
                koreanSentence: "저는 커피가 더 좋아요.",
                romaji: "Watashi wa kōhī no hō ga ii desu",
                koreanPronunciation: "와타시와 코-히-노 호-가 이-데스",
                grammar: "~のほうが好きです(~ 쪽을 더 좋아해요)와 유사하게, いいです(좋아요)를 사용하여 자신의 선호를 나타내는 표현입니다. '더 낫다' 또는 '더 적합하다'는 뉘앙스를 포함합니다."
            ),
            JapanesePhrase(
                id: 132,
                japaneseSentence: "賛成です。",
                hiragana: "さんせいです",
                koreanSentence: "찬성입니다.",
                romaji: "Sansei desu",
                koreanPronunciation: "산세-데스",
                grammar: "어떤 의견이나 제안에 대해 동의함을 명확하게 나타내는 표현입니다. 賛成(さんせい)는 '찬성'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 133,
                japaneseSentence: "反対です。",
                hiragana: "はんたいです",
                koreanSentence: "반대입니다.",
                romaji: "Hantai desu",
                koreanPronunciation: "한타이데스",
                grammar: "132번의 반대 표현으로, 의견이나 제안에 동의하지 않음을 나타냅니다. 反対(はんたい)는 '반대'라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 134,
                japaneseSentence: "信じられません。",
                hiragana: "しんじられません",
                koreanSentence: "믿을 수 없어요.",
                romaji: "Shinjiraremasen",
                koreanPronunciation: "신지라레마셍",
                grammar: "놀라운 소식을 듣거나, 믿기 힘든 광경을 봤을 때 사용하는 표현입니다. 信じる(しんじる)(믿다) 동사의 가능형 부정 信じられない(믿을 수 없다)의 정중체입니다."
            ),
            JapanesePhrase(
                id: 135,
                japaneseSentence: "冗談です。",
                hiragana: "じょうだんです",
                koreanSentence: "농담이에요.",
                romaji: "Jōdan desu",
                koreanPronunciation: "죠-단데스",
                grammar: "방금 한 말이 진심이 아니라 농담이었음을 밝힐 때 사용합니다. 冗談(じょうだん)은 '농담'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 136,
                japaneseSentence: "その通りです。",
                hiragana: "そのとおりです",
                koreanSentence: "말씀하신 대로예요. / 바로 그거예요.",
                romaji: "Sono tōri desu",
                koreanPronunciation: "소노 토-리데스",
                grammar: "상대방의 말이 전적으로 옳다고 강하게 동의할 때 사용하는 표현입니다. その通り(そのとおり)는 '그대로, 그 방식대로'라는 의미입니다."
            ),
            JapanesePhrase(
                id: 137,
                japaneseSentence: "ちょっと違います。",
                hiragana: "ちょっとちがいます",
                koreanSentence: "조금 다른데요. / 그건 좀 아니에요.",
                romaji: "Chotto chigaimasu",
                koreanPronunciation: "춋토 치가이마스",
                grammar: "상대방의 말이나 생각이 사실과 다를 때, 부드럽게 정정하거나 반박하는 표현입니다. 違います(ちがいます)는 '다릅니다, 아닙니다'라는 뜻으로, ちょっと(조금)를 붙여 완곡하게 만듭니다."
            ),
            JapanesePhrase(
                id: 138,
                japaneseSentence: "ケースバイケースです。",
                hiragana: "ケースバイケースです",
                koreanSentence: "경우에 따라 달라요.",
                romaji: "Kēsu bai kēsu desu",
                koreanPronunciation: "케-스바이케-스데스",
                grammar: "영어 'Case by case'에서 온 외래어로, 어떤 규칙이나 답변이 일률적으로 적용되지 않고 상황에 따라 달라짐을 나타낼 때 매우 자주 사용하는 표현입니다."
            ),
            JapanesePhrase(
                id: 139,
                japaneseSentence: "とんでもないです。",
                hiragana: "とんでもないです",
                koreanSentence: "별말씀을요. / 당치도 않습니다. / 천만에요.",
                romaji: "Tondemonai desu",
                koreanPronunciation: "톤데모나이데스",
                grammar: "상대방의 감사나 사과에 대해 '그럴 필요 없다'고 강하게 부정하며 겸손을 나타내는 표현입니다. \"일본어 잘하시네요\" 같은 칭찬에 \"에이, 당치도 않아요\"라고 답할 때도 자주 쓰입니다."
            ),
            JapanesePhrase(
                id: 140,
                japaneseSentence: "お任せします。",
                hiragana: "おまかせします",
                koreanSentence: "맡길게요. / 알아서 해주세요.",
                romaji: "O-makase shimasu",
                koreanPronunciation: "오마카세시마스",
                grammar: "메뉴 선택이나 계획 등 어떤 결정을 상대방에게 일임할 때 사용하는 표현입니다. '맡기다'는 동사 任せる(まかせる)의 정중한 형태로, お~します 구조를 가집니다."
            ),
            JapanesePhrase(
                id: 141,
                japaneseSentence: "朝ごはんは食べましたか？",
                hiragana: "あさごはんはたべましたか？",
                koreanSentence: "아침밥은 먹었어요?",
                romaji: "Asa-gohan wa tabemashita ka?",
                koreanPronunciation: "아사고항와 타베마시타카?",
                grammar: "일상적인 안부를 묻는 질문입니다. 朝ごはん(あさごはん)은 '아침밥', 食べましたか(たべましたか)는 '먹다'는 동사 食べる(たべる)의 정중 과거 의문형입니다."
            ),
            JapanesePhrase(
                id: 142,
                japaneseSentence: "もう食べました。",
                hiragana: "もうたべました",
                koreanSentence: "벌써 먹었어요.",
                romaji: "Mō tabemashita",
                koreanPronunciation: "모- 타베마시타",
                grammar: "141번 질문에 대한 긍정의 답변입니다. 부사 もう는 과거형 문장과 함께 쓰여 '이미, 벌써'라는 완료의 의미를 나타냅니다."
            ),
            JapanesePhrase(
                id: 143,
                japaneseSentence: "まだです。",
                hiragana: "まだです",
                koreanSentence: "아직이요.",
                romaji: "Mada desu",
                koreanPronunciation: "마다데스",
                grammar: "141번 질문에 대한 부정의 답변입니다. まだ는 '아직'이라는 뜻으로, '아직 먹지 않았습니다'(まだ食べていません)를 짧게 줄여서 표현한 매우 흔한 구어체 답변입니다."
            ),
            JapanesePhrase(
                id: 144,
                japaneseSentence: "そろそろ寝ます。",
                hiragana: "そろそろねます",
                koreanSentence: "슬슬 잘게요.",
                romaji: "Sorosoro nemasu",
                koreanPronunciation: "소로소로 네마스",
                grammar: "이제 곧 잠자리에 들 것임을 알리는 표현입니다. そろそろ는 '슬슬, 이제 곧'이라는 뜻이며, 寝ます(ねます)는 '자다'라는 동사 寝る(ねる)의 정중형입니다."
            ),
            JapanesePhrase(
                id: 145,
                japaneseSentence: "おやすみなさい。",
                hiragana: "おやすみなさい",
                koreanSentence: "안녕히 주무세요.",
                romaji: "Oyasuminasai",
                koreanPronunciation: "오야스미나사이",
                grammar: "밤에 헤어지거나 잠자리에 들 때 사용하는 고정된 인사말입니다. '쉬다'라는 동사 休む(やすむ)에서 온 말로, '편히 쉬세요'라는 의미를 담고 있습니다. 친구나 가족에게는 おやすみ라고 짧게 말합니다."
            ),
            JapanesePhrase(
                id: 146,
                japaneseSentence: "今日は忙しいですか？",
                hiragana: "きょうはいそがしいですか？",
                koreanSentence: "오늘 바빠요?",
                romaji: "Kyō wa isogashii desu ka?",
                koreanPronunciation: "쿄-와 이소가시-데스카?",
                grammar: "상대방의 일정을 물어보는 질문입니다. 忙しい(いそがしい)는 '바쁘다'라는 뜻의 い형용사입니다."
            ),
            JapanesePhrase(
                id: 147,
                japaneseSentence: "まあまあです。",
                hiragana: "まあまあです",
                koreanSentence: "그저 그래요. / 쏘쏘예요.",
                romaji: "Mā mā desu",
                koreanPronunciation: "마-마-데스",
                grammar: "'어때요?'(どうですか？)라는 질문에 대해, '좋지도 나쁘지도 않다'고 답할 때 사용하는 표현입니다. 맛, 컨디션, 상황 등 다양한 것에 대해 사용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 148,
                japaneseSentence: "車で送ってください。",
                hiragana: "くるまでおくってください",
                koreanSentence: "차로 태워다 주세요.",
                romaji: "Kuruma de okutte kudasai",
                koreanPronunciation: "쿠루마데 오쿳테 쿠다사이",
                grammar: "동사 送る(おくる)는 '보내다'라는 뜻 외에 '차 등으로 바래다주다, 태워주다'라는 뜻도 있습니다. 車で(くるまで)(차로)와 함께 쓰여 '차로 태워달라'는 의미를 명확히 합니다."
            ),
            JapanesePhrase(
                id: 149,
                japaneseSentence: "迎えに来てください。",
                hiragana: "むかえにきてください",
                koreanSentence: "데리러 와주세요.",
                romaji: "Mukae ni kite kudasai",
                koreanPronunciation: "무카에니 키테 쿠다사이",
                grammar: "迎えに来る(むかえにくる)는 '마중하러 오다, 데리러 오다'라는 뜻의 복합 동사입니다. 迎える(맞이하다) + 来る(오다)의 조합입니다."
            ),
            JapanesePhrase(
                id: 150,
                japaneseSentence: "後で電話してください。",
                hiragana: "あとででんわしてください",
                koreanSentence: "나중에 전화해 주세요.",
                romaji: "Ato de denwa shite kudasai",
                koreanPronunciation: "아토데 덴와시테 쿠다사이",
                grammar: "지금 통화하기 어려우니 나중에 다시 걸어달라고 요청하는 표현입니다. 後で(あとで)는 '나중에', 電話して(でんわして)ください는 '전화하다' 동사 電話する의 て형 + ください 형태입니다."
            ),
            JapanesePhrase(
                id: 151,
                japaneseSentence: "ここに座ってもいいですか？",
                hiragana: "ここにすわってもいいですか？",
                koreanSentence: "여기에 앉아도 될까요?",
                romaji: "Koko ni suwatte mo ii desu ka?",
                koreanPronunciation: "코코니 스왓테모 이-데스카?",
                grammar: "동사의 て형 + もいいですか？(~해도 괜찮을까요?) 패턴을 사용한 허락을 구하는 표현입니다. 座る(すわる)는 '앉다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 152,
                japaneseSentence: "ここでタバコを吸ってはいけません。",
                hiragana: "ここでタバコをすってはいけません",
                koreanSentence: "여기서 담배를 피우면 안 됩니다.",
                romaji: "Koko de tabako o sutte wa ikemasen",
                koreanPronunciation: "코코데 타바코오 스엣테와 이케마셍",
                grammar: "동사의 て형 + はいけません은 '~해서는 안 됩니다'라는 강한 금지를 나타내는 표현입니다. タバコを吸う(すう)는 '담배를 피우다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 153,
                japaneseSentence: "忘れないでください。",
                hiragana: "わすれないでください",
                koreanSentence: "잊지 마세요.",
                romaji: "Wasurenaide kudasai",
                koreanPronunciation: "와스레나이데 쿠다사이",
                grammar: "동사의 ない형 + でください는 '~하지 말아 주세요'라는 부정의 요청, 즉 부드러운 금지를 나타내는 표현입니다. 忘れる(わすれる)는 '잊다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 154,
                japaneseSentence: "心配しないでください。",
                hiragana: "しんぱいしないでください",
                koreanSentence: "걱정하지 마세요.",
                romaji: "Shinpai shinaide kudasai",
                koreanPronunciation: "심파이시나이데 쿠다사이",
                grammar: "상대방을 안심시킬 때 사용하는 표현입니다. '걱정하다'라는 동사 心配する(しんぱいする)에 ~ないでください 패턴을 사용했습니다."
            ),
            JapanesePhrase(
                id: 155,
                japaneseSentence: "無理しないでください。",
                hiragana: "むりしないでください",
                koreanSentence: "무리하지 마세요.",
                romaji: "Muri shinaide kudasai",
                koreanPronunciation: "무리시나이데 쿠다사이",
                grammar: "상대방이 힘들어 보일 때, 건강을 염려하며 해주는 말입니다. 無理する(むりする)는 '무리하다'는 동사이며, ~ないでください 패턴으로 '무리하지 말아 달라'고 부드럽게 요청합니다."
            ),
            JapanesePhrase(
                id: 156,
                japaneseSentence: "私は歌が下手です。",
                hiragana: "わたしはうたがへたです",
                koreanSentence: "저는 노래를 못해요.",
                romaji: "Watashi wa uta ga heta desu",
                koreanPronunciation: "와타시와 우타가 헤타데스",
                grammar: "上手(じょうず)(잘함)의 반대말로, 下手(へた)는 '서투름, 못함'을 나타내는 な형용사입니다. [분야] + が下手です 패턴으로 '~를 못한다'고 표현할 수 있습니다."
            ),
            JapanesePhrase(
                id: 157,
                japaneseSentence: "料理ができますか？",
                hiragana: "りょうりができますか？",
                koreanSentence: "요리할 줄 알아요?",
                romaji: "Ryōri ga dekimasu ka?",
                koreanPronunciation: "료-리가 데키마스카?",
                grammar: "[명사] + ができますか？ 패턴으로 '~을 할 수 있습니까?'라고 능력을 물어볼 수 있습니다. 料理(りょうり)는 '요리'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 158,
                japaneseSentence: "あまりできません。",
                hiragana: "あまりできません",
                koreanSentence: "그다지 잘하지는 못해요.",
                romaji: "Amari dekimasen",
                koreanPronunciation: "아마리 데키마셍",
                grammar: "157번 질문에 대해 겸손하게 답하는 표현입니다. 부사 あまり는 '그다지, 별로'라는 뜻으로, 항상 뒤에 부정형(~ません, ~ないです 등)이 따라옵니다."
            ),
            JapanesePhrase(
                id: 159,
                japaneseSentence: "運動したほうがいいですよ。",
                hiragana: "うんどうしたほうがいいですよ",
                koreanSentence: "운동하는 편이 좋아요.",
                romaji: "Undō shita hō ga ii desu yo",
                koreanPronunciation: "운도-시타 호-가 이-데스요",
                grammar: "동사의 과거형(た형) + ほうがいいです는 '~하는 편이 좋다'고 상대방에게 조언이나 충고를 할 때 사용하는 중요한 패턴입니다. 運動する(うんどうする)는 '운동하다'는 뜻입니다."
            ),
            JapanesePhrase(
                id: 160,
                japaneseSentence: "薬を飲んだほうがいいですよ。",
                hiragana: "くすりをのんだほうがいいですよ",
                koreanSentence: "약을 먹는 편이 좋아요.",
                romaji: "Kusuri o nonda hō ga ii desu yo",
                koreanPronunciation: "쿠스리오 논다 호-가 이-데스요",
                grammar: "159번과 같은 패턴의 충고 표현입니다. 薬(くすり)는 '약'이라는 뜻이며, 일본에서는 약을 먹을 때 '마시다'는 동사 飲む(のむ)를 사용합니다. 飲んだ는 飲む의 과거형입니다."
            ),
            JapanesePhrase(
                id: 161,
                japaneseSentence: "どうして遅れたんですか？",
                hiragana: "どうしておくれたんですか？",
                koreanSentence: "왜 늦었어요?",
                romaji: "Dōshite okuretan desu ka?",
                koreanPronunciation: "도-시테 오쿠레탄데스카?",
                grammar: "~んですか？는 단순한 질문이 아니라, 어떤 상황에 대한 설명이나 이유를 요구하는 뉘앙스를 가집니다. 遅れる(おくれる)는 '늦다'라는 동사이며, 遅れた는 과거형입니다. 즉, '늦은' 상황에 대한 이유를 묻는 질문입니다."
            ),
            JapanesePhrase(
                id: 162,
                japaneseSentence: "電車が遅れたからです。",
                hiragana: "でんしゃがおくれたからです",
                koreanSentence: "전철이 늦었기 때문이에요.",
                romaji: "Densha ga okureta kara desu",
                koreanPronunciation: "덴샤가 오쿠레타카라데스",
                grammar: "161번 질문에 대한 대표적인 답변입니다. [이유] + からです는 '~이기 때문입니다'라고 이유를 설명하며 문장을 끝맺는 표현입니다. 電車(でんしゃ)는 '전철'입니다."
            ),
            JapanesePhrase(
                id: 163,
                japaneseSentence: "初めてです。",
                hiragana: "はじめてです",
                koreanSentence: "처음이에요.",
                romaji: "Hajimete desu",
                koreanPronunciation: "하지메테데스",
                grammar: "어떤 경험을 처음 해본다고 말할 때 사용하는 간단하고 유용한 표현입니다. 初めて(はじめて)는 '처음으로, 최초로'라는 뜻의 부사입니다. (예: 日本は初めてです - 일본은 처음이에요)"
            ),
            JapanesePhrase(
                id: 164,
                japaneseSentence: "久しぶりです。",
                hiragana: "ひさしぶりです",
                koreanSentence: "오랜만이에요.",
                romaji: "Hisashiburi desu",
                koreanPronunciation: "히사시부리데스",
                grammar: "오랫동안 만나지 못했던 사람과 재회했을 때 사용하는 일반적인 인사입니다. ご無沙汰しております보다 덜 격식적인 표현입니다. 친구나 아랫사람에게는 久しぶり！라고 짧게 말합니다."
            ),
            JapanesePhrase(
                id: 165,
                japaneseSentence: "緊張しています。",
                hiragana: "きんちょうしています",
                koreanSentence: "긴장하고 있어요. / 긴장돼요.",
                romaji: "Kinchō shite imasu",
                koreanPronunciation: "킨쵸-시테 이마스",
                grammar: "'긴장하다'라는 동사 緊張する(きんちょうする)의 -て います 형태입니다. '긴장하고 있는' 현재의 상태를 나타냅니다. 발표나 면접 등 중요한 일을 앞두고 사용합니다."
            ),
            JapanesePhrase(
                id: 166,
                japaneseSentence: "がっかりしました。",
                hiragana: "がっかりしました",
                koreanSentence: "실망했어요.",
                romaji: "Gakkari shimashita",
                koreanPronunciation: "각카리시마시타",
                grammar: "기대했던 결과가 나오지 않아 실망했을 때의 감정을 나타냅니다. がっかりする는 '실망하다'라는 동사이며, しました는 과거형입니다."
            ),
            JapanesePhrase(
                id: 167,
                japaneseSentence: "感動しました。",
                hiragana: "かんどうしました",
                koreanSentence: "감동했어요.",
                romaji: "Kandō shimashita",
                koreanPronunciation: "칸도-시마시타",
                grammar: "영화, 음악, 이야기 등에 마음이 크게 움직였을 때 사용하는 표현입니다. 感動する(かんどうする)는 '감동하다'라는 동사이며, しました는 과거형입니다."
            ),
            JapanesePhrase(
                id: 168,
                japaneseSentence: "髪を切りましたか？",
                hiragana: "かみをきりましたか？",
                koreanSentence: "머리 잘랐어요?",
                romaji: "Kami o kirimashita ka?",
                koreanPronunciation: "카미오 키리마시타카?",
                grammar: "상대방의 외모 변화를 알아채고 대화를 시작하기 좋은 질문입니다. 髪(かみ)는 '머리카락', 切る(きる)는 '자르다'라는 동사입니다."
            ),
            JapanesePhrase(
                id: 169,
                japaneseSentence: "似合いますね。",
                hiragana: "にあいますね",
                koreanSentence: "잘 어울리네요.",
                romaji: "Niaimasu ne",
                koreanPronunciation: "니아이마스네",
                grammar: "168번 질문 후에 칭찬으로 이어가기 좋은 표현입니다. 동사 似合う(にあう)는 '어울리다'라는 뜻입니다. 문장 끝의 ね는 부드러운 동의나 감탄의 느낌을 더합니다."
            ),
            JapanesePhrase(
                id: 170,
                japaneseSentence: "そろそろ帰りましょう。",
                hiragana: "そろそろかえりましょう",
                koreanSentence: "슬슬 돌아갈까요?",
                romaji: "Sorosoro kaerimashō",
                koreanPronunciation: "소로소로 카에리마쇼-",
                grammar: "~ましょう는 '~합시다'라는 청유형입니다. そろそろ(슬슬)와 함께 사용하여, 이제 집이나 숙소로 돌아갈 시간임을 부드럽게 제안하는 표현입니다. 帰る(かえる)는 '돌아가다/오다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 171,
                japaneseSentence: "風邪をひきました。",
                hiragana: "かぜをひきました",
                koreanSentence: "감기에 걸렸어요.",
                romaji: "Kaze o hikimashita",
                koreanPronunciation: "카제오 히키마시타",
                grammar: "風邪をひく(かぜをひく)는 '감기에 걸리다'라는 뜻의 고정된 관용구입니다. 자신의 몸 상태를 설명하거나 약속을 변경해야 할 때 사용합니다. ひきました는 과거형입니다."
            ),
            JapanesePhrase(
                id: 172,
                japaneseSentence: "熱があります。",
                hiragana: "ねつがあります",
                koreanSentence: "열이 있어요.",
                romaji: "Netsu ga arimasu",
                koreanPronunciation: "네츠가 아리마스",
                grammar: "아픈 증상을 말할 때 [증상] + があります 패턴을 사용할 수 있습니다. 熱(ねつ)는 '열'이라는 뜻입니다. (예: 咳(せき)が出ます - 기침이 나옵니다)"
            ),
            JapanesePhrase(
                id: 173,
                japaneseSentence: "病院に行ったほうがいいですよ。",
                hiragana: "びょういんにいったほうがいいですよ",
                koreanSentence: "병원에 가는 편이 좋아요.",
                romaji: "Byōin ni itta hō ga ii desu yo",
                koreanPronunciation: "뵤-인니 잇타 호-가 이-데스요",
                grammar: "동사의 과거형(た형) + ほうがいいです(~하는 편이 좋다) 패턴을 사용한 충고 표현입니다. 病院(びょういん)은 '병원', 行った(いった)는 行く(가다)의 과거형입니다."
            ),
            JapanesePhrase(
                id: 174,
                japaneseSentence: "今日は暑いですね。",
                hiragana: "きょうはあついですね",
                koreanSentence: "오늘 덥네요.",
                romaji: "Kyō wa atsui desu ne",
                koreanPronunciation: "쿄-와 아츠이데스네",
                grammar: "날씨에 대해 가볍게 대화를 시작할 때 쓰는 말입니다. 暑い(あつい)는 날씨가 '덥다'는 뜻의 い형용사입니다. (뜨거운 물건을 말할 때는 한자가 다른 熱い를 씁니다.)"
            ),
            JapanesePhrase(
                id: 175,
                japaneseSentence: "今日は寒いですね。",
                hiragana: "きょうはさむいですね",
                koreanSentence: "오늘 춥네요.",
                romaji: "Kyō wa samui desu ne",
                koreanPronunciation: "쿄-와 사무이데스네",
                grammar: "174번의 반대 표현으로, 날씨가 추울 때 사용합니다. 寒い(さむい)는 날씨가 '춥다'는 뜻의 い형용사입니다."
            ),
            JapanesePhrase(
                id: 176,
                japaneseSentence: "エアコンをつけてください。",
                hiragana: "エアコンをつけてください",
                koreanSentence: "에어컨을 켜주세요.",
                romaji: "Eakon o tsukete kudasai",
                koreanPronunciation: "에아콘오 츠케테 쿠다사이",
                grammar: "エアコン은 '에어컨'이라는 외래어입니다. つける는 '켜다, 붙이다'는 뜻의 동사로, 전기 기구를 켤 때 사용합니다. 반대는 消す(けす)(끄다)입니다. (예: エアコンを消してください)"
            ),
            JapanesePhrase(
                id: 177,
                japaneseSentence: "暖房をつけてください。",
                hiragana: "だんぼうをつけてください",
                koreanSentence: "난방을 켜주세요.",
                romaji: "Danbō o tsukete kudasai",
                koreanPronunciation: "담보-오 츠케테 쿠다사이",
                grammar: "176번과 같은 구조의 문장입니다. 暖房(だんぼう)는 '난방'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 178,
                japaneseSentence: "この席、空いていますか？",
                hiragana: "このせき、あいていますか？",
                koreanSentence: "이 자리, 비어 있나요?",
                romaji: "Kono seki, aite imasu ka?",
                koreanPronunciation: "코노 세키, 아이테 이마스카?",
                grammar: "카페나 도서관 등에서 자리가 있는지 물을 때 사용하는 필수 표현입니다. 席(せき)는 '자리', 空く(あく)는 '비다'는 뜻의 동사입니다. -て いますか 형태로 '비어 있는 상태입니까?'라고 묻습니다."
            ),
            JapanesePhrase(
                id: 179,
                japaneseSentence: "Wi-Fiはありますか？",
                hiragana: "ワイファイはありますか？",
                koreanSentence: "와이파이 있나요?",
                romaji: "Waifai wa arimasu ka?",
                koreanPronunciation: "와이파이와 아리마스카?",
                grammar: "현대 여행 및 생활의 필수 질문입니다. [명사] + はありますか？ 패턴으로, 특정 서비스나 물건의 유무를 물을 수 있습니다."
            ),
            JapanesePhrase(
                id: 180,
                japaneseSentence: "パスワードを教えてください。",
                hiragana: "パスワードをおしえてください",
                koreanSentence: "비밀번호를 알려주세요.",
                romaji: "Pasuwādo o oshiete kudasai",
                koreanPronunciation: "파스와-도오 오시에테 쿠다사이",
                grammar: "179번 질문에 이어 와이파이 비밀번호를 물을 때 사용합니다. パスワード는 '패스워드'라는 외래어이며, 教える(おしえる)는 '가르치다, 알려주다'는 뜻입니다."
            ),
            JapanesePhrase(
                id: 181,
                japaneseSentence: "その通りだと思います。",
                hiragana: "そのとおりだとおもいます",
                koreanSentence: "말씀하신 대로라고 생각해요.",
                romaji: "Sono tōri da to omoimasu",
                koreanPronunciation: "소노 토-리다토 오모이마스",
                grammar: "その通りです(말씀하신 대로예요)보다 한 단계 부드러운 동의 표현입니다. ~だと思います(~라고 생각합니다)를 붙여, '전적으로 맞지만, 일단은 제 생각입니다'라는 겸손한 뉘앙스를 더합니다."
            ),
            JapanesePhrase(
                id: 182,
                japaneseSentence: "仕事が終わりました。",
                hiragana: "しごとがおわりました",
                koreanSentence: "일이 끝났어요.",
                romaji: "Shigoto ga owarimashita",
                koreanPronunciation: "시고토가 오와리마시타",
                grammar: "終わる(おわる)는 '끝나다'라는 자동사입니다. 仕事(しごと)(일)가 끝났음을 알릴 때 사용합니다. 정중체 과거형 ~ました를 사용해 완료된 상태를 나타냅니다."
            ),
            JapanesePhrase(
                id: 183,
                japaneseSentence: "誕生日おめでとう。",
                hiragana: "たんじょうびおめでとう",
                koreanSentence: "생일 축하해요.",
                romaji: "Tanjōbi omedetō",
                koreanPronunciation: "탄죠-비 오메데토-",
                grammar: "친한 사이의 생일 축하 표현입니다. 정중하게는 誕生日おめでとうございます(탄죠-비 오메데토-고자이마스)라고 합니다. おめでとう는 축하할 때 사용하는 기본 표현입니다."
            ),
            JapanesePhrase(
                id: 184,
                japaneseSentence: "本当ですか？",
                hiragana: "ほんとうですか？",
                koreanSentence: "정말이에요?",
                romaji: "Hontō desu ka?",
                koreanPronunciation: "혼토-데스카?",
                grammar: "본当(ほんとう)(정말, 진짜)라는 명사에 ですか？를 붙여 놀랍거나 의외의 일을 들었을 때 확인하는 표현입니다. 일상 대화에서 매우 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 185,
                japaneseSentence: "体調はどうですか？",
                hiragana: "たいちょうはどうですか？",
                koreanSentence: "몸 상태는 어때요?",
                romaji: "Taichō wa dō desu ka?",
                koreanPronunciation: "타이쵸-와 도-데스카?",
                grammar: "体調(たいちょう)는 '몸 상태, 컨디션'이라는 뜻입니다. 아픈 사람이나 피곤해 보이는 사람에게 안부를 물을 때 사용하는 배려 있는 표현입니다."
            ),
            JapanesePhrase(
                id: 186,
                japaneseSentence: "薬を飲んだほうがいいですよ。",
                hiragana: "くすりをのんだほうがいいですよ",
                koreanSentence: "약을 먹는 게 좋겠어요.",
                romaji: "Kusuri o nonda hō ga ii desu yo",
                koreanPronunciation: "쿠스리오 논다 호-가 이-데스요",
                grammar: "동사의 과거형(た형) + ほうがいいですよ는 '~하는 편이 좋겠어요'라고 조언하는 표현입니다. 薬を飲む(くすりをのむ)는 '약을 먹다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 187,
                japaneseSentence: "天気がいいですね。",
                hiragana: "てんきがいいですね",
                koreanSentence: "날씨가 좋네요.",
                romaji: "Tenki ga ii desu ne",
                koreanPronunciation: "텐키가 이-데스네",
                grammar: "날씨를 화제로 삼아 대화를 시작하는 일반적인 표현입니다. 天気(てんき)는 '날씨'라는 뜻이며, いい는 '좋다'라는 형용사입니다. 문장 끝의 ね는 상대방의 동의를 구합니다."
            ),
            JapanesePhrase(
                id: 188,
                japaneseSentence: "楽しい週末を。",
                hiragana: "たのしいしゅうまつを",
                koreanSentence: "즐거운 주말 보내세요.",
                romaji: "Tanoshii shūmatsu o",
                koreanPronunciation: "타노시- 슈-마츠오",
                grammar: "주말 전 헤어질 때 사용하는 인사입니다. '楽しい週末を過ごしてください'를 줄인 표현으로, 뒤의 동사를 생략해도 의미가 통합니다."
            ),
            JapanesePhrase(
                id: 189,
                japaneseSentence: "もうこんな時間。",
                hiragana: "もうこんなじかん",
                koreanSentence: "벌써 이런 시간이네요.",
                romaji: "Mō konna jikan",
                koreanPronunciation: "모- 콘나 지칸",
                grammar: "시간이 빨리 지나갔음을 나타내는 자연스러운 표현입니다. もう는 '벌써', こんな는 '이런'이라는 뜻입니다. 뒤에 ですね를 붙이거나 そのまま로 끝낼 수 있습니다."
            ),
            JapanesePhrase(
                id: 190,
                japaneseSentence: "充実した一日でした。",
                hiragana: "じゅうじつしたいちにちでした",
                koreanSentence: "충실한 하루였어요.",
                romaji: "Jūjitsu shita ichinichi deshita",
                koreanPronunciation: "쥬-지츠시타 이치니치데시타",
                grammar: "充実する(じゅうじつする)는 '충실하다, 알차다'는 뜻입니다. した는 する동사의 과거 연체형으로, 명사 앞에서 수식할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 191,
                japaneseSentence: "最近どうですか？",
                hiragana: "さいきんどうですか？",
                koreanSentence: "요즘 어때요?",
                romaji: "Saikin dō desu ka?",
                koreanPronunciation: "사이킨 도-데스카?",
                grammar: "오랜만에 만난 사람에게 안부를 묻는 일반적인 표현입니다. 最近(さいきん)는 '최근, 요즘'이라는 뜻입니다. 대답으로는 まあまあです(그럭저럭이에요) 등을 사용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 192,
                japaneseSentence: "そういうことですか。",
                hiragana: "そういうことですか",
                koreanSentence: "그런 것이군요. / 그런 의미였군요.",
                romaji: "Sō iu koto desu ka",
                koreanPronunciation: "소-유-코토데스카",
                grammar: "상대방의 설명을 듣고 이해했을 때 사용하는 표현입니다. そういう는 '그런', こと는 '것, 일'이라는 뜻입니다. 깨달음이나 납득의 뉘앙스가 담겨 있습니다."
            ),
            JapanesePhrase(
                id: 193,
                japaneseSentence: "緊張しています。",
                hiragana: "きんちょうしています",
                koreanSentence: "긴장돼요.",
                romaji: "Kinchō shite imasu",
                koreanPronunciation: "킨쵸-시테이마스",
                grammar: "긴장하다'라는 する동사 緊張する(きんちょうする)의 현재진행형입니다. 중요한 발표나 면접 전에 자신의 상태를 표현할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 194,
                japaneseSentence: "変ですね。",
                hiragana: "へんですね",
                koreanSentence: "이상하네요.",
                romaji: "Hen desu ne",
                koreanPronunciation: "헨데스네",
                grammar: "변(へん)은 '이상하다, 평소와 다르다'는 뜻의 な형용사입니다. 무언가 비정상적이거나 예상과 다른 상황을 목격했을 때 사용합니다."
            ),
            JapanesePhrase(
                id: 195,
                japaneseSentence: "彼女がいます。",
                hiragana: "かのじょがいます",
                koreanSentence: "여자친구가 있어요.",
                romaji: "Kanojo ga imasu",
                koreanPronunciation: "카노죠가 이마스",
                grammar: "彼女(かのじょ)는 '그녀' 또는 '여자친구'라는 뜻입니다. いる는 사람이나 동물이 존재할 때 사용하는 동사입니다. 남자친구는 彼氏(かれし)가 います라고 합니다."
            ),
            JapanesePhrase(
                id: 196,
                japaneseSentence: "髪を切りました。",
                hiragana: "かみをきりました",
                koreanSentence: "머리를 잘랐어요.",
                romaji: "Kami o kirimashita",
                koreanPronunciation: "카미오 키리마시타",
                grammar: "髪(かみ)는 '머리카락', 切る(きる)는 '자르다'라는 동사입니다. 외모 변화를 알릴 때 사용하는 일반적인 표현입니다. 상대방이 머리를 자른 것을 알아차렸을 때 髪、切りましたね라고 물어볼 수 있습니다."
            ),
            JapanesePhrase(
                id: 197,
                japaneseSentence: "ATMはどこですか？",
                hiragana: "ATMはどこですか？",
                koreanSentence: "ATM은 어디에 있나요?",
                romaji: "ATM wa doko desu ka?",
                koreanPronunciation: "에이티엠와 도코데스카?",
                grammar: "은행 현금자동입출금기의 위치를 묻는 필수 표현입니다. 일본에서는 ATM을 그대로 사용하며, コンビニ(편의점)에도 ATM이 설치되어 있는 경우가 많습니다."
            ),
            JapanesePhrase(
                id: 198,
                japaneseSentence: "お弁当を温めますか？",
                hiragana: "おべんとうをあたためますか？",
                koreanSentence: "도시락 데워드릴까요?",
                romaji: "Obentō o atatamemasu ka?",
                koreanPronunciation: "오벤토-오 아타타메마스카?",
                grammar: "편의점에서 직원이 도시락을 구매하는 손님에게 묻는 기본 서비스 문구입니다. 温める(あたためる)는 '데우다'라는 동사입니다."
            ),
            JapanesePhrase(
                id: 199,
                japaneseSentence: "ポイントカードはありますか？",
                hiragana: "ポイントカードはありますか？",
                koreanSentence: "포인트 카드 있으신가요?",
                romaji: "Pointo kādo wa arimasu ka?",
                koreanPronunciation: "포인토 카-도와 아리마스카?",
                grammar: "일본 가게에서 계산할 때 자주 듣는 질문입니다. ポイントカード는 적립 카드를 의미하며, 없을 때는 ありません(아리마셍) 또는 ないです(나이데스)라고 답합니다."
            ),
            JapanesePhrase(
                id: 200,
                japaneseSentence: "お手数ですが。",
                hiragana: "おてすうですが",
                koreanSentence: "번거로우시겠지만.",
                romaji: "Otesū desu ga",
                koreanPronunciation: "오테스-데스가",
                grammar: "상대방에게 부탁할 때 앞에 붙이는 정중한 표현입니다. お手数(おてすう)는 '수고, 번거로움'이라는 뜻입니다. 뒤에는 보통 부탁하는 내용이 이어집니다."
            ),
            JapanesePhrase(
                id: 201,
                japaneseSentence: "お疲れ様です。",
                hiragana: "おつかれさまです",
                koreanSentence: "수고하세요.",
                romaji: "Otsukaresama desu",
                koreanPronunciation: "오츠카레사마데스",
                grammar: "일본 직장에서 가장 많이 사용하는 인사말입니다. 출근 시, 퇴근 시, 동료를 만날 때 모두 사용할 수 있는 만능 인사입니다. でした로 끝내면 퇴근하는 사람에게 하는 인사가 됩니다."
            ),
            JapanesePhrase(
                id: 202,
                japaneseSentence: "どれにしますか？",
                hiragana: "どれにしますか？",
                koreanSentence: "어느 것으로 하시겠어요?",
                romaji: "Dore ni shimasu ka?",
                koreanPronunciation: "도레니 시마스카?",
                grammar: "どれ는 '어느 것'이라는 의문사입니다. 여러 개 중에서 선택을 요청할 때 사용합니다. 대답할 때는 これにします(이걸로 할게요) 등으로 답합니다."
            ),
            JapanesePhrase(
                id: 203,
                japaneseSentence: "賛成です。",
                hiragana: "さんせいです",
                koreanSentence: "찬성이에요.",
                romaji: "Sansei desu",
                koreanPronunciation: "산세-데스",
                grammar: "賛成(さんせい)는 '찬성'이라는 명사입니다. 상대방의 의견이나 제안에 동의할 때 사용합니다. 반대는 反対です(한타이데스)라고 합니다."
            ),
            JapanesePhrase(
                id: 204,
                japaneseSentence: "お会計は別々で。",
                hiragana: "おかいけいはべつべつで",
                koreanSentence: "계산은 따로 해주세요.",
                romaji: "Okaikei wa betsubetsu de",
                koreanPronunciation: "오카이케-와 베츠베츠데",
                grammar: "お会計(おかいけい)는 '계산'의 정중한 표현입니다. 別々(べつべつ)는 '따로따로'라는 의미입니다. 식당에서 더치페이를 요청할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 205,
                japaneseSentence: "税込みですか？",
                hiragana: "ぜいこみですか？",
                koreanSentence: "세금 포함인가요?",
                romaji: "Zeikomi desu ka?",
                koreanPronunciation: "제이코미데스카?",
                grammar: "税込み(ぜいこみ)는 '세금 포함'이라는 뜻입니다. 가격 표시가 세금을 포함한 것인지 확인할 때 사용합니다. 반대는 税抜き(ぜいぬき)(세금 별도)입니다."
            ),
            JapanesePhrase(
                id: 206,
                japaneseSentence: "新鮮ですね。",
                hiragana: "しんせんですね",
                koreanSentence: "신선하네요.",
                romaji: "Shinsen desu ne",
                koreanPronunciation: "신센데스네",
                grammar: "新鮮(しんせん)은 '신선하다'는 な형용사입니다. 음식이나 아이디어, 경험 등이 새롭고 좋을 때 사용합니다. 특히 스시나 사시미를 먹을 때 자주 사용합니다."
            ),
            JapanesePhrase(
                id: 207,
                japaneseSentence: "お先に。",
                hiragana: "おさきに",
                koreanSentence: "먼저요. / 먼저 갈게요.",
                romaji: "Osaki ni",
                koreanPronunciation: "오사키니",
                grammar: "お先に失礼します의 축약형입니다. 매우 친한 동료나 친구 사이에서 퇴근할 때 간단히 사용할 수 있습니다. 격식을 차려야 하는 상황에서는 완전한 문장을 사용하세요."
            ),
            JapanesePhrase(
                id: 208,
                japaneseSentence: "今度の週末、何か予定はありますか？",
                hiragana: "こんどのしゅうまつ、なにかよていはありますか？",
                koreanSentence: "이번 주말에 무슨 계획 있어요?",
                romaji: "Kondo no shūmatsu, nanika yotei wa arimasu ka?",
                koreanPronunciation: "콘도노 슈-마츠, 나니카 요테이와 아리마스카?",
                grammar: "상대방의 주말 계획을 묻는 사교적인 질문입니다. 今度(こんど)는 '이번', 週末(しゅうまつ)는 '주말', 何か(なにか)는 '무언가', 予定(よてい)는 '예정, 계획'이라는 뜻입니다. 친구나 동료와의 일상 대화에서 자주 사용됩니다."
            ),
            JapanesePhrase(
                id: 209,
                japaneseSentence: "特にないです。",
                hiragana: "とくにないです",
                koreanSentence: "딱히 없어요.",
                romaji: "Toku ni nai desu",
                koreanPronunciation: "토쿠니 나이데스",
                grammar: "208번 질문에 대한 대표적인 답변입니다. 特に(とくに)는 '특별히'라는 뜻의 부사이며, ないです는 '없습니다'라는 뜻입니다. 別に보다 조금 더 정중하고 부드러운 느낌을 줍니다."
            ),
            JapanesePhrase(
                id: 210,
                japaneseSentence: "映画でも見に行きませんか？",
                hiragana: "えいがでもみにいきませんか？",
                koreanSentence: "영화라도 보러 가지 않을래요?",
                romaji: "Eiga demo mi ni ikimasen ka?",
                koreanPronunciation: "에-가데모 미니 이키마셍카?",
                grammar: "[명사] + でも(~라도)와 ~ませんか？(~하지 않겠어요?)를 결합한 부드러운 제안 표현입니다. 見に行く(みにいく)는 '보러 가다'라는 뜻의 복합 동사입니다."
            ),
            JapanesePhrase(
                id: 211,
                japaneseSentence: "お水を一杯ください。",
                hiragana: "おみずをいっぱいください",
                koreanSentence: "물 한 잔 주세요.",
                romaji: "O-mizu o ippai kudasai",
                koreanPronunciation: "오미즈오 입빠이 쿠다사이",
                grammar: "식당에서 물을 요청할 때 사용합니다. 水(みず)에 정중함을 더하는 お를 붙였습니다. 一杯(いっぱい)는 '한 잔'이라는 뜻의 수량사입니다."
            ),
            JapanesePhrase(
                id: 212,
                japaneseSentence: "塩を取ってください。",
                hiragana: "しをとってください",
                koreanSentence: "소금 좀 건네주시겠어요?",
                romaji: "Shio o totte kudasai",
                koreanPronunciation: "시오오 톳테 쿠다사이",
                grammar: "식탁에서 멀리 있는 조미료 등을 건네 달라고 요청할 때 사용합니다. 塩(しお)는 '소금', 取る(とる)는 '집다, 잡다'라는 뜻의 동사입니다. て형+ください 형태로 정중하게 요청합니다."
            ),
            JapanesePhrase(
                id: 213,
                japaneseSentence: "写真を撮りましょうか？",
                hiragana: "しゃしんをとりましょうか？",
                koreanSentence: "사진 찍어드릴까요?",
                romaji: "Shashin o torimashō ka?",
                koreanPronunciation: "샤신오 토리마쇼-카?",
                grammar: "동사의 ます형 + ましょうか？는 '제가 ~해드릴까요?'라고 도움을 제안하는 정중한 표현입니다. 撮る(とる)는 '찍다'는 동사입니다."
            ),
            JapanesePhrase(
                id: 214,
                japaneseSentence: "もう少しゆっくり歩いてください。",
                hiragana: "もうすこしゆっくりあるいてください",
                koreanSentence: "좀 더 천천히 걸어주세요.",
                romaji: "Mō sukoshi yukkuri aruite kudasai",
                koreanPronunciation: "모- 스코시 육쿠리 아루이테 쿠다사이",
                grammar: "もう少し(もうすこし)는 '조금만 더'라는 뜻입니다. 歩く(あるく)(걷다) 동사의 て형+ください 형태로, 상대방에게 보조를 맞춰달라고 정중하게 요청하는 표현입니다."
            ),
            JapanesePhrase(
                id: 215,
                japaneseSentence: "道に迷ったみたいです。",
                hiragana: "みちにまよったみたいです",
                koreanSentence: "길을 잃은 것 같아요.",
                romaji: "Michi ni mayotta mitai desu",
                koreanPronunciation: "미치니 마욧타 미타이데스",
                grammar: "~みたいです는 '~인 것 같습니다'라는 부드러운 추측을 나타내는 표현입니다. 道に迷いました(길을 잃었어요)보다 덜 단정적이어서, 불확실한 상황을 설명할 때 사용하기 좋습니다."
            ),
            JapanesePhrase(
                id: 216,
                japaneseSentence: "駅までどのくらいですか？",
                hiragana: "えきまでどのくらいですか？",
                koreanSentence: "역까지는 어느 정도예요? (시간/거리)",
                romaji: "Eki made dono kurai desu ka?",
                koreanPronunciation: "에키마데 도노쿠라이데스카?",
                grammar: "~まで(까지) + どのくらい(어느 정도) + ですか？ 패턴으로, 목적지까지의 시간이나 거리를 간결하게 물어볼 수 있습니다."
            ),
            JapanesePhrase(
                id: 217,
                japaneseSentence: "現金しか使えませんか？",
                hiragana: "げんきんしかつかえませんか？",
                koreanSentence: "현금밖에 사용할 수 없나요?",
                romaji: "Genkin shika tsukaemasen ka?",
                koreanPronunciation: "겐킨시카 츠카에마셍카?",
                grammar: "~しか + 부정형(~ません)은 '~밖에 ~없다'라는 한정을 나타내는 중요한 문법입니다. 現金(げんきん)(현금)밖에 안되는지 확인할 때 사용합니다. 使えません(つかえません)은 使う(사용하다)의 가능형 부정입니다."
            ),
            JapanesePhrase(
                id: 218,
                japaneseSentence: "これ、温めてください。",
                hiragana: "これ、あたためてください",
                koreanSentence: "이거, 데워주세요.",
                romaji: "Kore, atatamete kudasai",
                koreanPronunciation: "코레, 아타타메테 쿠다사이",
                grammar: "편의점에서 도시락이나 음식을 데워달라고 요청할 때 사용하는 필수 표현입니다. 温める(あたためる)는 '데우다, 따뜻하게 하다'는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 219,
                japaneseSentence: "袋は結構です。",
                hiragana: "ふくろはけっこうです",
                koreanSentence: "봉투는 괜찮아요. (필요 없어요)",
                romaji: "Fukuro wa kekkō desu",
                koreanPronunciation: "후쿠로와 켓코-데스",
                grammar: "편의점이나 가게에서 비닐봉지나 종이봉투가 필요 없음을 나타낼 때 사용합니다. 袋(ふくろ)는 '봉투, 봉지'라는 뜻이며, 結構です는 정중한 사양을 나타냅니다."
            ),
            JapanesePhrase(
                id: 220,
                japaneseSentence: "伝言をお願いできますか？",
                hiragana: "でんごんをおねがいできますか？",
                koreanSentence: "메시지를 부탁드릴 수 있을까요?",
                romaji: "Dengon o onegai dekimasu ka?",
                koreanPronunciation: "덴곤오 오네가이데키마스카?",
                grammar: "전화 통화 중 상대방이 부재중일 때 메시지를 남기고 싶을 때 사용합니다. 伝言(でんごん)은 '전하는 말, 메시지'라는 뜻입니다. ~をお願いします보다 ~をお願いできますか？가 '제가 ~을 부탁하는 것이 가능할까요?'라는 의미로 한층 더 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 221,
                japaneseSentence: "そんなに難しくないです。",
                hiragana: "そんなにむずしくないです",
                koreanSentence: "그렇게 어렵지 않아요.",
                romaji: "Sonna ni muzukashiku nai desu",
                koreanPronunciation: "손나니 무즈카시쿠 나이데스",
                grammar: "そんなに는 '그렇게, 그다지'라는 뜻의 부사로, 주로 뒤에 부정형이 와서 '그렇게까지 ~하지는 않다'는 의미를 나타냅니다. 難しい(むずかしい)는 '어렵다'는 い형용사입니다."
            ),
            JapanesePhrase(
                id: 222,
                japaneseSentence: "心配をかけてすみません。",
                hiragana: "しんぱいをかけてすみません",
                koreanSentence: "걱정 끼쳐서 죄송합니다.",
                romaji: "Shinpai o kakete sumimasen",
                koreanPronunciation: "심파이오 카케테 스미마셍",
                grammar: "心配をかける(しんぱいをかける)는 '걱정을 끼치다'라는 뜻의 관용구입니다. 자신의 일로 인해 상대방이 걱정했을 때, 그에 대해 사과하는 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 223,
                japaneseSentence: "説明してください。",
                hiragana: "せつめいしてください",
                koreanSentence: "설명해주세요.",
                romaji: "Setsumei shite kudasai",
                koreanPronunciation: "세츠메-시테 쿠다사이",
                grammar: "잘 모르는 것이나 이해가 안 가는 부분에 대해 설명을 요청할 때 사용합니다. '설명하다'라는 동사 説明する(せつめいする)의 て형 + ください 형태입니다."
            ),
            JapanesePhrase(
                id: 224,
                japaneseSentence: "意味が分かりません。",
                hiragana: "いみがわかりません",
                koreanSentence: "의미를 모르겠어요.",
                romaji: "Imi ga wakarimasen",
                koreanPronunciation: "이미가 와카리마셍",
                grammar: "단어나 문장의 뜻을 이해하지 못했음을 직접적으로 표현하는 말입니다. 意味(いみ)는 '의미, 뜻'이라는 명사입니다."
            ),
            JapanesePhrase(
                id: 225,
                japaneseSentence: "何か手伝うことはありますか？",
                hiragana: "なにかてつだうことはありますか？",
                koreanSentence: "뭔가 도와드릴 일이 있나요?",
                romaji: "Nani ka tetsudau koto wa arimasu ka?",
                koreanPronunciation: "나니카 테츠다우 코토와 아리마스카?",
                grammar: "상대방이 바빠 보일 때, 먼저 나서서 도움을 제안하는 매우 적극적이고 친절한 표현입니다. 手伝うこと(てつだうこと)는 '돕는 것(일)'이라는 의미의 명사구입니다."
            ),
            JapanesePhrase(
                id: 226,
                japaneseSentence: "傘を貸してください。",
                hiragana: "かさをかしてください",
                koreanSentence: "우산 좀 빌려주세요.",
                romaji: "Kasa o kashite kudasai",
                koreanPronunciation: "카사오 카시테 쿠다사이",
                grammar: "貸す(かす)는 '빌려주다'는 뜻의 동사입니다. て형 + ください 형태로, 무언가를 빌려달라고 정중하게 요청할 수 있습니다."
            ),
            JapanesePhrase(
                id: 227,
                japaneseSentence: "充電してもいいですか？",
                hiragana: "じゅうでんしてもいいですか？",
                koreanSentence: "충전해도 될까요?",
                romaji: "Jūden shite mo ii desu ka?",
                koreanPronunciation: "쥬-덴시테모 이-데스카?",
                grammar: "현대 생활의 필수 표현입니다. 充電する(じゅうでんする)는 '충전하다'는 동사이며, ~てもいいですか 패턴을 사용해 허락을 구합니다."
            ),
            JapanesePhrase(
                id: 228,
                japaneseSentence: "コンセントはどこですか？",
                hiragana: "コンセントはどこですか？",
                koreanSentence: "콘센트는 어디에 있나요?",
                romaji: "Konsento wa doko desu ka?",
                koreanPronunciation: "콘센토와 도코데스카?",
                grammar: "227번 질문에 이어, 또는 단독으로 전기 콘센트의 위치를 물을 때 사용합니다. 일본에서 '콘센트'는 영어의 'Outlet' 또는 'Socket'에 해당하는 단어로 널리 쓰입니다."
            ),
            JapanesePhrase(
                id: 229,
                japaneseSentence: "タクシーを呼んでください。",
                hiragana: "タクシーをよんでください",
                koreanSentence: "택시를 불러주세요.",
                romaji: "Takushī o yonde kudasai",
                koreanPronunciation: "타쿠시-오 욘데 쿠다사이",
                grammar: "호텔 프런트나 식당 등에 택시를 호출해달라고 부탁할 때 사용합니다. 呼ぶ(よぶ)는 '부르다'는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 230,
                japaneseSentence: "頭がぼーっとします。",
                hiragana: "あたまがぼーっとします",
                koreanSentence: "머리가 멍해요.",
                romaji: "Atama ga bōtto shimasu",
                koreanPronunciation: "아타마가 보-옷토시마스",
                grammar: "ぼーっとする는 '멍하다, 몽롱하다'는 상태를 나타내는 의태어 동사입니다. 피곤하거나, 약 기운이 있거나, 생각에 잠겨 있을 때 등 머리가 명확하게 작동하지 않는 상태를 표현합니다."
            ),
            JapanesePhrase(
                id: 231,
                japaneseSentence: "どちらかというと、犬のほうが好きです。",
                hiragana: "どちらかというと、いぬのほうがすきです",
                koreanSentence: "굳이 따지자면, 개 쪽을 더 좋아해요.",
                romaji: "Dochira ka to iu to, inu no hō ga suki desu",
                koreanPronunciation: "도치라카토 유-토, 이누노 호-가 스키데스",
                grammar: "どちらかというと는 '어느 쪽인가 하면', 즉 '굳이 고르자면'이라는 의미의 관용구입니다. 자신의 선호를 단정적으로 말하기보다, 조금 더 부드럽고 신중하게 표현하고 싶을 때 사용합니다."
            ),
            JapanesePhrase(
                id: 232,
                japaneseSentence: "見たことがあります。",
                hiragana: "みたことがあります",
                koreanSentence: "본 적 있어요.",
                romaji: "Mita koto ga arimasu",
                koreanPronunciation: "미타 코토가 아리마스",
                grammar: "동사의 과거형(た형) + ことがあります는 '~한 적이 있다'고 과거의 경험을 나타내는 중요한 문법입니다. 見る(보다)의 과거형 見た를 사용했습니다."
            ),
            JapanesePhrase(
                id: 233,
                japaneseSentence: "聞いたことがあります。",
                hiragana: "きいたことがあります",
                koreanSentence: "들어본 적 있어요.",
                romaji: "Kiita koto ga arimasu",
                koreanPronunciation: "키-타 코토가 아리마스",
                grammar: "232번과 같은 패턴으로, '들은 경험'을 나타냅니다. 聞く(듣다)의 과거형 聞いた를 사용했습니다. (부정형: 聞いたことがありません - 들어본 적 없어요)"
            ),
            JapanesePhrase(
                id: 234,
                japaneseSentence: "静かにしてください。",
                hiragana: "しずかにしてください",
                koreanSentence: "조용히 해주세요.",
                romaji: "Shizuka ni shite kudasai",
                koreanPronunciation: "시즈카니 시테 쿠다사이",
                grammar: "な형용사를 부사로 만들 때는 뒤에 に를 붙입니다. 静か(しずか)(조용함)가 静かに(조용히)가 됩니다. 여기에 してください를 붙여 '조용히 하는 상태로 있어달라'고 요청하는 것입니다."
            ),
            JapanesePhrase(
                id: 235,
                japaneseSentence: "触らないでください。",
                hiragana: "さわらないでください",
                koreanSentence: "만지지 마세요.",
                romaji: "Sawaranaide kudasai",
                koreanPronunciation: "사와라나이데 쿠다사이",
                grammar: "동사의 ない형 + でください(~하지 말아주세요) 패턴입니다. 触る(さわる)는 '만지다, 손을 대다'라는 뜻의 동사입니다. 박물관이나 가게 등에서 사용될 수 있습니다."
            ),
            JapanesePhrase(
                id: 236,
                japaneseSentence: "ここに荷物を置いてもいいですか？",
                hiragana: "ここにもつをおいてもいいですか？",
                koreanSentence: "여기에 짐을 둬도 될까요?",
                romaji: "Koko ni nimotsu o oite mo ii desu ka?",
                koreanPronunciation: "코코니 니모츠오 오이테모 이-데스카?",
                grammar: "~てもいいですか(~해도 괜찮을까요?) 허락 구하기 패턴입니다. 置く(おく)는 '두다, 놓다'라는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 237,
                japaneseSentence: "次の電車は何時ですか？",
                hiragana: "つぎのでんしゃはなんじですか？",
                koreanSentence: "다음 전철은 몇 시예요?",
                romaji: "Tsugi no densha wa nan-ji desu ka?",
                koreanPronunciation: "츠기노 덴샤와 난지데스카?",
                grammar: "次(つぎ)の는 '다음의'라는 뜻입니다. 何時(なんじ)(몇 시)를 사용하여 교통수단의 출발 시각을 묻는 필수 표현입니다."
            ),
            JapanesePhrase(
                id: 238,
                japaneseSentence: "この電車は渋谷に行きますか？",
                hiragana: "このでんしゃはしぶやにいきますか？",
                koreanSentence: "이 전철은 시부야에 가나요?",
                romaji: "Kono densha wa Shibuya ni ikimasu ka?",
                koreanPronunciation: "코노 덴샤와 시부야니 이키마스카?",
                grammar: "[교통수단]は[장소]に行きますか？ 패턴으로, 행선지를 확인할 때 사용합니다. 일본 여행 시 매우 유용한 질문입니다."
            ),
            JapanesePhrase(
                id: 239,
                japaneseSentence: "PASMOにチャージしてください。",
                hiragana: "パスモにチャージしてください",
                koreanSentence: "파스모에 충전해주세요.",
                romaji: "Pasumo ni chāji shite kudasai",
                koreanPronunciation: "파스모니 챠-지시테 쿠다사이",
                grammar: "일본의 교통카드(IC카드)를 충전할 때 사용하는 표현입니다. チャージする는 '충전하다'는 뜻의 외래어 동사입니다. PASMO 외에 Suica(スイカ) 등 다른 카드 이름을 넣어도 됩니다."
            ),
            JapanesePhrase(
                id: 240,
                japaneseSentence: "喫煙はご遠慮ください。",
                hiragana: "きつえんはごえんりょください",
                koreanSentence: "흡연은 삼가주세요.",
                romaji: "Kitsuen wa go-enryo kudasai",
                koreanPronunciation: "키츠엔와 고엔료쿠다사이",
                grammar: "~てはいけません보다 훨씬 더 정중하고 격식 있는 금지 표현입니다. ご遠慮ください(ごえんりょください)는 '삼가주십시오'라는 뜻으로, 안내문 등에서 자주 볼 수 있습니다. 喫煙(きつえん)은 '흡연'입니다."
            ),
            JapanesePhrase(
                id: 241,
                japaneseSentence: "そんなつもりじゃなかったです。",
                hiragana: "そんなつもりじゃなかったです",
                koreanSentence: "그럴 생각(의도)은 아니었어요.",
                romaji: "Sonna tsumori ja nakatta desu",
                koreanPronunciation: "손나 츠모리쟈 나캇타데스",
                grammar: "자신의 말이나 행동이 오해를 샀을 때, 본래의 의도는 그렇지 않았음을 해명하는 표현입니다. つもり는 '의도, 생각, 작정'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 242,
                japaneseSentence: "わざとじゃないです。",
                hiragana: "わざとじゃないです",
                koreanSentence: "일부러 그런 게 아니에요.",
                romaji: "Wazato ja nai desu",
                koreanPronunciation: "와자토쟈 나이데스",
                grammar: "실수로 무언가 잘못했을 때, 고의가 아님을 강조하는 표현입니다. わざと는 '일부러, 고의로'라는 뜻의 부사입니다. ~じゃないです는 '~이/가 아닙니다'라는 부정형입니다."
            ),
            JapanesePhrase(
                id: 243,
                japaneseSentence: "私のせいです。",
                hiragana: "わたしのせいです",
                koreanSentence: "제 탓이에요.",
                romaji: "Watashi no sei desu",
                koreanPronunciation: "와타시노 세-데스",
                grammar: "어떤 잘못된 결과에 대해 자신의 책임임을 인정하는 표현입니다. せい는 '~탓, ~때문'이라는 부정적인 원인을 나타냅니다. 긍정적인 원인을 나타내는 おかげ(덕분)와는 반대되는 개념입니다."
            ),
            JapanesePhrase(
                id: 244,
                japaneseSentence: "気にしないでください。",
                hiragana: "きにしないでください",
                koreanSentence: "신경 쓰지 마세요.",
                romaji: "Ki ni shinaide kudasai",
                koreanPronunciation: "키니 시나이데 쿠다사이",
                grammar: "상대방이 미안해하거나 걱정할 때, 괜찮다고 안심시키는 표현입니다. 気にする(きにする)는 '신경 쓰다, 마음에 두다'라는 관용구이며, ~ないでください(~하지 말아주세요) 패턴을 사용했습니다."
            ),
            JapanesePhrase(
                id: 245,
                japaneseSentence: "もう一度、説明してください。",
                hiragana: "もういちど、せつめいしてください",
                koreanSentence: "다시 한번, 설명해주세요.",
                romaji: "Mō ichido, setsumei shite kudasai",
                koreanPronunciation: "모- 이치도, 세츠메-시테 쿠다사이",
                grammar: "상대방의 설명을 이해하지 못했을 때 다시 요청하는 표현입니다. もう一度(もういちど)는 '한 번 더', 説明する(せつめいする)는 '설명하다'는 동사입니다."
            ),
            JapanesePhrase(
                id: 246,
                japaneseSentence: "この近くに、いいレストランはありますか？",
                hiragana: "このちかくに、いいレストランはありますか？",
                koreanSentence: "이 근처에 좋은 식당 있어요?",
                romaji: "Kono chikaku ni, ii resutoran wa arimasu ka?",
                koreanPronunciation: "코노 치카쿠니, 이- 레스토랑와 아리마스카?",
                grammar: "현지인에게 맛집을 추천받고 싶을 때 유용한 질문입니다. この近く(このちかく)는 '이 근처'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 247,
                japaneseSentence: "予約したキムです。",
                hiragana: "よやくしたキムです",
                koreanSentence: "예약한 김입니다.",
                romaji: "Yoyaku shita Kimu desu",
                koreanPronunciation: "요야쿠시타 키무데스",
                grammar: "식당이나 호텔에 도착해서 예약자임을 밝힐 때 사용합니다. 予約した(よやくした)는 '예약했다'는 과거형으로, 뒤에 오는 이름(キム)을 수식하여 '예약한 김'이라는 의미를 만듭니다."
            ),
            JapanesePhrase(
                id: 248,
                japaneseSentence: "何か飲むものはいかがですか？",
                hiragana: "なにかのむものはいかがですか？",
                koreanSentence: "뭐 마실 거라도 드릴까요?",
                romaji: "Nani ka nomu mono wa ikaga desu ka?",
                koreanPronunciation: "나니카 노무모노와 이카가데스카?",
                grammar: "집에 온 손님 등에게 무언가를 대접할 때 사용하는 정중하고 세련된 표현입니다. 飲むもの(のむもの)는 '마실 것'이며, ~はいかがですか는 ~はどうですか(~은 어때요?)보다 더 격식 있는 권유 표현입니다."
            ),
            JapanesePhrase(
                id: 249,
                japaneseSentence: "どうぞ、お構いなく。",
                hiragana: "どうぞ、おかまいなく",
                koreanSentence: "부디, 신경 쓰지 마세요. (괜찮습니다)",
                romaji: "Dōzo, o-kamai naku",
                koreanPronunciation: "도-조, 오카마이나쿠",
                grammar: "상대방이 자신을 위해 무언가 대접하거나 신경 써주려고 할 때, '그런 수고를 하지 않으셔도 괜찮다'고 사양하는 정중한 표현입니다. 構う(かまう)는 '상관하다, 신경 쓰다'는 동사에서 왔습니다."
            ),
            JapanesePhrase(
                id: 250,
                japaneseSentence: "そろそろ帰らないと。",
                hiragana: "そろそろかえらないと",
                koreanSentence: "슬슬 돌아가지 않으면 (안 되겠네).",
                romaji: "Sorosoro kaeranai to",
                koreanPronunciation: "소로소로 카에라나이토",
                grammar: "~ないといけない(~하지 않으면 안 된다)의 줄임말로, 혼잣말처럼 사용하며 자리를 떠야 할 때를 암시하는 구어적인 표현입니다. そろそろ失礼します보다 덜 형식적입니다."
            ),
            JapanesePhrase(
                id: 251,
                japaneseSentence: "ポイントカードはありますか？",
                hiragana: "ポイントカードはありますか？",
                koreanSentence: "포인트 카드 있으세요?",
                romaji: "Pointo kādo wa arimasu ka?",
                koreanPronunciation: "포인토카-도와 아리마스카?",
                grammar: "일본의 가게에서 물건을 살 때 점원이 거의 반드시 묻는 질문입니다. ポイントカード는 '포인트 카드' 또는 '멤버십 카드'를 의미합니다."
            ),
            JapanesePhrase(
                id: 252,
                japaneseSentence: "袋にお入れしますか？",
                hiragana: "ふくろにおいれしますか？",
                koreanSentence: "봉투에 넣어드릴까요?",
                romaji: "Fukuro ni o-ire shimasu ka?",
                koreanPronunciation: "후쿠로니 오이레시마스카?",
                grammar: "점원이 손님에게 하는 정중한 질문입니다. 袋(ふくろ)는 '봉투'이며, お入れしますか는 '넣다'는 동사 入れる(いれる)의 겸양 표현으로, '제가 넣어 드릴까요?'라는 겸손의 뉘앙스를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 253,
                japaneseSentence: "別々でお願いします。",
                hiragana: "べつべつでおねがいします",
                koreanSentence: "따로따로 부탁합니다.",
                romaji: "Betsu betsu de onegai shimasu",
                koreanPronunciation: "베츠베츠데 오네가이시마스",
                grammar: "여러 사람이 함께 식사하고 각자 계산(더치페이)할 때 사용하는 필수 표현입니다. 別々(べつべつ)는 '각각, 따로따로'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 254,
                japaneseSentence: "一緒でお願いします。",
                hiragana: "いっしょでおねがいします",
                koreanSentence: "함께 부탁합니다.",
                romaji: "Issho de onegai shimasu",
                koreanPronunciation: "잇쇼데 오네가이시마스",
                grammar: "253번의 반대 표현으로, 여러 사람의 계산을 한 번에 할 때 사용합니다. 一緒(いっしょ)는 '함께, 같이'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 255,
                japaneseSentence: "ご意見を聞かせてください。",
                hiragana: "ごいけんをきかせてください",
                koreanSentence: "의견을 들려주세요.",
                romaji: "Go-iken o kikasete kudasai",
                koreanPronunciation: "고이켄오 키카세테 쿠다사이",
                grammar: "どう思いますか보다 더 정중하고 격식 있게 상대방의 의견을 구할 때 사용합니다. 意見(いけん)(의견)에 ご를 붙여 정중함을 나타냈고, 聞かせてください는 '들려주세요'라는 뜻의 정중한 요청입니다."
            ),
            JapanesePhrase(
                id: 256,
                japaneseSentence: "何かいいアイデアはありますか？",
                hiragana: "なにかいいアイデアはありますか？",
                koreanSentence: "뭔가 좋은 아이디어 있어요?",
                romaji: "Nani ka ii aidea wa arimasu ka?",
                koreanPronunciation: "나니카 이- 아이데아와 아리마스카?",
                grammar: "회의나 계획을 짤 때, 주변 사람들에게 좋은 생각이 있는지 묻는 표현입니다. 何か(なにか)는 '무언가', アイデア는 영어 'idea'에서 온 외래어입니다."
            ),
            JapanesePhrase(
                id: 257,
                japaneseSentence: "それは無理です。",
                hiragana: "それはむりです",
                koreanSentence: "그건 무리예요. / 불가능해요.",
                romaji: "Sore wa muri desu",
                koreanPronunciation: "소레와 무리데스",
                grammar: "어떤 요청이나 계획이 실행 불가능함을 명확하게 전달할 때 사용합니다. 無理(むり)는 '무리, 불가능'을 뜻하는 な형용사입니다."
            ),
            JapanesePhrase(
                id: 258,
                japaneseSentence: "たぶん、行けると思います。",
                hiragana: "たぶん、いけるとおもいます",
                koreanSentence: "아마, 갈 수 있을 것 같아요.",
                romaji: "Tabun, ikeru to omoimasu",
                koreanPronunciation: "타분, 이케루토 오모이마스",
                grammar: "たぶん(아마도) + 行ける(갈 수 있다) + と思います(라고 생각합니다)의 조합입니다. '갈 수 있다'는 가능성과 '~라고 생각한다'는 추측을 결합하여, 100% 확신은 아니지만 갈 수 있을 것 같다는 뉘앙스를 표현합니다."
            ),
            JapanesePhrase(
                id: 259,
                japaneseSentence: "携帯の電源が切れました。",
                hiragana: "けいたいのてんげんがきれました",
                koreanSentence: "핸드폰 전원이 꺼졌어요.",
                romaji: "Keitai no dengen ga kiremashita",
                koreanPronunciation: "케-타이노 덴겐가 키레마시타",
                grammar: "携帯(けいたい)는 '휴대전화', 電源(でんげん)은 '전원'입니다. 切れる(きれる)는 '끊어지다, 다 소모되다'는 뜻으로, 電源が切れる는 '전원이 꺼지다/배터리가 다 되다'는 의미의 관용구입니다."
            ),
            JapanesePhrase(
                id: 260,
                japaneseSentence: "どうすればいいですか？",
                hiragana: "どうすればいいですか？",
                koreanSentence: "어떻게 하면 좋을까요?",
                romaji: "Dō sureba ii desu ka?",
                koreanPronunciation: "도- 스레바 이-데스카?",
                grammar: "곤란한 상황에 처했을 때, 상대방에게 조언이나 지시를 구하는 매우 유용한 표현입니다. どう(어떻게) + すれば(하면 - する의 가정형) + いいですか(좋을까요?)의 구조입니다."
            ),
            JapanesePhrase(
                id: 261,
                japaneseSentence: "紅茶よりコーヒーのほうが好きです。",
                hiragana: "こうちゃよりコーヒーのほうがすきです",
                koreanSentence: "홍차보다 커피 쪽을 더 좋아해요.",
                romaji: "Kōcha yori kōhī no hō ga suki desu",
                koreanPronunciation: "코-챠요리 코-히-노 호-가 스키데스",
                grammar: "AよりBのほうが~는 'A보다 B 쪽이 더 ~하다'는 의미의 비교급 기본 패턴입니다. より는 '~보다'라는 비교의 기준을 나타냅니다. 紅茶(こうちゃ)는 '홍차'입니다."
            ),
            JapanesePhrase(
                id: 262,
                japaneseSentence: "どちらも好きです。",
                hiragana: "どちらもすきです",
                koreanSentence: "둘 다 좋아요.",
                romaji: "Dochira mo suki desu",
                koreanPronunciation: "도치라모 스키데스",
                grammar: "두 가지 선택지 모두 마음에 들 때 사용하는 표현입니다. どちら(어느 쪽) + も(도)가 합쳐져 '어느 쪽도, 둘 다'라는 의미가 됩니다."
            ),
            JapanesePhrase(
                id: 263,
                japaneseSentence: "甘いものは苦手です。",
                hiragana: "あまいものはにがてです",
                koreanSentence: "단 것은 잘 못 먹어요.",
                romaji: "Amai mono wa nigate desu",
                koreanPronunciation: "아마이 모노와 니가테데스",
                grammar: "苦手(にがて)는 어떤 것을 '잘 못하거나 좋아하지 않는다'는 뜻으로, 嫌い(きらい)(싫어하다)보다 훨씬 부드럽고 완곡한 거절/부정의 표현입니다. 甘いもの(あまいもの)는 '단 것'을 의미합니다."
            ),
            JapanesePhrase(
                id: 264,
                japaneseSentence: "辛いものは好きですか？",
                hiragana: "からいものはすきですか？",
                koreanSentence: "매운 음식 좋아해요?",
                romaji: "Karai mono wa suki desu ka?",
                koreanPronunciation: "카라이 모노와 스키데스카?",
                grammar: "상대방의 음식 취향을 물을 때 사용합니다. 辛い(からい)는 '맵다'는 뜻의 い형용사입니다. ~もの는 '~것'이라는 뜻으로, 음식을 지칭할 때 자주 쓰입니다."
            ),
            JapanesePhrase(
                id: 265,
                japaneseSentence: "猫舌なんです。",
                hiragana: "ねこじたなんです",
                koreanSentence: "저 뜨거운 걸 잘 못 먹어요. (직역: 고양이 혀예요)",
                romaji: "Nekojita nan desu",
                koreanPronunciation: "네코지타난데스",
                grammar: "猫舌(ねこじた)는 '고양이 혀'라는 뜻으로, 뜨거운 음식이나 음료를 잘 먹지 못하는 사람을 가리키는 일본의 독특한 관용 표현입니다. ~んです는 이유나 상황을 설명하는 뉘앙스를 더합니다."
            ),
            JapanesePhrase(
                id: 266,
                japaneseSentence: "準備はできましたか？",
                hiragana: "じゅんびはできましたか？",
                koreanSentence: "준비 되셨어요?",
                romaji: "Junbi wa dekimashita ka?",
                koreanPronunciation: "준비와 데키마시타카?",
                grammar: "준비(じゅんび)는 '준비'라는 뜻입니다. できる는 '할 수 있다, 가능하다'는 의미로, ここ에서는 '준비가 완료되다'라는 뜻으로 사용됩니다. 과거형 ました를 사용해 완료 여부를 묻습니다."
            ),
            JapanesePhrase(
                id: 267,
                japaneseSentence: "無理はしないでください。",
                hiragana: "むりはしないでください",
                koreanSentence: "무리하지 마세요.",
                romaji: "Muri wa shinaide kudasai",
                koreanPronunciation: "무리와 시나이데 쿠다사이",
                grammar: "無理(むり)는 '무리, 억지'라는 뜻이며, 무리する는 '무리하다'라는 의미입니다. ~ないでください는 '~하지 마세요'라는 부탁/명령의 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 268,
                japaneseSentence: "早く良くなってください。",
                hiragana: "はやくよくなってください",
                koreanSentence: "빨리 나으세요.",
                romaji: "Hayaku yoku natte kudasai",
                koreanPronunciation: "하야쿠 요쿠 낫테 쿠다사이",
                grammar: "아픈 사람에게 쾌유를 비는 표현입니다. よくなる는 '좋아지다, 나아지다'라는 의미로, 병이나 상황이 개선되기를 바랄 때 사용합니다."
            ),
            JapanesePhrase(
                id: 269,
                japaneseSentence: "何度もすみません。",
                hiragana: "なんどもすみません",
                koreanSentence: "몇 번이나 죄송합니다.",
                romaji: "Nando mo sumimasen",
                koreanPronunciation: "난도모 스미마셍",
                grammar: "何度も(なんども)는 '여러 번, 몇 번이나'라는 뜻입니다. 반복해서 부탁하거나 실수했을 때 사용하는 사과 표현입니다."
            ),
            JapanesePhrase(
                id: 270,
                japaneseSentence: "ありがとう、助かったよ。",
                hiragana: "ありがとう、たすかったよ",
                koreanSentence: "고마워, 도움이 됐어.",
                romaji: "Arigatō, tasukatta yo",
                koreanPronunciation: "아리가토-, 타스캇타요",
                grammar: "業무 마무리나 작별 인사로 사용하는 정중한 표현입니다. 会う(あう)의 존경어 お会いする를 사용하여 '뵙다'라는 의미로 상대방을 높였습니다. また(또)로 재회의 기대를 표현합니다."
            ),
            JapanesePhrase(
                id: 271,
                japaneseSentence: "このカード、使えますか？",
                hiragana: "このカード、つかえますか？",
                koreanSentence: "이 카드, 사용할 수 있나요?",
                romaji: "Kono kādo, tsukaemasu ka?",
                koreanPronunciation: "코노 카-도, 츠카에마스카?",
                grammar: "특정 카드를 사용할 수 있는지 직접적으로 물어보는 표현입니다. 使う(つかう)(사용하다) 동사의 가능형 使える(つかえる)(사용할 수 있다)의 정중 의문형입니다."
            ),
            JapanesePhrase(
                id: 272,
                japaneseSentence: "手数料はかかりますか？",
                hiragana: "てすうりょうはかかりますか？",
                koreanSentence: "수수료가 드나요?",
                romaji: "Tesūryō wa kakarimasu ka?",
                koreanPronunciation: "테스-료-와 카카리마스카?",
                grammar: "환전이나 특정 서비스를 이용할 때 추가 비용이 있는지 확인하는 질문입니다. 手数料(てすうりょう)는 '수수료', かかります는 '들다, 걸리다'는 뜻입니다."
            ),
            JapanesePhrase(
                id: 273,
                japaneseSentence: "もう閉まりました。",
                hiragana: "もうしまりました",
                koreanSentence: "벌써 닫았어요.",
                romaji: "Mō shimarimashita",
                koreanPronunciation: "모- 시마리마시타",
                grammar: "가게나 시설이 이미 영업을 종료했음을 나타냅니다. もう는 '이미, 벌써'라는 뜻이며, 閉まる(しまる)는 '(문 등이) 닫히다'라는 자동사입니다."
            ),
            JapanesePhrase(
                id: 274,
                japaneseSentence: "まだ開いていますか？",
                hiragana: "まだあいていますか？",
                koreanSentence: "아직 열려 있나요?",
                romaji: "Mada aite imasu ka?",
                koreanPronunciation: "마다 아이테 이마스카?",
                grammar: "가게나 시설이 아직 영업 중인지 확인하는 질문입니다. まだ는 '아직', 開く(あく)는 '(가게 등이) 열다, 열리다'는 동사입니다. -て います 형태로 '열려 있는 상태'인지 묻습니다."
            ),
            JapanesePhrase(
                id: 275,
                japaneseSentence: "何時まで開いていますか？",
                hiragana: "なんじまであいていますか？",
                koreanSentence: "몇 시까지 열려 있나요?",
                romaji: "Nan-ji made aite imasu ka?",
                koreanPronunciation: "난지마데 아이테 이마스카?",
                grammar: "가게 등의 영업 종료 시각을 묻는 표현입니다. 何時まで(なんじまで)는 '몇 시까지'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 276,
                japaneseSentence: "彼は私のタイプじゃないです。",
                hiragana: "かれはわたしのタイプじゃないです",
                koreanSentence: "그는 제 타입이 아니에요.",
                romaji: "Kare wa watashi no taipu ja nai desu",
                koreanPronunciation: "카레와 와타시노 타이푸쟈 나이데스",
                grammar: "이성으로서의 취향을 표현할 때 사용합니다. 彼(かれ)는 '그', タイプ는 영어 'type'에서 온 외래어입니다. ~じゃないです는 '~이/가 아닙니다'라는 부정형입니다."
            ),
            JapanesePhrase(
                id: 277,
                japaneseSentence: "付き合っている人はいますか？",
                hiragana: "つきあっているひとはいますか？",
                koreanSentence: "사귀고 있는 사람은 있어요?",
                romaji: "Tsukiatte iru hito wa imasu ka?",
                koreanPronunciation: "츠키앗테 이루 히토와 이마스카?",
                grammar: "상대방의 연애 상태를 물어보는 직접적인 질문입니다. 付き合う(つきあう)는 '사귀다'라는 동사이며, -て いる 형태로 '사귀고 있는' 상태를 나타냅니다."
            ),
            JapanesePhrase(
                id: 278,
                japaneseSentence: "結婚していますか？",
                hiragana: "けっこんしていますか？",
                koreanSentence: "결혼했어요?",
                romaji: "Kekkon shite imasu ka?",
                koreanPronunciation: "겟콘시테 이마스카?",
                grammar: "상대방의 결혼 여부를 묻는 질문입니다. 結婚する(けっこんする)(결혼하다)의 -て います 형태로, '결혼한 상태'인지를 묻습니다. '결혼하셨나요?'라고 과거형으로 묻지 않는 점에 주의해야 합니다."
            ),
            JapanesePhrase(
                id: 279,
                japaneseSentence: "ご心配なく。",
                hiragana: "ごしんぱいなく",
                koreanSentence: "걱정 마세요.",
                romaji: "Go-shinpai naku",
                koreanPronunciation: "고심파이나쿠",
                grammar: "心配しないでください보다 좀 더 간결하고 단정적으로 상대방을 안심시키는 표현입니다. 心配(しんぱい)에 정중함을 더하는 ご를 붙이고, なく는 '없이'라는 뜻으로, '걱정 없이' 즉 '걱정 마세요'라는 의미를 만듭니다."
            ),
            JapanesePhrase(
                id: 280,
                japaneseSentence: "行ってきます。",
                hiragana: "いってきます",
                koreanSentence: "다녀오겠습니다.",
                romaji: "Ittekimasu",
                koreanPronunciation: "잇테키마스",
                grammar: "집이나 회사 등, 소속된 장소에서 잠시 외출할 때 남아있는 사람들에게 하는 고정된 인사말입니다. '갔다가 오겠습니다'(行って+来ます)라는 의미를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 281,
                japaneseSentence: "行ってらっしゃい。",
                hiragana: "いってらっしゃい",
                koreanSentence: "다녀오세요.",
                romaji: "Itterasshai",
                koreanPronunciation: "잇테랏샤이",
                grammar: "行ってきます(다녀오겠습니다)에 대한 표준적인 답변입니다. 남아있는 사람이 나가는 사람에게 하는 인사말로, '잘 다녀오세요'라는 의미를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 282,
                japaneseSentence: "お腹の調子が悪いです。",
                hiragana: "おなかのちょうしがわるいです",
                koreanSentence: "배 상태가 안 좋아요.",
                romaji: "O-naka no chōshi ga warui desu",
                koreanPronunciation: "오나카노 초-시가 와루이데스",
                grammar: "調子(ちょうし)는 '상태, 컨디션'을 의미합니다. お腹の調子が悪い는 배탈이 났거나, 소화가 안되거나, 설사를 하는 등 배와 관련된 전반적인 컨디션 난조를 표현할 때 폭넓게 사용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 283,
                japaneseSentence: "アポイントはありますか？",
                hiragana: "アポイントはありますか？",
                koreanSentence: "예약(약속)하셨나요?",
                romaji: "Apointo wa arimasu ka?",
                koreanPronunciation: "아포인토와 아리마스카?",
                grammar: "주로 병원이나 비즈니스 미팅 등 사람과의 만남 약속을 확인 할 때 사용합니다. アポイント는 영어 'appointment'에서 온 외래어입니다. 식당이나 호텔 예약은 予約(よやく)를 더 자주 사용합니다."
            ),
            JapanesePhrase(
                id: 284,
                japaneseSentence: "もちろん知っています。",
                hiragana: "もちろんしっています",
                koreanSentence: "물론 알고 있죠.",
                romaji: "Mochiron shitte imasu",
                koreanPronunciation: "모치론 싯테 이마스",
                grammar: "어떤 사실에 대해 알고 있음을 강조하여 표현합니다. 知る(しる)(알다) 동사는 '알고 있는 상태'를 나타낼 때 보통 -て います 형태를 사용합니다."
            ),
            JapanesePhrase(
                id: 285,
                japaneseSentence: "全然知りませんでした。",
                hiragana: "ぜんぜんしりませんでした",
                koreanSentence: "전혀 몰랐어요.",
                romaji: "Zenzen shirimasen deshita",
                koreanPronunciation: "젠젠 시리마셍데시타",
                grammar: "부사 全然(ぜんぜん)은 '전혀'라는 뜻으로, 항상 뒤에 부정형이 따라옵니다. 知りませんでした는 '알다' 동사 知る의 정중 과거 부정형으로, '과거에 몰랐다'는 사실을 나타냅니다."
            ),
            JapanesePhrase(
                id: 286,
                japaneseSentence: "信じられないかもしれませんが、本当です。",
                hiragana: "しんじられないかもしれませんが、ほんとうです",
                koreanSentence: "믿을 수 없을지도 모르지만, 사실이에요.",
                romaji: "Shinjirarenai kamo shiremasen ga, hontō desu",
                koreanPronunciation: "신지라레나이카모 시레마셍가, 혼토-데스",
                grammar: "~かもしれません은 '~일지도 모릅니다'라는 추측을 나타내는 중요한 문법입니다. 信じられない(믿을 수 없다)와 결합하여, 듣는 사람이 믿기 어려운 사실임을 인정하면서도 사실임을 강조할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 287,
                japaneseSentence: "コピーをお願いします。",
                hiragana: "コピーをおねがいします",
                koreanSentence: "복사 부탁합니다.",
                romaji: "Kopī o onegai shimasu",
                koreanPronunciation: "코피-오 오네가이시마스",
                grammar: "사무실이나 학교 등에서 복사를 부탁할 때 사용하는 간단한 표현입니다. コピー는 영어 'copy'에서 온 외래어입니다."
            ),
            JapanesePhrase(
                id: 288,
                japaneseSentence: "この書類にサインをお願いします。",
                hiragana: "このしょるいにサインをおねがいします",
                koreanSentence: "이 서류에 사인 부탁합니다.",
                romaji: "Kono shorui ni sain o onegai shimasu",
                koreanPronunciation: "코노 쇼루이니 사인오 오네가이시마스",
                grammar: "계약이나 확인 등 서명이 필요할 때 사용하는 표현입니다. 書類(しょるい)는 '서류', サイン은 '사인, 서명'을 뜻하는 외래어입니다."
            ),
            JapanesePhrase(
                id: 289,
                japaneseSentence: "ここに座ってもよろしいでしょうか？",
                hiragana: "ここにすわってもよろしいでしょうか？",
                koreanSentence: "여기에 앉아도 괜찮을까요? (매우 정중)",
                romaji: "Koko ni suwatte mo yoroshii deshō ka?",
                koreanPronunciation: "코코니 스왓테모 요로시-데쇼-카?",
                grammar: "~てもいいですか보다 훨씬 더 정중하고 격식 있게 허락을 구하는 표현입니다. よろしいでしょうか는 윗사람이나 처음 보는 사람에게 극도의 정중함을 나타낼 때 사용합니다."
            ),
            JapanesePhrase(
                id: 290,
                japaneseSentence: "もう少し大きい声で話してください。",
                hiragana: "もうすこしおおきいこえではなしてください",
                koreanSentence: "조금 더 큰 소리로 말해주세요.",
                romaji: "Mō sukoshi ōkii koe de hanashite kudasai",
                koreanPronunciation: "모- 스코시 오-키- 코에데 하나시테 쿠다사이",
                grammar: "상대방의 목소리가 작아서 잘 들리지 않을 때 정중하게 요청하는 표현입니다. 大きい声(おおきいこえ)는 '큰 목소리'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 291,
                japaneseSentence: "おっしゃる通りです。",
                hiragana: "おっしゃるとおりです",
                koreanSentence: "말씀하신 대로입니다.",
                romaji: "Ossharu tōri desu",
                koreanPronunciation: "옷샤루 토-리데스",
                grammar: "その通りです의 존경어 버전입니다. おっしゃる는 '말하다'라는 동사 言う(いう)의 최고 존경어로, 윗사람의 말에 깊이 동의할 때 사용하는 매우 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 292,
                japaneseSentence: "ご存じですか？",
                hiragana: "ごぞんじですか？",
                koreanSentence: "알고 계십니까?",
                romaji: "Go-zonji desu ka?",
                koreanPronunciation: "고존지데스카?",
                grammar: "'알고 있습니까?'(知っていますか？)의 존경어 표현입니다. ご存じ는 '앎'을 높여 부르는 말로, 윗사람이나 고객에게 어떤 사실을 알고 있는지 물을 때 사용합니다."
            ),
            JapanesePhrase(
                id: 293,
                japaneseSentence: "存じ上げません。",
                hiragana: "ぞんじあげません",
                koreanSentence: "알지 못합니다. / 잘 모릅니다.",
                romaji: "Zonjiagemasen",
                koreanPronunciation: "존지아게마셍",
                grammar: "'모릅니다'(知りません)의 겸양어 표현입니다. 存じ上げる는 '알다'의 겸양어로, 윗사람에게 자신이 어떤 사실을 모른다고 말할 때 자신을 낮춰 정중하게 표현하는 말입니다."
            ),
            JapanesePhrase(
                id: 294,
                japaneseSentence: "お待たせいたしました。",
                hiragana: "おまたせいたしました",
                koreanSentence: "오래 기다리셨습니다.",
                romaji: "O-matase itashimashita",
                koreanPronunciation: "오마타세 이타시마시타",
                grammar: "お待たせしました보다 더 정중하고 격식 있는 표현입니다. いたしました는 しました의 겸양어로, 주로 직원이 고객에게 사용하는 등 격식을 차려야 하는 상황에서 쓰입니다."
            ),
            JapanesePhrase(
                id: 295,
                japaneseSentence: "ただいま、席を外しております。",
                hiragana: "ただいま、せきをはずしております",
                koreanSentence: "지금, 자리를 비웠습니다.",
                romaji: "Tadaima, seki o hazushite orimasu",
                koreanPronunciation: "타다이마, 세키오 하즈시테 오리마스",
                grammar: "비즈니스 전화 응대의 필수 표현입니다. 席を外す(せきをはずす)는 '자리를 비우다'는 관용구이며, おります는 います의 겸양어로, 저희 쪽 사람의 행동을 낮춰 말함으로써 상대방을 높이는 효과가 있습니다."
            ),
            JapanesePhrase(
                id: 296,
                japaneseSentence: "恐れ入りますが。。。",
                hiragana: "おそれいりますが。。。",
                koreanSentence: "죄송하지만... / 송구스럽습니다만...",
                romaji: "Osore-irimasu ga...",
                koreanPronunciation: "오소레이리마스가...",
                grammar: "상대방에게 무언가를 묻거나 부탁하기 전에 사용하는, 매우 정중한 '쿠션 단어'입니다. '송구스럽다, 황공하다'는 의미를 담고 있어, 특히 윗사람이나 고객에게 어려운 부탁을 할 때 문장 앞에 사용합니다."
            ),
            JapanesePhrase(
                id: 297,
                japaneseSentence: "お手数ですが。。。",
                hiragana: "おてすうですが。。。",
                koreanSentence: "수고스러우시겠지만... / 번거로우시겠지만...",
                romaji: "O-tesū desu ga...",
                koreanPronunciation: "오테스-데스가...",
                grammar: "296번과 유사하게, 상대방에게 번거로운 일을 부탁할 때 사용하는 정중한 '쿠션 단어'입니다. お手数(おてすう)는 '수고, 번거로움'이라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 298,
                japaneseSentence: "おかわりはいかがですか？",
                hiragana: "おかわりはいかがですか？",
                koreanSentence: "리필(한 그릇 더)은 어떠세요?",
                romaji: "O-kawari wa ikaga desu ka?",
                koreanPronunciation: "오카와리와 이카가데스카?",
                grammar: "식사 자리에서 밥이나 음료 등을 더 원하는지 정중하게 묻는 표현입니다. おかわり는 '리필, 한 그릇 더', ~はいかがですか는 '~은 어떠십니까?'라는 정중한 권유 표현입니다."
            ),
            JapanesePhrase(
                id: 299,
                japaneseSentence: "ちょっと味が薄いですね。",
                hiragana: "ちょっとあじがうすいですね",
                koreanSentence: "맛이 좀 싱겁네요.",
                romaji: "Chotto aji ga usui desu ne",
                koreanPronunciation: "춋토 아지가 우스이데스네",
                grammar: "음식 맛에 대한 감상을 표현하는 말입니다. 味(あじ)는 '맛', 薄い(うすい)는 '묽다, 싱겁다, 옅다'는 뜻의 い형용사입니다. 반대로 '진하다'는 濃い(こい)를 사용합니다."
            ),
            JapanesePhrase(
                id: 300,
                japaneseSentence: "結構なお味で。",
                hiragana: "けっこうなおあじで",
                koreanSentence: "훌륭한 맛이네요.",
                romaji: "Kekkō na o-aji de",
                koreanPronunciation: "켓코-나 오아지데",
                grammar: "음식 맛에 대한 세련되고 격식 있는 칭찬입니다. 여기서 結構(けっこう)는 '사양'의 의미가 아닌, '훌륭하다, 멋지다'는 뜻의 な형용사로 사용되었습니다. お味(おあじ)는 '맛'의 정중한 표현입니다. 문장 끝을 ~で로 맺어 여운을 남기는 표현 방식입니다."
            ),
            JapanesePhrase(
                id: 301,
                japaneseSentence: "まさか！",
                hiragana: "まさか！",
                koreanSentence: "설마! / 말도 안 돼!",
                romaji: "Masaka!",
                koreanPronunciation: "마사카!",
                grammar: "예상치 못한 믿기 힘든 일이 일어났을 때, 강한 의심이나 부정을 나타내는 감탄사입니다. 보통 뒤에 うそでしょう？(거짓말이죠?) 같은 말이 생략된 느낌으로 쓰입니다."
            ),
            JapanesePhrase(
                id: 302,
                japaneseSentence: "やっぱりそうですか。",
                hiragana: "やっぱりそうですか",
                koreanSentence: "역시 그렇군요.",
                romaji: "Yappari sō desu ka",
                koreanPronunciation: "얍빠리 소-데스카",
                grammar: "예상하거나 짐작했던 일이 사실로 확인되었을 때 사용하는 표현입니다. やっぱり(역시), 또는 더 격식적인 표현으로 やはり(야하리)를 사용합니다."
            ),
            JapanesePhrase(
                id: 303,
                japaneseSentence: "そのはずです。",
                hiragana: "そのはずです",
                koreanSentence: "그럴 거예요. / 마땅히 그래야 해요.",
                romaji: "Sono hazu desu",
                koreanPronunciation: "소노 하즈데스",
                grammar: "~はずです는 어떤 근거를 바탕으로 '그렇게 되는 것이 당연하다'고 논리적으로 추측하거나 기대할 때 사용하는 중요한 문법입니다. 강한 확신을 나타냅니다."
            ),
            JapanesePhrase(
                id: 304,
                japaneseSentence: "しょうがないですね。",
                hiragana: "しょうがないですね",
                koreanSentence: "어쩔 수 없네요.",
                romaji: "Shōganai desu ne",
                koreanPronunciation: "쇼-가나이데스네",
                grammar: "仕様がない(しようがない)의 줄임말로, '방법이 없다'는 뜻입니다. 자신의 힘으로는 어찌할 수 없는 상황에 대해 체념하거나 받아들일 때 사용합니다. 仕方がない(しかたがない)와 같은 의미입니다."
            ),
            JapanesePhrase(
                id: 305,
                japaneseSentence: "懐かしいですね。",
                hiragana: "なつかしいですね",
                koreanSentence: "그립네요.",
                romaji: "Natsukashii desu ne",
                koreanPronunciation: "나츠카시-데스네",
                grammar: "과거의 일이나 장소, 사람을 떠올리며 아련하고 좋은 감정을 느낄 때 사용합니다. 懐かしい(なつかしい)는 '그립다'는 뜻의 い형용사입니다."
            ),
            JapanesePhrase(
                id: 306,
                japaneseSentence: "危ない！",
                hiragana: "あぶない！",
                koreanSentence: "위험해!",
                romaji: "Abunai!",
                koreanPronunciation: "아부나이!",
                grammar: "위험이 임박했을 때 외치는 경고의 말입니다. 危ない(あぶない)는 '위험하다'는 뜻의 い형용사로, 문법과 상관없이 단독으로 외쳐서 사용합니다."
            ),
            JapanesePhrase(
                id: 307,
                japaneseSentence: "間に合わないかもしれません。",
                hiragana: "まにあわないかもしれません",
                koreanSentence: "시간에 못 맞출지도 몰라요.",
                romaji: "Ma ni awanai kamo shiremasen",
                koreanPronunciation: "마니아와나이카모 시레마셍",
                grammar: "~かもしれません(~일지도 모릅니다) 패턴을 사용한 불확실한 추측입니다. 間に合わない(まにあわない)는 間に合う(시간에 맞추다)의 부정형으로, 약속 시간에 늦을 가능성이 있음을 나타냅니다."
            ),
            JapanesePhrase(
                id: 308,
                japaneseSentence: "そろそろ始めませんか？",
                hiragana: "そろそろはじめませんか？",
                koreanSentence: "슬슬 시작하지 않을래요?",
                romaji: "Sorosoro hajimemasen ka?",
                koreanPronunciation: "소로소로 하지메마셍카?",
                grammar: "~ましょうか(~할까요?)보다 상대방의 의향을 조금 더 직접적으로 물으며 제안하는 표현입니다. ~ませんか는 '~하지 않겠습니까?'라는 의미의 부드러운 권유형입니다."
            ),
            JapanesePhrase(
                id: 309,
                japaneseSentence: "お口に合いますか？",
                hiragana: "おくちにあいますか？",
                koreanSentence: "입에 맞으세요?",
                romaji: "O-kuchi ni aimasu ka?",
                koreanPronunciation: "오쿠치니 아이마스카?",
                grammar: "자신이 대접한 음식이 상대방의 입맛에 맞는지 정중하게 물어보는 표현입니다. 口に合う(くちにあう)는 '입맛에 맞다'는 관용구이며, 口에 お를 붙여 정중함을 더했습니다."
            ),
            JapanesePhrase(
                id: 310,
                japaneseSentence: "おかげさまで、元気です。",
                hiragana: "おかげさまで、げんきです",
                koreanSentence: "덕분에 잘 지내요.",
                romaji: "Okagesama de, genki desu",
                koreanPronunciation: "오카게사마데, 겡키데스",
                grammar: "お元気ですか？(잘 지내세요?)에 대한 가장 정중하고 표준적인 답변입니다. おかげさまで(덕분에요)를 먼저 말함으로써, 상대방의 안부 질문(배려) 덕분에 잘 지낸다는 겸손과 감사의 마음을 표현합니다."
            ),
            JapanesePhrase(
                id: 311,
                japaneseSentence: "調子はどうですか？",
                hiragana: "ちょうしはどうですか？",
                koreanSentence: "컨디션은 어때요? / 잘 돼가요?",
                romaji: "Chōshi wa dō desu ka?",
                koreanPronunciation: "초-시와 도-데스카?",
                grammar: "調子(ちょうし)는 '상태, 컨디션'을 의미하는 폭넓은 단어입니다. 사람의 건강 상태를 물을 수도 있고, 일의 진행 상황이 어떤지 물을 때도 사용할 수 있습니다."
            ),
            JapanesePhrase(
                id: 312,
                japaneseSentence: "おかわりは自由です。",
                hiragana: "おかわりはじゆうです",
                koreanSentence: "리필은 무료입니다. (마음껏 하세요)",
                romaji: "O-kawari wa jiyū desu",
                koreanPronunciation: "오카와리와 지유-데스",
                grammar: "일본의 식당에서 자주 볼 수 있는 표현입니다. おかわり는 '리필, 한 그릇 더'라는 뜻이며, 自由(じゆう)는 '자유' 즉, '마음껏'이라는 의미로 쓰여 '무한 리필'을 나타냅니다."
            ),
            JapanesePhrase(
                id: 313,
                japaneseSentence: "持ち帰りでお願いします。",
                hiragana: "もちかえりでおねがいします",
                koreanSentence: "포장으로 부탁합니다.",
                romaji: "Mochikaeri de onegai shimasu",
                koreanPronunciation: "모치카에리데 오네가이시마스",
                grammar: "식당에서 음식을 포장해 가고 싶을 때 사용하는 필수 표현입니다. 持ち帰り(もちかえり)는 持つ(들다)와 帰る(돌아가다)가 합쳐진 '테이크아웃, 포장'이라는 뜻의 명사입니다."
            ),
            JapanesePhrase(
                id: 314,
                japaneseSentence: "ここで食べます。",
                hiragana: "ここでたべます",
                koreanSentence: "여기서 먹을게요.",
                romaji: "Koko de tabemasu",
                koreanPronunciation: "코코데 타베마스",
                grammar: "313번의 반대 표현으로, 패스트푸드점 등에서 '매장에서 먹고 가겠다'는 의사를 밝힐 때 사용합니다. ここで는 '여기에서'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 315,
                japaneseSentence: "ご一緒してもいいですか？",
                hiragana: "ごいっしょしてもいいですか？",
                koreanSentence: "같이 해도(합석해도) 될까요?",
                romaji: "Go-issho shite mo ii desu ka?",
                koreanPronunciation: "고잇쇼시테모 이-데스카?",
                grammar: "다른 사람의 테이블에 합석하거나, 어떤 그룹 활동에 함께 참여하고 싶을 때 정중하게 허락을 구하는 표현입니다. ご一緒する는 '함께하다'는 뜻의 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 316,
                japaneseSentence: "席を替えてください。",
                hiragana: "せきをかえてください",
                koreanSentence: "자리를 바꿔주세요.",
                romaji: "Seki o kaete kudasai",
                koreanPronunciation: "세키오 카에테 쿠다사이",
                grammar: "배정된 자리에 문제가 있거나 다른 자리로 옮기고 싶을 때 사용하는 요청 표현입니다. 席(せき)는 '자리', 替える(かえる)는 '바꾸다, 교환하다'는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 317,
                japaneseSentence: "ちょっと、よろしいですか？",
                hiragana: "ちょっと、よろしいですか？",
                koreanSentence: "잠깐, 괜찮으실까요? (매우 정중)",
                romaji: "Chotto, yoroshii desu ka?",
                koreanPronunciation: "춋토, 요로시-데스카?",
                grammar: "ちょっといいですか？보다 한 단계 더 정중하게 상대방의 주의를 끌거나 양해를 구할 때 사용합니다. よろしい는 いい(좋다)의 격식 차린 말입니다."
            ),
            JapanesePhrase(
                id: 318,
                japaneseSentence: "申し訳ございません。",
                hiragana: "もうしわけございません",
                koreanSentence: "대단히 죄송합니다. / 드릴 말씀이 없습니다.",
                romaji: "Mōshiwake gozaimasen",
                koreanPronunciation: "모-시와케 고자이마셍",
                grammar: "すみません이나 ごめんなさい보다 훨씬 격식 있고 정중한 최상급 사과 표현입니다. 申し訳ない(변명할 여지가 없다)에서 온 말로, 주로 비즈니스 상황이나 고객 응대 시 사용합니다."
            ),
            JapanesePhrase(
                id: 319,
                japaneseSentence: "恐縮です。",
                hiragana: "きょうしゅくです",
                koreanSentence: "황송합니다. / 송구스럽습니다.",
                romaji: "Kyōshuku desu",
                koreanPronunciation: "쿄-슈쿠데스",
                grammar: "윗사람에게 큰 칭찬을 듣거나, 폐를 끼쳤거나, 큰 부탁을 해야 할 때, '몸 둘 바를 모를 정도로 죄송하고 감사하다'는 복합적인 감정을 나타내는 매우 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 320,
                japaneseSentence: "かしこまりました。",
                hiragana: "かしこまりました",
                koreanSentence: "알겠습니다. (분부대로 하겠습니다)",
                romaji: "Kashikomarimashita",
                koreanPronunciation: "카시코마리마시타",
                grammar: "分かりました(알겠습니다)의 겸양 표현입니다. 주로 점원이나 비서 등 서비스직 종사자가 손님이나 상사의 지시를 받고 '삼가 받들겠습니다'라는 뉘앙스로 사용하는 극도로 정중한 표현입니다."
            ),
            JapanesePhrase(
                id: 321,
                japaneseSentence: "一石二鳥ですね。",
                hiragana: "いっせきにちょうですね",
                koreanSentence: "일석이조네요.",
                romaji: "Isseki nichō desu ne",
                koreanPronunciation: "잇세키니쵸-데스네",
                grammar: "一石二鳥(いっせきにちょう)는 한국어와 마찬가지로 '하나의 돌로 두 마리의 새를 잡는다'는 뜻의 사자성어입니다. 한 가지 행동으로 두 가지 이득을 얻었을 때 사용합니다."
            ),
            JapanesePhrase(
                id: 322,
                japaneseSentence: "どちらとも言えません。",
                hiragana: "どちらともいえません",
                koreanSentence: "어느 쪽이라고도 말할 수 없어요.",
                romaji: "Dochira tomo iemasen",
                koreanPronunciation: "도치라토모 이에마셍",
                grammar: "두 가지 선택지 중 어느 하나를 고르기 어려울 때, 중립적인 입장을 나타내는 표현입니다. どちらとも는 '어느 쪽도', 言えません(いえません)은 '말할 수 없다'는 言う(말하다)의 가능형 부정입니다."
            ),
            JapanesePhrase(
                id: 323,
                japaneseSentence: "とりあえず、ビールで。",
                hiragana: "とりあえず、ビールで",
                koreanSentence: "일단, 맥주로 할게요.",
                romaji: "Toriaezu, bīru de",
                koreanPronunciation: "토리아에즈, 비-루데",
                grammar: "とりあえず는 '우선, 일단'이라는 뜻으로, 여러 사람이 모여 주문할 때 먼저 자신의 것을 정할 때 매우 자주 사용하는 표현입니다. ビールで처럼 [명사] + で 형태로 간단하게 주문할 수 있습니다."
            ),
            JapanesePhrase(
                id: 324,
                japaneseSentence: "そろそろお開きにしましょうか。",
                hiragana: "そろそろおひらきにしましょうか",
                koreanSentence: "슬슬 파할까요? / 슬슬 마무리할까요?",
                romaji: "Sorosoro o-hiraki ni shimashō ka",
                koreanPronunciation: "소로소로 오히라키니 시마쇼-카",
                grammar: "회식이나 파티 등 모임을 끝낼 때 사용하는 정중한 표현입니다. お開きにする(おひらきにする)는 '모임을 끝내다, 파하다'라는 뜻의 관용구입니다."
            ),
            JapanesePhrase(
                id: 325,
                japaneseSentence: "話は変わりますが。。。",
                hiragana: "はなしはかわりますが。。。",
                koreanSentence: "이야기가 바뀌지만... (화제 전환)",
                romaji: "Hanashi wa kawarimasu ga...",
                koreanPronunciation: "하나시와 카와리마스가...",
                grammar: "대화의 주제를 자연스럽게 다른 것으로 바꾸고 싶을 때 사용하는 '쿠션 단어'입니다. 이 말을 먼저 꺼내고 새로운 주제의 이야기를 시작하면 됩니다."
            ),
            JapanesePhrase(
                id: 326,
                japaneseSentence: "念のため、確認します。",
                hiragana: "ねんのため、かくにんします",
                koreanSentence: "만약을 위해, 확인합니다.",
                romaji: "Nen no tame, kakunin shimasu",
                koreanPronunciation: "넨노 타메, 카쿠닌시마스",
                grammar: "念のため(ねんのため)는 '만약을 위해, 만일의 경우를 생각해서'라는 뜻의 매우 유용한 관용구입니다. 혹시 모를 실수를 방지하기 위해 재차 확인할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 327,
                japaneseSentence: "助かりました。",
                hiragana: "たすかりました",
                koreanSentence: "큰 도움이 되었어요. / 살았어요.",
                romaji: "Tasukarimashita",
                koreanPronunciation: "타스카리마시타",
                grammar: "상대방의 도움으로 곤란한 상황에서 벗어났을 때 사용하는 진심 어린 감사의 표현입니다. 助かる(たすかる)는 '도움을 받다, 살아나다'는 뜻으로, ありがとうございます보다 더 구체적인 감사를 나타냅니다."
            ),
            JapanesePhrase(
                id: 328,
                japaneseSentence: "勉強になりました。",
                hiragana: "べんきょうになりました",
                koreanSentence: "공부가 되었습니다.",
                romaji: "Benkyō ni narimashita",
                koreanPronunciation: "벵쿄-니 나리마시타",
                grammar: "상대방의 이야기나 경험을 통해 새로운 지식이나 교훈을 얻었을 때 감사의 의미로 사용하는 표현입니다. 勉強になる는 '공부가 되다'는 뜻입니다."
            ),
            JapanesePhrase(
                id: 329,
                japaneseSentence: "また誘ってください。",
                hiragana: "またさそってください",
                koreanSentence: "다음에 또 초대해주세요.",
                romaji: "Mata sasotte kudasai",
                koreanPronunciation: "마타 사솟테 쿠다사이",
                grammar: "모임이나 행사가 즐거웠고, 다음에도 참여하고 싶다는 긍정적인 의사를 나타내는 표현입니다. 誘う(さそう)는 '꾀다, 권유하다, 초대하다'는 뜻의 동사입니다."
            ),
            JapanesePhrase(
                id: 330,
                japaneseSentence: "賛成も反対もしません。",
                hiragana: "さんせいもはんたいもしません",
                koreanSentence: "찬성도 반대도 하지 않습니다.",
                romaji: "Sansei mo hantai mo shimasen",
                koreanPronunciation: "산세-모 한타이모 시마셍",
                grammar: "[명사1] + も + [동사 부정형], [명사2] + も + [동사 부정형]은 '~도 ~도 아니다'라는 의미를 나타냅니다. 이 문장에서는 동사가 する로 같아 한번만 사용되었습니다. 중립적인 입장을 고수할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 331,
                japaneseSentence: "そろそろ時間ですので、この辺で。",
                hiragana: "そろそろじかんですので、このへんで",
                koreanSentence: "슬슬 시간이 되었으므로, 이쯤에서 (마무리하겠습니다).",
                romaji: "Sorosoro jikan desu node, kono hen de",
                koreanPronunciation: "소로소로 지칸데스노데, 코노 헨데",
                grammar: "회의나 대화를 정중하게 마무리할 때 사용하는 표현입니다. ~ですので는 ~だから(때문에)의 정중한 표현입니다. この辺で(このへんで)는 '이쯤에서'라는 뜻으로, 뒤에 失礼します(실례하겠습니다) 등이 생략된 형태입니다."
            ),
            JapanesePhrase(
                id: 332,
                japaneseSentence: "また連絡します。",
                hiragana: "またれんらくします",
                koreanSentence: "다시 연락드리겠습니다.",
                romaji: "Mata renraku shimasu",
                koreanPronunciation: "마타 렌라쿠시마스",
                grammar: "대화를 일단락짓고 추후에 다시 연락하겠다는 의사를 전달할 때 사용합니다. また는 '또, 다시'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 333,
                japaneseSentence: "お元気そうで何よりです。",
                hiragana: "おげんきそうでなによりです",
                koreanSentence: "건강해 보이셔서 무엇보다 기쁩니다.",
                romaji: "O-genki sō de nani yori desu",
                koreanPronunciation: "오겡키소-데 나니요리데스",
                grammar: "오랜만에 만난 사람의 안부를 확인하고 기쁨을 표현하는 따뜻한 인사말입니다. ~そうで는 '~해 보인다'는 추측, 何よりです(なによりです)는 '무엇보다도 좋습니다'라는 최상의 기쁨을 나타내는 관용구입니다."
            ),
            JapanesePhrase(
                id: 334,
                japaneseSentence: "賛成しかねます。",
                hiragana: "さんせいしかねます",
                koreanSentence: "찬성하기 어렵습니다.",
                romaji: "Sansei shikanemasu",
                koreanPronunciation: "산세-시카네마스",
                grammar: "동사의 ます형 + かねます는 '~하기 어렵습니다, ~할 수 없습니다'라는 의미의 매우 정중하고 완곡한 거절 표현입니다. 직접적으로 できません(할 수 없습니다)이라고 말하기 어려운 비즈니스 상황 등에서 사용됩니다."
            ),
            JapanesePhrase(
                id: 335,
                japaneseSentence: "検討します。",
                hiragana: "けんとうします",
                koreanSentence: "검토하겠습니다.",
                romaji: "Kentō shimasu",
                koreanPronunciation: "켄토-시마스",
                grammar: "제안이나 요구에 대해 즉답을 피하고, '생각해 보겠다'는 의사를 전달하는 비즈니스 표현입니다. 検討する(けんとうする)는 '검토하다'는 뜻입니다. 긍정적인 답변을 기대하기 어려운, 일종의 정중한 보류 또는 거절의 뉘앙스로 쓰일 때도 많습니다."
            ),
            JapanesePhrase(
                id: 336,
                japaneseSentence: "それはさておき。。。",
                hiragana: "それはさておき。。。",
                koreanSentence: "그건 그렇고... / 그건 제쳐두고...",
                romaji: "Sore wa sateoki...",
                koreanPronunciation: "소레와 사테오키...",
                grammar: "지금까지의 화제를 일단 멈추고 새로운 이야기로 전환할 때 사용하는 표현입니다. 話は変わりますが와 비슷한 역할을 합니다."
            ),
            JapanesePhrase(
                id: 337,
                japaneseSentence: "要するに。。。",
                hiragana: "ようするに。。。",
                koreanSentence: "요컨대... / 즉...",
                romaji: "Yōsuru ni...",
                koreanPronunciation: "요-스루니...",
                grammar: "긴 이야기를 짧게 요약하거나 핵심을 말하기 전에 사용하는 표현입니다. '요점을 말하자면'이라는 의미를 가집니다."
            ),
            JapanesePhrase(
                id: 338,
                japaneseSentence: "あくまでも私の意見ですが。。。",
                hiragana: "あくまでもわたしのいけんですが。。。",
                koreanSentence: "어디까지나 제 의견입니다만...",
                romaji: "Akumademo watashi no iken desu ga...",
                koreanPronunciation: "아쿠마데모 와타시노 이켄데스가...",
                grammar: "자신의 의견을 제시하기 전에, 이것이 절대적인 사실이 아닌 개인적인 생각임을 강조하여 겸손하게 표현하는 '쿠션 단어'입니다. あくまでも는 '어디까지나, 철저하게'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 339,
                japaneseSentence: "おっしゃることは分かりますが。。。",
                hiragana: "おっしゃることはわかりますが。。。",
                koreanSentence: "말씀하시는 것은 알겠습니다만...",
                romaji: "Ossharu koto wa wakarimasu ga...",
                koreanPronunciation: "옷샤루 코토와 와카리마스가...",
                grammar: "상대방의 의견에 반대하기 전에 사용하는 매우 정중한 표현입니다. 먼저 상대의 의견을 존중하고 이해했음을 보여준 뒤(おっしゃること(말씀하시는 것)は分かります), が(만)를 통해 조심스럽게 다른 의견을 제시합니다."
            ),
            JapanesePhrase(
                id: 340,
                japaneseSentence: "それでいきましょう。",
                hiragana: "それでいきましょう",
                koreanSentence: "그걸로 하죠. / 그걸로 갑시다.",
                romaji: "Sore de ikimashō",
                koreanPronunciation: "소레데 이키마쇼-",
                grammar: "여러 의견이나 계획 중에서 하나를 채택하여 '그것으로 결정하자'고 말할 때 사용합니다. それで는 '그것으로', いきましょう는 '갑시다'라는 뜻으로, '결정하고 나아가자'는 뉘앙스를 가집니다."
            ),
            JapanesePhrase(
                id: 341,
                japaneseSentence: "では、お言葉に甘えて。。。",
                hiragana: "では、おことばにあまえて。。。",
                koreanSentence: "그럼, 말씀에 따라 (그렇게 하겠습니다).",
                romaji: "Dewa, o-kotoba ni amaete...",
                koreanPronunciation: "데와, 오코토바니 아마에테...",
                grammar: "상대방의 호의나 제안을 여러 번 사양하다가, 결국 감사히 받아들일 때 사용하는 매우 정중하고 세련된 표현입니다. お言葉に甘える(おことばにあまえる)는 직역하면 '말씀에 응석을 부리다'로, '친절한 말씀에 기대어 그렇게 하겠습니다'라는 겸손의 의미를 담고 있습니다."
            ),
            JapanesePhrase(
                id: 342,
                japaneseSentence: "では、また今度。",
                hiragana: "では、またこんど",
                koreanSentence: "그럼, 다음에 또 봬요.",
                romaji: "Dewa, mata kondo",
                koreanPronunciation: "데와, 마타 콘도",
                grammar: "헤어질 때 사용하는 가벼운 인사입니다. では는 '그럼', また는 '또', 今度(こんど)는 '다음번'이라는 뜻입니다. 뒤에 会いましょう(만나요) 등이 생략된 형태입니다."
            ),
            JapanesePhrase(
                id: 343,
                japaneseSentence: "近いうちにまた会いましょう。",
                hiragana: "ちかいうちにまたあいましょう",
                koreanSentence: "조만간 또 만나요.",
                romaji: "Chikai uchi ni mata aimashō",
                koreanPronunciation: "치카이 우치니 마타 아이마쇼-",
                grammar: "近いうちに(ちかいうちに)는 '가까운 시일 내에, 조만간'이라는 뜻의 관용구입니다. 다시 만나고 싶다는 의지를 표현하며 다음을 기약하는 인사말입니다."
            ),
            JapanesePhrase(
                id: 344,
                japaneseSentence: "良い一日を。",
                hiragana: "よいいちにちを",
                koreanSentence: "좋은 하루를 (보내세요).",
                romaji: "Yoi ichinichi o",
                koreanPronunciation: "요이 이치니치오",
                grammar: "헤어질 때 상대방의 하루가 좋기를 바라는 인사말입니다. 良い(よい)는 '좋은', 一日(いちにち)는 '하루'입니다. 문장 끝의 を 뒤에는 お過ごしください(보내세요)와 같은 말이 생략되어 있습니다."
            ),
            JapanesePhrase(
                id: 345,
                japaneseSentence: "良い週末を。",
                hiragana: "よいしゅうまつを",
                koreanSentence: "좋은 주말을 (보내세요).",
                romaji: "Yoi shūmatsu o",
                koreanPronunciation: "요이 슈-마츠오",
                grammar: "344번과 같은 구조로, 금요일 오후 등에 헤어질 때 사용합니다. 週末(しゅうまつ)는 '주말'이라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 346,
                japaneseSentence: "お元気で。",
                hiragana: "おげんきで",
                koreanSentence: "잘 지내세요. / 건강하세요.",
                romaji: "O-genki de",
                koreanPronunciation: "오겡키데",
                grammar: "당분간 만나지 못할 사람과 헤어질 때 사용하는 인사말입니다. '건강한 상태로 있어달라'는 기원을 담고 있습니다. 뒤에 いてください 등이 생략된 형태입니다."
            ),
            JapanesePhrase(
                id: 347,
                japaneseSentence: "くれぐれもよろしくお伝えください。",
                hiragana: "くれぐれもよろしくおつたえください",
                koreanSentence: "부디 안부 전해주세요.",
                romaji: "Kureguremo yoroshiku o-tsutae kudasai",
                koreanPronunciation: "쿠레구레모 요로시쿠 오츠타에쿠다사이",
                grammar: "자리에 없는 제3자에게 자신의 안부를 전해달라고 정중하게 부탁하는 표현입니다. くれぐれも는 '아무쪼록, 부디', よろしくお伝えください는 '안부를 전해주세요'라는 뜻의 고정된 문구입니다."
            ),
            JapanesePhrase(
                id: 348,
                japaneseSentence: "何かお変わりありませんか？",
                hiragana: "なにかお変わりありませんか？",
                koreanSentence: "별일 없으시죠?",
                romaji: "Nani ka o-kawari arimasen ka?",
                koreanPronunciation: "나니카 오카와리 아리마셍카?",
                grammar: "お久しぶりです(오랜만입니다)와 함께 사용하기 좋은, 격식 있는 안부 인사입니다. お変わり(おかわり)는 '변화'를 뜻하며, '그동안 무슨 변화(별일) 없으셨나요?'라고 묻는 것입니다."
            ),
            JapanesePhrase(
                id: 349,
                japaneseSentence: "おかげさまで、変わりありません。",
                hiragana: "おかげさまで、かわりありません",
                koreanSentence: "덕분에, 별일 없습니다.",
                romaji: "Okagesama de, kawari arimasen",
                koreanPronunciation: "오카게사마데, 카와리아리마셍",
                grammar: "348번 질문에 대한 가장 모범적인 답변입니다. おかげさまで(덕분에)를 먼저 말하여 상대방의 안부 질문에 감사를 표하고, 変わりありません(별일 없습니다)라고 답합니다."
            ),
            JapanesePhrase(
                id: 350,
                japaneseSentence: "今後ともよろしくお願いします。",
                hiragana: "こんごともよろしくおねがいします",
                koreanSentence: "앞으로도 잘 부탁드립니다.",
                romaji: "Kongo tomo yoroshiku onegai shimasu",
                koreanPronunciation: "콘고토모 요로시쿠 오네가이시마스",
                grammar: "비즈니스 관계를 맺거나, 지속적인 관계를 희망할 때 사용하는 정중한 표현입니다. 今後とも(こんごとも)는 これからも보다 조금 더 격식 있는 '앞으로도'라는 의미를 가집니다."
            ),
            JapanesePhrase(
                id: 351,
                japaneseSentence: "大変お世話になりました。",
                hiragana: "たいへんおせわになりました",
                koreanSentence: "신세 많이 졌습니다. / 그동안 정말 감사했습니다.",
                romaji: "Taihen o-sewa ni narimashita",
                koreanPronunciation: "타이헨 오세와니 나리마시타",
                grammar: "오랫동안 도움을 받은 상대방에게 감사를 표하며 헤어질 때 사용하는 최고의 인사말입니다. 퇴사, 이사, 졸업 등 관계를 마무리하는 시점에 사용합니다. お世話になる(おせわになる)는 '신세를 지다, 도움을 받다'는 뜻의 관용구입니다."
            ),
            JapanesePhrase(
                id: 352,
                japaneseSentence: "またお会いできるのを楽しみにしております。",
                hiragana: "またおあいできるのをたのしみにしております",
                koreanSentence: "다시 뵐 날을 기대하고 있겠습니다.",
                romaji: "Mata o-ai dekiru no o tanoshimi ni shite orimasu",
                koreanPronunciation: "마타 오아이데키루노오 타노시미니 시테오리마스",
                grammar: "楽しみにしています의 훨씬 정중한 버전입니다. お会いできる(만나 뵐 수 있다)는 겸양 표현, ~のを(~하는 것을), しております는 しています의 겸양 표현으로, 비즈니스 상대나 윗사람에게 정중하게 다음을 기약할 때 사용합니다."
            ),
            JapanesePhrase(
                id: 353,
                japaneseSentence: "無理なさらないでください。",
                hiragana: "むりなさらないでください",
                koreanSentence: "무리하지 마세요.",
                romaji: "Muri nasaranaide kudasai",
                koreanPronunciation: "무리 나사라나이데 쿠다사이",
                grammar: "無理しないでください보다 더 정중하게 상대방을 염려하는 표현입니다. なさらないでください는 '하다'는 동사 する의 존경어 なさる의 부정 요청형으로, 윗사람에게 사용하기 적합합니다."
            ),
            JapanesePhrase(
                id: 354,
                japaneseSentence: "ご無事で何よりです。",
                hiragana: "ごぶじでなによりです",
                koreanSentence: "무사하셔서 무엇보다 다행입니다.",
                romaji: "Go-buji de nani yori desu",
                koreanPronunciation: "고부지데 나니요리데스",
                grammar: "지진, 사고 등 위험한 일이 있은 후 상대방의 안위를 확인하고 안도감을 표현하는 말입니다. ご無事(ごぶじ)는 '무사함', 何よりです(なによりです)는 '무엇보다도 좋습니다'라는 뜻입니다."
            ),
            JapanesePhrase(
                id: 355,
                japaneseSentence: "いつでも声をかけてください。",
                hiragana: "いつでもこえをかけてください",
                koreanSentence: "언제든지 말을 걸어주세요. / 언제든 불러주세요.",
                romaji: "Itsudemo koe o kakete kudasai",
                koreanPronunciation: "이츠데모 코에오 카케테 쿠다사이",
                grammar: "상대방이 도움이 필요할 때 편하게 요청해도 좋다는 배려의 표현입니다. いつでも는 '언제든지', 声をかける(こえをかける)는 '말을 걸다'는 뜻의 관용구입니다."
            ),
            JapanesePhrase(
                id: 356,
                japaneseSentence: "お力になれて嬉しいです。",
                hiragana: "おちからになれてうれしいです",
                koreanSentence: "도움이 될 수 있어 기쁩니다.",
                romaji: "O-chikara ni narete ureshii desu",
                koreanPronunciation: "오치카라니 나레테 우레시-데스",
                grammar: "상대방을 도와준 후, '도움이 되었다니 다행이다'는 겸손한 기쁨을 나타내는 표현입니다. お力になる(おちからになる)는 '도움이 되다'는 뜻의 정중한 관용구입니다."
            ),
            JapanesePhrase(
                id: 357,
                japaneseSentence: "今日は本当にありがとうございました。",
                hiragana: "きょうはほんとうにありがとうございました",
                koreanSentence: "오늘 정말 감사했습니다.",
                romaji: "Kyō wa hontō ni arigatō gozaimashita",
                koreanPronunciation: "쿄-와 혼토-니 아리가토-고자이마시타",
                grammar: "하루 동안 신세를 진 상대에게 헤어질 때 감사를 표하는 말입니다. 今日(오늘)이라는 특정 시간과 本当に(정말로)라는 부사를 넣어 감사의 마음을 구체적으로 강조합니다."
            ),
            JapanesePhrase(
                id: 358,
                japaneseSentence: "よろしくお願いします。",
                hiragana: "よろしくおねがいします",
                koreanSentence: "잘 부탁드립니다.",
                romaji: "Yoroshiku onegai shimasu",
                koreanPronunciation: "요로시쿠 오네가이시마스",
                grammar: "자기소개, 무언가를 부탁할 때 등 만능으로 사용되는 일본어의 핵심 표현입니다. 관계의 시작을 부드럽게 만들어 줍니다."
            ),
            JapanesePhrase(
                id: 359,
                japaneseSentence: "どういたしまして。",
                hiragana: "どういたしまして",
                koreanSentence: "천만에요.",
                romaji: "Dōitashimashite",
                koreanPronunciation: "도-이타시마시테",
                grammar: "감사의 말에 대한 가장 표준적인 답변입니다. 이 표현을 자연스럽게 사용할 수 있다면 한 단계 높은 의사소통이 가능해집니다."
            ),
            JapanesePhrase(
                id: 360,
                japaneseSentence: "すみません。",
                hiragana: "すみません",
                koreanSentence: "죄송합니다. / 실례합니다. / 감사합니다.",
                romaji: "Sumimasen",
                koreanPronunciation: "스미마셍",
                grammar: "사과, 부름, 감사 등 다양한 상황에서 사용되는 가장 실용적인 표현 중 하나입니다. 이 말의 다양한 뉘앙스를 이해하는 것이 중요합니다."
            ),
            JapanesePhrase(
                id: 361,
                japaneseSentence: "では、お先に失礼します。",
                hiragana: "では、おさきにしつれいします",
                koreanSentence: "그럼, 먼저 실례하겠습니다.",
                romaji: "Dewa, o-saki ni shitsurei shimasu",
                koreanPronunciation: "데와, 오사키니 시츠레-시마스",
                grammar: "다른 사람보다 먼저 자리를 떠날 때 사용하는 필수 인사말입니다. 일본 사회 생활의 기본 예절 중 하나입니다."
            ),
            JapanesePhrase(
                id: 362,
                japaneseSentence: "お体に気をつけて。",
                hiragana: "おからだにきをつけて",
                koreanSentence: "몸 조심하세요.",
                romaji: "O-karada ni ki o tsukete",
                koreanPronunciation: "오카라다니 키오츠케테",
                grammar: "お元気で와 비슷하게, 상대방의 건강을 기원하는 헤어질 때의 인사말입니다. ください가 생략되어 조금 더 부드러운 느낌을 줍니다."
            ),
            JapanesePhrase(
                id: 363,
                japaneseSentence: "行ってきます。",
                hiragana: "いってきます",
                koreanSentence: "다녀오겠습니다.",
                romaji: "Ittekimasu",
                koreanPronunciation: "잇테키마스",
                grammar: "하루를 시작하며 집을 나설 때 사용하는 필수 인사입니다. '갔다가 돌아오겠다'는 약속이 담겨 있습니다."
            ),
            JapanesePhrase(
                id: 364,
                japaneseSentence: "行ってらっしゃい。",
                hiragana: "いってらっしゃい",
                koreanSentence: "다녀오세요.",
                romaji: "Itterasshai",
                koreanPronunciation: "잇테랏샤이",
                grammar: "나가는 사람에게 남아있는 사람이 하는 배웅 인사입니다. 行ってきます와 세트로 사용되는 일본의 중요한 일상 문화입니다."
            ),
            JapanesePhrase(
                id: 365,
                japaneseSentence: "お疲れ様でした。",
                hiragana: "おつかれさまでした",
                koreanSentence: "수고하셨습니다.",
                romaji: "Otsukaresama deshita",
                koreanPronunciation: "오츠카레사마데시타",
                grammar: "하루의 일과를 마치고 서로의 노고를 위로하고 칭찬하는, 일본어 소통의 핵심적인 마무리 인사입니다."
            ),
            JapanesePhrase(
                id: 361,
                japaneseSentence: "必要です",
                hiragana: "ひつようです",
                koreanSentence: "필요해요.",
                romaji: "Hitsuyō desu",
                koreanPronunciation: "히츠요-데스",
                grammar: "필요성을 표현하는 문장입니다. 必要(ひつよう)는 '필요한'이라는 뜻의 な형용사입니다."
            ),
            JapanesePhrase(
                id: 362,
                japaneseSentence: "危険です",
                hiragana: "きけんです",
                koreanSentence: "위험해요.",
                romaji: "Kiken desu",
                koreanPronunciation: "키켄데스",
                grammar: "위험을 표현하는 문장입니다. 危険(きけん)는 '위험한'이라는 뜻의 な형용사입니다."
            ),
            JapanesePhrase(
                id: 363,
                japaneseSentence: "面白いです",
                hiragana: "おもしろいです",
                koreanSentence: "재미있어요.",
                romaji: "Omoshiroi desu",
                koreanPronunciation: "오모시로이데스",
                grammar: "흥미로움을 표현하는 문장입니다. 面白い(おもしろい)는 '재미있다'라는 뜻의 い형용사입니다."
            ),
            JapanesePhrase(
                id: 364,
                japaneseSentence: "つまらないです",
                hiragana: "つまらないです",
                koreanSentence: "재미없어요.",
                romaji: "Tsumaranai desu",
                koreanPronunciation: "츠마라나이데스",
                grammar: "지루함을 표현하는 문장입니다. つまらない는 '재미없다'라는 뜻의 い형용사입니다."
            ),
            JapanesePhrase(
                id: 365,
                japaneseSentence: "最高です",
                hiragana: "さいこうです",
                koreanSentence: "최고예요!",
                romaji: "Saikō desu!",
                koreanPronunciation: "사이코-데스!",
                grammar: "최상의 평가를 표현하는 문장입니다. 最高(さいこう)는 '최고의'라는 뜻으로, 매우 긍정적인 감정을 나타낼 때 사용됩니다."
            ),
        ]
    }
}
