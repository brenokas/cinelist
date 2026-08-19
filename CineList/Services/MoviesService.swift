//
//  MoviesService.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import Foundation

class MovieService {
    func getMovies(_ page: Int) async throws -> MovieResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?page=\(page)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(
            "Bearer \(ProcessInfo.processInfo.environment["API_KEY"]!)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(MovieResponse.self, from: data)
    }
    
    func searchMovies(_ movieName: String) async throws -> MovieResponse {
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        components.queryItems = [
            URLQueryItem(name: "query", value: movieName)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(
            "Bearer \(ProcessInfo.processInfo.environment["API_KEY"]!)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(MovieResponse.self, from: data)
    }

}

