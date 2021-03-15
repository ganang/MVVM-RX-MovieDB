//
//  MovieProvider.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//


import UIKit

public class MovieProvider: MovieService {
    
    public static let shared = MovieProvider()
    private init() {}
    
    private let baseUrl = BaseURL.URL
    private let apiKey = "eb530ae02d8e9e65bfd26894ec45c2fc"
    
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func getPopularMovies(endpoint: MovieEndPoint, params: [String : Any]?, onSuccess: @escaping (MovieResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handleRequest(requestedObjectType: MovieResponse.self, method: "GET", endpoint: "/movie/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    func getTopRatedMovies(endpoint: MovieEndPoint, params: [String : Any]?, onSuccess: @escaping (MovieResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handleRequest(requestedObjectType: MovieResponse.self, method: "GET", endpoint: "/movie/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    func getNowPlayingMovies(endpoint: MovieEndPoint, params: [String : Any]?, onSuccess: @escaping (MovieResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handleRequest(requestedObjectType: MovieResponse.self, method: "GET", endpoint: "/movie/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    // function for handling api Request with generic type, so it can always be used later
    private func handleRequest<T:Codable>(requestedObjectType:T.Type, method: String, endpoint: String, params: [String : Any]?, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void){
        
        guard var urlComponents = URLComponents(string: "\(self.baseUrl)\(endpoint)") else {
            onError(MovieError.invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value as? String) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            onError(MovieError.invalidEndpoint)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.errorHandler(onErrorCallback: onError, error: MovieError.errorFromApi)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.errorHandler(onErrorCallback: onError, error: MovieError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.errorHandler(onErrorCallback: onError, error: MovieError.noData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(response)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }

    // handle error here
    private func errorHandler(onErrorCallback: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            onErrorCallback(error)
        }
    }
}
