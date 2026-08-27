//
//  HomeView.swift
//  CineList
//
//  Created by breno.farias on 17/08/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var languageSelected: Languages
    @State private var searchText = ""
    @StateObject private var viewModel = HomeViewModel()
    
    private func reloadMovies() {
        Task {
            if searchText.isEmpty {
                viewModel.movies.removeAll()
                await viewModel.loadMovies(1, languageSelected.rawValue)
            } else if searchText.count >= 3 {
                await viewModel.searchMovies(searchText, languageSelected.rawValue)
            }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                List() {
                    Section("Popular Movies") {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieListRow(movie: movie)
                            }
                        }
                    }
                }
                .navigationTitle("CineList")
                .searchable(text: $searchText, placement: .navigationBarDrawer)
            }
            .onChange(of: searchText) {
                reloadMovies()
            }
            .onChange(of: languageSelected) {
                reloadMovies()
            }
            .task {
                if viewModel.isLoading {
                    return
                }
                
                await viewModel.loadMovies(1, languageSelected.rawValue)
            }
            .alert("Error", isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            
            
            if viewModel.isLoading {
                HStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var languageSelected = Languages.en

    HomeView(languageSelected: $languageSelected)
}
