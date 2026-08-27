//
//  MovieDetails.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI

struct MovieDetails: View {
    let movie: Movie
    
    var body: some View {
        Text(movie.title)
            .font(.title)
            .bold()
            .padding(.top, 10)

        HStack (spacing: 30){
            if let releaseDate = movie.release_date, !releaseDate.isEmpty {
                Text(releaseDate.formattedDate)
                    .font(.headline)
                    .foregroundStyle(.primary)
            } else {
                Text("Release date not available")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            
        
            HStack(spacing: 3){
                MovieRating(rating: movie.vote_average)
                    .fontWeight(.bold)
                
                if let voteCount = movie.vote_count {
                    Text("(\(voteCount))")
                        .foregroundStyle(Color(.secondaryLabel))
                        .textScale(.secondary)
                } else {
                    Text("(0)")
                        .foregroundStyle(Color(.secondaryLabel))
                        .textScale(.secondary)
                }
                
                
            }
            
        }
        
        Text(movie.overview.isEmpty ? "Overview not available" : movie.overview)
            .font(.body)
            .foregroundStyle(Color(.secondaryLabel))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    MovieDetails(movie: Movie(
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
