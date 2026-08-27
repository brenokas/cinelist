//
//  MovieDetailView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                MovieBackdrop(url: movie.backdrop_path, movie: movie)
                MovieDetails(movie: movie)
                FavoriteMovieButton(isFavorite: favoritesViewModel.isFavorite(movie)) {
                    if favoritesViewModel.isFavorite(movie) {
                        favoritesViewModel.removeFavorite(movie)
                    } else {
                        favoritesViewModel.addFavorite(movie)
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(edges:.top)
                
        
        
    }
}

#Preview {
    MovieDetailView(movie: Movie(
        id: 299534,
        backdrop_path: "/AvnqpRwlEaYNVL6wzC4RN94EdSd.jpg",
        title: "Avengers: Endgame",
        overview: "After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.",
        poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
        release_date: "2019-04-24",
        vote_average: 8.3,
        vote_count: 25000
    ))
    .environmentObject(FavoritesViewModel())
}
