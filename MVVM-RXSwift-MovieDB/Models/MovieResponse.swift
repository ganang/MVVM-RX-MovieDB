//
//  MovieResponse.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit

struct MovieResponse: Codable {
    var page, totalResults, totalPages: Int
    var results: [Movie]
}

struct Movie: Codable, Hashable {
    
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Double
    let overview : String
    let releaseDate: String
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
