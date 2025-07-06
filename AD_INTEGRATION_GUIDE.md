# 광고 통합 가이드

## 현재 구현 상태

### 배너 광고 위치
- **HomeView**: 하단 네비게이션 버튼 바로 위에 배치
- 위치: 카드와 네비게이션 버튼 사이
- 높이: 50pt
- 여백: 좌우 16pt, 하단 8pt

### BannerAdView 구조
```swift
// Views/BannerAdView.swift
- 현재는 플레이스홀더로 구현
- 실제 광고 SDK 연동 시 교체 필요
```

## 광고 SDK 통합 방법

### 1. Google AdMob 사용 시
```swift
// 1. Podfile에 추가
pod 'Google-Mobile-Ads-SDK'

// 2. Info.plist에 앱 ID 추가
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXX~YYYYYYYYYY</string>

// 3. BannerAdView.swift 수정
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-XXXXXXXXXX/ZZZZZZZZZZ"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}
```

### 2. 테스트 광고 ID
- 앱 ID: `ca-app-pub-3940256099942544~1458002511`
- 배너 광고 ID: `ca-app-pub-3940256099942544/2934735716`

## 추가 광고 위치 제안

### 현재 미구현 (향후 고려사항)
1. **전면 광고**: 한자 학습 10개마다 표시
2. **보상형 광고**: 프리미엄 기능 임시 해제
3. **네이티브 광고**: 검색 결과 사이에 삽입

## 수익화 전략

### 무료 버전
- 배너 광고 상시 노출
- 전면 광고 주기적 노출

### 프리미엄 버전 (향후)
- 광고 제거
- 추가 기능 제공
- 오프라인 모드

## 주의사항
1. 광고가 학습 콘텐츠를 가리지 않도록 주의
2. 광고 로딩 실패 시 레이아웃이 깨지지 않도록 처리
3. 어린이 대상 앱인 경우 COPPA 준수 필요
4. 광고 정책 준수 (클릭 유도 금지 등)