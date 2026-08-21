//
//  SettingsViewModel.swift
//  CineList
//
//  Created by breno.farias on 21/08/26.
//

import Combine
import Foundation

@MainActor
class SettingsViewModel: ObservableObject {
    private let themeKey = "selectedTheme"
    
    @Published var selectedTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: themeKey)
        }
    }
    
    init() {
        let savedTheme = UserDefaults.standard.string(forKey: themeKey)
        selectedTheme = AppTheme(rawValue: savedTheme ?? "") ?? .system
    }
}
