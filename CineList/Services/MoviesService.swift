//
//  MoviesService.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import Foundation

class MovieService {
    func doRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(
            "Bearer \(ProcessInfo.processInfo.environment["API_KEY"]!)",
            forHTTPHeaderField: "Authorization"
        )
        
        return request
    }
    
    func getMovies(_ page: Int, _ language: String) async throws -> MovieResponse {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = doRequest(url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(MovieResponse.self, from: data)
    }
    
    func searchMovies(_ movieName: String, _ language: String) async throws -> MovieResponse {
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        components.queryItems = [
            URLQueryItem(name: "query", value: movieName),
            URLQueryItem(name: "language", value: language)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = doRequest(url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(MovieResponse.self, from: data)
    }

}

