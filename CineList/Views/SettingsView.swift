//
//  SettingsView.swift
//  CineList
//
//  Created by breno.farias on 21/08/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var languageSelected: Languages
    
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Language", selection: $languageSelected) {
                    ForEach(Languages.allCases, id:\.self) { language in
                        Text(LocalizedStringKey(language.displayName))
                            .tag(language)
                    }
                }
                Picker("Theme", selection: $viewModel.selectedTheme) {
                    Text("System").tag(AppTheme.system)
                    Text("Light").tag(AppTheme.light)
                    Text("Dark").tag(AppTheme.dark)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    @Previewable @State var languageSelected = Languages.en

    SettingsView(languageSelected: $languageSelected)
        .environmentObject(SettingsViewModel())
}
