//
//  kotoba_kanjiApp.swift
//  kotoba_kanji
//
//  Created by EUIHYUNG JUNG on 6/26/25.
//

import SwiftUI
import SwiftData

// MARK: - App Root View
struct AppRootView: View {
    @State private var showSplash = true
    
    var body: some View {
        if showSplash {
            SplashView()
                .onAppear {
                    // 2.5초 후 메인 화면으로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showSplash = false
                    }
                }
        } else {
            MainTabView()
        }
    }
}

// MARK: - Splash Screen
struct SplashView: View {
    // 애니메이션 제거: 모든 값을 고정값으로 설정
    private let logoScale: CGFloat = 1.0
    private let logoOpacity: Double = 1.0
    private let textOpacity: Double = 1.0
    private let backgroundOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            // 배경 (따뜻한 베이지색 - 투명 이미지와 잘 어울림)
            Color.appBackground
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
            
            VStack(spacing: 8) { // 이미지와 텍스트를 가깝게
                Spacer() // 위쪽 여백
                
                // 로고 이미지 (앱 아이콘)
                Image("splash_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // 투명 배경 이미지에 맞게 fit 사용
                    .frame(width: 140, height: 140)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                
                // 앱 이름
                VStack(spacing: 8) {
                    Text("코토바 KANJI")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.tabBarSelectedDarker)
                    
                    Text("일본어 한자 학습")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray.opacity(0.8))
                }
                .opacity(textOpacity)
                
                Spacer()
                Spacer()
                Spacer() // 아래쪽 여백
            }
            .offset(y: 100) // 전체를 100픽셀 아래로 이동 (30 + 70)
        }
        // 애니메이션 제거: onAppear 블록 삭제
    }
}

@main
struct kotoba_kanjiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Kanji.self,
            KanjiExample.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // Load initial kanji data
            let context = container.mainContext
            KanjiManager.shared.loadInitialKanjiData(modelContext: context)
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
