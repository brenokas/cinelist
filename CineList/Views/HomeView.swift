//
//  HomeView.swift
//  CineList
//
//  Created by breno.farias on 17/08/26.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            NavigationStack {
                List() {
                    Section("Popular Movies") {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                HStack {
                                    if let posterPath = movie.poster_path {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                                            image.resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 100, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius:5))
                                        .border(Color.gray, width: 0.5)
                                    } else {
                                        Image(systemName: "film")
                                            .frame(width: 100, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius:5))
                                            .border(Color.gray, width: 0.5)
                                    }
                                    
                                    VStack(alignment: .leading){
                                        Text(movie.title)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        HStack(spacing:3){
                                            Image(systemName:"star.fill").foregroundStyle(.yellow)
                                            
                                            if let voteAverage = movie.vote_average {
                                                Text((voteAverage/2)
                                                    .formatted(.number.precision(.fractionLength(1))))
                                            } else {
                                                Text("(0)")
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                }
                .navigationTitle("CineList")
                .searchable(text: $searchText, placement: .navigationBarDrawer)
            }
            .onChange(of: searchText) {
                Task {
                    if searchText.isEmpty {
                        viewModel.movies.removeAll()
                        await viewModel.loadMovies(1)
                    } else if searchText.count >= 3 {
                        await viewModel.searchMovies(searchText)
                    }
                }
            }
            .task {
                if viewModel.isLoading {
                    return
                }
                
                await viewModel.loadMovies(1)
            }
            .alert("Error", isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            
            
            if viewModel.isLoading {
                HStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
