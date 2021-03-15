//
//  MovieService.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit

protocol MovieService {

    func getPopularMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    func getTopRatedMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    func getNowPlayingMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
}

public enum MovieEndPoint: String, CaseIterable, Identifiable {
    
    public var id: String { self.rawValue }
    
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case popular
}

public enum MovieError: Error {
    case errorFromApi
    case noData
    case invalidEndpoint
    case invalidResponse
    case serializationError
}
