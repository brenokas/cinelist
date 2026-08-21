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
    @StateObject private var settingsViewModel = SettingsViewModel()
    @State private var languageSelected = Languages.en
    
    @State private var selectedTab = "home"
    
    private var colorScheme: ColorScheme? {
        switch settingsViewModel.selectedTheme {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab){
                FavoritesView(languageSelected: $languageSelected)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                    .tag("favorites")
                HomeView(languageSelected: $languageSelected)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag("home")
                SettingsView(languageSelected: $languageSelected)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag("settings")
            }
            .environmentObject(favoritesViewModel)
            .environmentObject(settingsViewModel)
            .environment(\.locale, Locale(identifier: languageSelected.rawValue))
            .preferredColorScheme(colorScheme)
        }
    }
}
