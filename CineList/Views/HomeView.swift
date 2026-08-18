//
//  HomeView.swift
//  CineList
//
//  Created by breno.farias on 17/08/26.
//

import SwiftUI

struct HomeView: View {
    
    @State private var movies: [Movie] = []
    @State private var errorMessage = ""
    @State private var showError = false
    
    func loadMovies(_ page: Int) async {
        do {
            let response = try await getMovies(page)
            movies.append(contentsOf: response.results)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    var body: some View {
        NavigationStack {
            List() {
                Section("Popular Movies") {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                                    image.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .border(Color.gray, width: 0.5)
                                .frame(width: 100, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius:5))
                                
                                VStack(alignment: .leading){
                                    Text(movie.title)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    HStack(spacing:3){
                                        Image(systemName:"star.fill").foregroundStyle(.yellow)
                                        Text(movie.vote_average.formatted(.number.precision(.fractionLength(1))))
                                    }
                                }
                                
                            }

                        }
                    }
                }
            }
            .navigationTitle("CineList")
        }
        .task {
            await loadMovies(1)
        }
        .alert("Error", isPresented: $showError) {
            
        } message: {
            Text(errorMessage)
        }
    }
}

#Preview {
    HomeView()
}
