//
//  HomeViewModel.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import Combine
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var isLoading = false
    
    private let service = MovieService()
    
    func loadMovies(_ page: Int) async {
        isLoading = true
        do {
            let response = try await service.getMovies(page)
            
            if page == 1 {
                movies = response.results
            } else {
                movies.append(contentsOf: response.results)
            }
            
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        
        isLoading = false
    }
    
    func searchMovies(_ query: String) async {
        isLoading = true
        
        do {
            let response = try await service.searchMovies(query)
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            print(error)
        }
        
        isLoading = false
    }
    
    
}
