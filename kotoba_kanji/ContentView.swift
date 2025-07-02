//
//  ContentView.swift
//  kotoba_kanji
//
//  Created by EUIHYUNG JUNG on 6/26/25.
//

import SwiftUI
import SwiftData

// MARK: - Content View (Main Entry Point)
struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: JapanesePhrase.self, inMemory: true)
} 