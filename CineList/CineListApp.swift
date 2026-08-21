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
    @AppStorage("selectedLanguage") private var selectedLanguage = Languages.en.rawValue
    
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
    
    private var languageSelected: Binding<Languages> {
        Binding(
            get: {
                Languages(rawValue: selectedLanguage) ?? .en
            }, set: {
                selectedLanguage = $0.rawValue
        })
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab){
                FavoritesView(languageSelected: languageSelected)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                    .tag("favorites")
                HomeView(languageSelected: languageSelected)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag("home")
                SettingsView(languageSelected: languageSelected)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag("settings")
            }
            .environmentObject(favoritesViewModel)
            .environmentObject(settingsViewModel)
            .environment(\.locale,
                          Locale(identifier: Languages(rawValue: selectedLanguage)?.rawValue ?? Languages.en.rawValue))
            .preferredColorScheme(colorScheme)
        }
    }
}
