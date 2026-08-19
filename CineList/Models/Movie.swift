//
//  Movie.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

struct Movie: Decodable {
    let id: Int
    let backdrop_path: String?
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
