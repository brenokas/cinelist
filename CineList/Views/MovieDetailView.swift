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
                        AsyncImage(
                            url: URL(
                                string: "https://image.tmdb.org/t/p/w1280\(movie.backdrop_path)"
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
                    }
                    .frame(height: 300)
                    
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.poster_path)")) {
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
                }
                .padding(.bottom, 60)
                    
                Text(movie.title)
                    .font(.title)
                    .bold()
                    .padding(.top, 10)
                
                HStack (spacing: 30){
                    Text(formatDate(movie.release_date))
                        .font(.headline)
                        .foregroundStyle(.primary)
                
                    HStack(spacing: 3){
                        Image(systemName:"star.fill")
                            .foregroundStyle(.yellow)
                        
                        Text((movie.vote_average/2)
                            .formatted(.number.precision(.fractionLength(1))))
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text("(\(movie.vote_count))")
                            .foregroundStyle(Color(.secondaryLabel))
                            .textScale(.secondary)
                        
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
