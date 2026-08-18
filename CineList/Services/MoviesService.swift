//
//  MoviesService.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import Foundation

func getMovies(_ page: Int) async throws -> MovieResponse {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?page=\(page)") else {
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.setValue(
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOGU2YWU5OTZiNzU3OGJjNmE4NTBlNmIxNTZkMjQ3ZCIsIm5iZiI6MTc4NzA1NTc4Ny44ODgsInN1YiI6IjZhODQ0ZWFiOGI1NmMzYWJmZDU5NTk0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.s-XF3cIvayLZEGJDhmv4xAXhAcm2IKETKaKTsqPq4vQ",
        forHTTPHeaderField: "Authorization"
    )
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    return try JSONDecoder().decode(MovieResponse.self, from: data)
}
