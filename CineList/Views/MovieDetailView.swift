//
//  MovieDetailView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }
        
        return outputFormatter.string(from: date)
        
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack {
                    GeometryReader { geometry in
                        if let movieBackdrop = movie.backdrop_path {
                            AsyncImage(
                                url: URL(
                                    string: "https://image.tmdb.org/t/p/w1280\(movieBackdrop)"
                                )
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
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
                    
                    if let moviePoster = movie.poster_path {
                        AsyncImage(
                            url: URL(string: "https://image.tmdb.org/t/p/w200\(moviePoster)")) {
                                image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(width: 100, height: 200)
                            .shadow(radius: 5)
                            .offset(y:130)
                    } else {
                        Image(systemName: "film")
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(width: 100, height: 200)
                            .shadow(radius: 5)
                            .offset(y:130)
                    }
                    
                }
                .padding(.bottom, 60)
                    
                Text(movie.title)
                    .font(.title)
                    .bold()
                    .padding(.top, 10)
                
                HStack (spacing: 30){
                    if let releaseDate = movie.release_date {
                        if releaseDate.isEmpty {
                            Text("Release date not available")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        }
                        Text(formatDate(releaseDate))
                            .font(.headline)
                            .foregroundStyle(.primary)
                    } else {
                        Text("Release date not available")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    
                
                    HStack(spacing: 3){
                        Image(systemName:"star.fill")
                            .foregroundStyle(.yellow)
                        
                        if let voteAverage = movie.vote_average {
                            Text((voteAverage/2)
                                .formatted(.number.precision(.fractionLength(1))))
                                .font(.headline)
                                .foregroundStyle(.primary)
                        } else {
                            Text("0,0")
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                        
                        if let voteCount = movie.vote_count {
                            Text("(\(voteCount))")
                                .foregroundStyle(Color(.secondaryLabel))
                                .textScale(.secondary)
                        } else {
                            Text("0,0")
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
}
