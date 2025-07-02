import SwiftUI

// MARK: - Main Tab View
struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showVoiceSettingsModal = false
    @State private var navigateToCardNumber: Int?
    @AppStorage("hasShownVoiceSettingsModal_v2") private var hasShownVoiceSettingsModal = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                        .font(StyleConstants.Typography.koreanDynamic(.caption2))
                }
                .accessibilityLabel("홈 탭")
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("즐겨찾기")
                        .font(StyleConstants.Typography.koreanDynamic(.caption2))
                }
                .accessibilityLabel("즐겨찾기 탭")
                .tag(1)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                        .font(StyleConstants.Typography.koreanDynamic(.caption2))
                }
                .accessibilityLabel("검색 탭")
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                        .font(StyleConstants.Typography.koreanDynamic(.caption2))
                }
                .accessibilityLabel("설정 탭")
                .tag(3)
        }
        .accentColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
        .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
        .onChange(of: selectedTab) { oldValue, newValue in
            HapticManager.shared.impact(.light, intensity: 0.4)
        }
        .onAppear {
            // MainTabView appeared
            if !hasShownVoiceSettingsModal {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // Showing voice settings modal
                    showVoiceSettingsModal = true
                }
            }
        }
        .sheet(isPresented: $showVoiceSettingsModal) {
            VoiceSettingsGuideView(isPresented: $showVoiceSettingsModal) {
                hasShownVoiceSettingsModal = true
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(24)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NavigateToCard"))) { notification in
            if let cardNumber = notification.userInfo?["cardNumber"] as? Int {
                // Dismiss any presented modals first
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.dismiss(animated: true) {
                        // Switch to home tab
                        selectedTab = 0
                        // Post another notification for HomeView to navigate to specific card
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            NotificationCenter.default.post(
                                name: Notification.Name("ScrollToCard"),
                                object: nil,
                                userInfo: ["cardNumber": cardNumber]
                            )
                        }
                    }
                } else {
                    // If no modal is presented, just switch tab
                    selectedTab = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        NotificationCenter.default.post(
                            name: Notification.Name("ScrollToCard"),
                            object: nil,
                            userInfo: ["cardNumber": cardNumber]
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Voice Settings Guide View
struct VoiceSettingsGuideView: View {
    @Binding var isPresented: Bool
    let onDismiss: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("일본어 음성 설정 안내")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color.naturalTextColor)
                .padding(.top, 30)
            
            // Description
            VStack(spacing: 16) {
                Text("더 자연스러운 일본어 발음을 위해\n고품질 음성을 다운로드하시는 것을 추천합니다.")
                    .font(.system(size: 15))
                    .foregroundColor(StyleConstants.Colors.adaptiveTextSecondary(colorScheme))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                // Steps
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 10) {
                        Text("1.")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        Text("설정 > 손쉬운 사용 > 콘텐츠 말하기")
                            .font(.system(size: 15))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    }
                    
                    HStack(alignment: .top, spacing: 10) {
                        Text("2.")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        Text("음성 > 일본어 선택")
                            .font(.system(size: 15))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    }
                    
                    HStack(alignment: .top, spacing: 10) {
                        Text("3.")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        Text("고품질 음성 다운로드")
                            .font(.system(size: 15))
                            .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(StyleConstants.Colors.adaptiveCardBackground(colorScheme))
                )
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 10) {
                Button(action: {
                    // Open Accessibility > Spoken Content > Voices settings
                    if let url = URL(string: "App-prefs:root=General&path=ACCESSIBILITY/SPEECH") {
                        UIApplication.shared.open(url) { success in
                            if !success {
                                // Fallback to general accessibility settings
                                if let fallbackUrl = URL(string: "App-prefs:root=General&path=ACCESSIBILITY") {
                                    UIApplication.shared.open(fallbackUrl)
                                }
                            }
                        }
                    }
                    onDismiss()
                    isPresented = false
                }) {
                    Text("설정으로 이동")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.adaptive(light: .tabBarSelected, dark: .tabBarSelectedDark, for: colorScheme))
                        .cornerRadius(12)
                }
                
                Button(action: {
                    onDismiss()
                    isPresented = false
                }) {
                    Text("나중에 설정")
                        .font(.system(size: 16))
                        .foregroundColor(StyleConstants.Colors.adaptiveTextPrimary(colorScheme))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(StyleConstants.Colors.adaptiveButtonBackground(colorScheme))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(StyleConstants.Colors.adaptiveAppBackground(colorScheme))
    }
} 