//
//  MovieViewViewModel.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 16/03/21.
//

import Foundation

struct MovieViewViewModel {
    
    private var movie: Movie
    
    private static let dateFormatter: DateFormatter = {
        $0.dateStyle = .medium
        $0.timeStyle = .none
        return $0
    }(DateFormatter())
    
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var title: String {
        return movie.title + " (\(releaseDate.prefix(4)))"
    }
    
    var overview: String {
        return movie.overview
    }
    
    var posterURL: URL {
        return movie.posterURL
    }
    
    var rating: String {
        let rating = Int(movie.voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
    
}
