//
//  FavoritesView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI
import CachedAsyncImage

extension URLCache {
    static let imageCache: URLCache = {
        URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024,
            diskPath: "image-cache"
        )
    }()
}

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favoritesViewModel.favorites.isEmpty {
                    ContentUnavailableView("No favorites yet",
                                           systemImage: "heart",
                                           description: Text("Add a movie to see it here"))
                } else {
                    LazyVGrid (columns: columns, spacing: 7){
                        ForEach(favoritesViewModel.favorites, id: \.id) { movie in
                            if let posterPath = movie.poster_path {
                                CachedAsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)"),
                                                 urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFill()
                                    case .failure:
                                        Image(systemName: "film")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(25)
                                            .foregroundStyle(.secondary)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                                 .frame(width: 100, height: 150)
                                                 .clipped()
                                                 .clipShape(RoundedRectangle(cornerRadius:5))
                                                 .border(Color.gray, width: 0.5)
                            } else {
                                Image(systemName: "film")
                                    .frame(width: 100, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius:5))
                                    .border(Color.gray, width: 0.5)
                            }
                        }
                    }
            }
                
            }.navigationTitle("Favorites")
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
    
    return FavoritesView()
        .environmentObject(viewModel)
    
}
