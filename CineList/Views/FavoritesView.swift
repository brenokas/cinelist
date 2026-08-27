//
//  FavoritesView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var languageSelected: Languages
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favoritesViewModel.favorites.isEmpty {
                    ContentUnavailableView("No favorites yet",
                                           systemImage: "heart",
                                           description: Text("Add a movie to see it here"),
                    )
                } else {
                    LazyVGrid (columns: columns, spacing: 10){
                        ForEach(favoritesViewModel.favorites, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                FavoriteMovieCard(movie: movie)
                            }
                            
                        }
                    }
            }
                
            }
            .navigationTitle("Favorites")
            .navigationSubtitle("\(favoritesViewModel.favorites.count) movies")
        }
        .onChange(of: languageSelected) {
            Task {
                await favoritesViewModel.refreshFavorites(languageSelected.rawValue)
            }
        }
    }
       
}

#Preview {
    let viewModel = FavoritesViewModel()

        viewModel.favorites = [
            Movie(
                id: 1,
                backdrop_path: nil,
                title: "Interestelar",
                overview: "Uma equipe viaja pelo espaço em busca de um novo lar para a humanidade.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "2014-11-06",
                vote_average: 8.6,
                vote_count: 1000,
            ),
            Movie(
                id: 2,
                backdrop_path: nil,
                title: "O Poderoso Chefão",
                overview: "A história de uma das famílias mais importantes da máfia.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "1972-03-24",
                vote_average: 8.7,
                vote_count: 2000,
            ),
            Movie(
                id: 3,
                backdrop_path: nil,
                title: "Parasita",
                overview: "Uma família tenta mudar sua condição social de forma inesperada.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "2019-05-30",
                vote_average: 8.5,
                vote_count: 1500,
            ),
            Movie(
                id: 4,
                backdrop_path: nil,
                title: "Interestelar",
                overview: "Uma equipe viaja pelo espaço em busca de um novo lar para a humanidade.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "2014-11-06",
                vote_average: 8.6,
                vote_count: 1000,
            ),
            Movie(
                id: 5,
                backdrop_path: nil,
                title: "Interestelar",
                overview: "Uma equipe viaja pelo espaço em busca de um novo lar para a humanidade.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "2014-11-06",
                vote_average: 8.6,
                vote_count: 1000,
            ),
            Movie(
                id: 6,
                backdrop_path: nil,
                title: "Interestelar",
                overview: "Uma equipe viaja pelo espaço em busca de um novo lar para a humanidade.",
                poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
                release_date: "2014-11-06",
                vote_average: 8.6,
                vote_count: 1000,
            ),
        ]
    
    return FavoritesView(languageSelected: .constant(.en))
        .environmentObject(viewModel)
    
}
