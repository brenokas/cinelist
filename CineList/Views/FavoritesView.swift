//
//  FavoritesView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI
import CachedAsyncImage

struct MovieAverageRateModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .offset(x: 13, y: 120)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
    }
}

extension View {
    func movieAverageRateStyle() -> some View {
        modifier(MovieAverageRateModifier())
    }
}

struct FavoritesView: View {
    @Binding var languageSelected: Languages
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @StateObject private var homeViewModel = HomeViewModel()
    
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
                                ZStack {
                                    if let posterPath = movie.poster_path {
                                        CachedAsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
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
                                         
                                        
                                        LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                                        Text(movie.title)
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.white)
                                            .offset(x: 0, y: 100)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(10)
                                            .lineLimit(1)
                                        
                                        HStack (spacing: 0) {
                                            Image(systemName:"star.fill")
                                                .foregroundStyle(.yellow)
                                                .offset(x: 10, y: 120)
                                                .padding(0)
                                            
                                            if let voteAverage = movie.vote_average {
                                                Text(voteAverage / 2, format: .number.precision(.fractionLength(1)))
                                                    .movieAverageRateStyle()
                                            } else {
                                                Text("0,0")
                                                    .movieAverageRateStyle()
                                            }
                                        }
                                        
                                        
                                        
                                        
                                    } else {
                                        Image(systemName: "film")
                                            .frame(width: 100, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius:5))
                                            .border(Color.gray, width: 0.5)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .aspectRatio(2 / 3, contentMode: .fit)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius:15))
                                .shadow(radius: 5)
                                .padding(.horizontal, 10)
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
