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
    
    private var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return viewModel.movies
        }
        
        return viewModel.movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    
    var body: some View {
        ZStack {
            NavigationStack {
                List() {
                    Section("Popular Movies") {
                        ForEach(filteredMovies, id: \.id) { movie in
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
                                            Text((movie.vote_average/2).formatted(.number.precision(.fractionLength(1))))
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
