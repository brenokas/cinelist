//
//  CineListApp.swift
//  CineList
//
//  Created by breno.farias on 17/08/26.
//

import SwiftUI

@main
struct CineListApp: App {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var languageSelected = Languages.en

    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(languageSelected: $languageSelected)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
            .environmentObject(favoritesViewModel)
            .environment(\.locale, Locale(identifier: languageSelected.rawValue))
        }
    }
}
