//
//  MovieService.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit

protocol MovieService {
    
    func getMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
}

public enum MovieEndPoint: String, CaseIterable, Identifiable {
    
    public var id: String { self.rawValue }
    
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming
    case popular
    
    public var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
    }
    
    public init?(index: Int) {
        switch index {
        case 0: self = .nowPlaying
        case 1: self = .popular
        case 2: self = .upcoming
        case 3: self = .topRated
        default: return nil
        }
    }
    
    public init?(description: String) {
        guard let first = MovieEndPoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
}

public enum MovieError: Error {
    case errorFromApi
    case noData
    case invalidEndpoint
    case invalidResponse
    case serializationError
}
