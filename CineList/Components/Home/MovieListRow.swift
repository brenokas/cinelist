//
//  MovieListRow.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI

struct MovieListRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            MoviePosterImage(url: movie.poster_path, width: 100, height: 150)
            
            VStack(alignment: .leading){
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                MovieRating(rating: movie.vote_average)
            }
        }
    }
}

#Preview {
    MovieListRow(movie: Movie(
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
