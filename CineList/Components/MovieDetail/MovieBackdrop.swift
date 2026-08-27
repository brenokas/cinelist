//
//  MovieBackdrop.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI
import CachedAsyncImage

struct MovieBackdrop: View {
    let url: String?
    let movie: Movie
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if let movieBackdrop = url {
                    CachedAsyncImage(
                        url: URL(
                            string: "https://image.tmdb.org/t/p/w1280\(movieBackdrop)"
                        ),
                        urlCache: .imageCache
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
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
                    .frame(width: geometry.size.width, height: 300)
                    .clipped()
                } else {
                    Image(systemName: "film")
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                }
                
            }
            .frame(height: 300)
            
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0),
                    .init(color: Color(.systemBackground).opacity(0.85), location: 0.7),
                    .init(color: Color(.systemBackground), location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 140)
            .offset(y: 85)
            
            MoviePosterImage(url: movie.poster_path, width: 100, height: 150)
                .offset(y: 130)
        }
        .padding(.bottom, 60)
    }
}

#Preview {
    MovieBackdrop(url: nil, movie: Movie(
        id: 299534,
        backdrop_path: "/AvnqpRwlEaYNVL6wzC4RN94EdSd.jpg",
        title: "Avengers: Endgame",
        overview: "After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.",
        poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
        release_date: "2019-04-24",
        vote_average: 8.3,
        vote_count: 25000
    ))
}
