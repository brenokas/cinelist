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
    
    func loadMovies(_ page: Int, _ language: String) async {
        isLoading = true
        do {
            let response = try await service.getMovies(page, language)
            
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
    
    func searchMovies(_ query: String, _ language: String) async {
        isLoading = true
        
        do {
            let response = try await service.searchMovies(query, language)
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            print(error)
        }
        
        isLoading = false
    }
    
    
}
