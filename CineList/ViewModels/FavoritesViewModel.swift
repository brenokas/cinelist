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
    
    func addFavorite(_ movie: Movie) {
        favorites.append(movie)
    }
    
    func removeFavorite(_ movie: Movie) {
        favorites.remove(at: favorites.firstIndex(of: movie)!)
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(movie)
    }
}
