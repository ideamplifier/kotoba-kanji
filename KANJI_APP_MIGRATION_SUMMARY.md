# 코토바 KANJI 앱 마이그레이션 완료

## 변경 사항 요약

### 1. 앱 구조 전환
- **전**: 일본어 대화 학습 앱 (JapanesePhrase 중심)
- **후**: 일본어 한자 학습 전용 앱 (Kanji 중심)

### 2. 주요 변경 내용

#### 탭 구성 (4개)
1. **홈**: 한자 학습 카드 (기존 대화 카드 → 한자 카드로 변경)
2. **즐겨찾기**: 한자 즐겨찾기
3. **검색**: 한자 검색
4. **설정**: 음성 설정 + KAIWA 앱 홍보

#### 제거된 파일
- `Item.swift` (JapanesePhrase 모델)
- `CardView.swift`, `CardFrontView.swift`, `CardBackView.swift`
- `ConversationManager.swift`, `ConversationBubbleView.swift`
- `KanjiHomeView.swift` (HomeView로 통합)

#### 수정된 파일
- `HomeView.swift`: 한자 학습 화면으로 완전 교체
- `FavoritesView.swift`: 한자 즐겨찾기로 변경
- `SearchView.swift`: 한자 검색으로 변경
- `SettingsView.swift`: KAIWA 앱 홍보 섹션 추가
- `MainTabView.swift`: 한자 탭 제거 (홈이 한자가 됨)
- `kotoba_kanjiApp.swift`: JapanesePhrase 관련 코드 제거

### 3. 새로운 기능
- 한자 학습 카드 (플립 애니메이션)
- 한자 정보: 의미, 음독/훈독, 부수, 획수, JLPT 레벨
- 이미지 기억법
- 예문 학습 (각 한자당 2개)
- TTS 발음 지원
- 즐겨찾기 시스템

### 4. 현재 데이터
- 10개 기본 한자 (日, 一, 人, 年, 大, 本, 中, 上, 下, 前)
- 20개 예문 (각 한자당 2개)

### 5. 앱 포지셔닝
- **코토바 KANJI**: 무료 한자 학습 앱 (광고 예정)
- **코토바 KAIWA**: 유료 대화 학습 앱 (홍보 대상)

### 6. 향후 계획
- 365개 한자 추가 예정
- 광고 삽입 예정
- 설정에서 KAIWA 앱으로 유도

## 빌드 및 실행
1. Xcode에서 프로젝트 열기
2. 빌드 (Cmd+B)
3. 실행 (Cmd+R)
4. 홈 탭에서 한자 학습 시작

## 주의사항
- 기존 대화 데이터는 모두 제거됨
- 한자 중심의 완전히 새로운 앱으로 전환됨
- KAIWA 앱 홍보를 통한 수익화 전략