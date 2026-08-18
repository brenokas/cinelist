//
//  MovieDetailView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(
                    string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)"
                )
            ) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)

            Text(movie.title)
                .font(.title)
                .bold()

            Text(movie.overview)
                .padding()

            Text("Nota: \(movie.vote_average, specifier: "%.1f")")
        }
        .padding()
    }
}

#Preview {
    MovieDetailView(movie: Movie(
        id: 299534,
        backdrop_path: "/7RyHsO4yDXtBv1zUU2Jf7x0bQqA.jpg",
        title: "Avengers: Endgame",
        overview: "After the devastating events of Avengers: Infinity War...",
        poster_path: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
        release_date: "2019-04-24",
        vote_average: 8.3,
        vote_count: 25000
    ))
}
