//
//  MovieResponse.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
