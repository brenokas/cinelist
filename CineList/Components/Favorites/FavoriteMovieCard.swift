//
//  FavoriteMovieCard.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI

struct FavoriteMovieCard: View {
    let movie: Movie
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            MoviePosterImage(
                url: movie.poster_path,
                width: 180,
                height: 300)

            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
            
            VStack (alignment: .leading, spacing: 4){
                Text(movie.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                
                MovieRating(rating: movie.vote_average)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.caption)
            }
            .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .aspectRatio(2 / 3, contentMode: .fit)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius:15))
        .shadow(radius: 5)
        .padding(.horizontal, 10)
    }
}

#Preview {
    FavoriteMovieCard(movie: Movie(
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
