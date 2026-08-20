//
//  FavoritesViewModel.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import Combine
import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
    @Published var errorMessage = ""
    @Published var showError = false
    
    private let service = MovieService()
    
    func addFavorite(_ movie: Movie) {
        guard !isFavorite(movie) else { return }
        favorites.append(movie)
    }
    
    func removeFavorite(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { $0.id == movie.id }
    }
    
    func refreshFavorites(_ language: String) async {
        let ids = favorites.map(\.id)

        do {
            var localizedMovies: [Movie] = []
            
            for id in ids {
                let movie = try await service.getMovieByID(id, language)
                localizedMovies.append(movie)
            }

            favorites = localizedMovies
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
