//
//  APICaller.swift
//  Netflix
//
//  Created by Yan Moroz on 05.01.2023.
//

import Foundation

enum Constants: CustomStringConvertible {
    case apiKey
    case baseUrl
    case youtubeAPIKey
    case youtubeBaseUrl
    
    var description: String {
        switch self {
        case .apiKey: return "401407e903d0a8663e49a497eeefa10a"
        case .baseUrl: return "https://api.themoviedb.org"
        case .youtubeAPIKey: return "AIzaSyBXi1gqEX_Aqw6xgLxIiHfLxCdi7nOW6Gs"
        case .youtubeBaseUrl: return "https://youtube.googleapis.com/youtube/v3/search?"
        }
    }
}

// https://youtube.googleapis.com/youtube/v3/search?key=[YOUR_API_KEY]

enum Endpoints: CustomStringConvertible {
    case trendingMovies
    case trendingTV
    case upcomingMovies
    case popularMovies
    case topRatedMovies
    case discoverMovies
    case search(query: String)
    case getMovie(query: String)
    
    var description: String {
        switch self {
        case .trendingMovies:
            return "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)"
        case .trendingTV:
            return "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)"
        case .upcomingMovies:
            return "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1"
        case .popularMovies:
            return "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1"
        case .topRatedMovies:
            return "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1"
        case .discoverMovies:
            return "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        case .search(let query):
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            return "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query)"
        case .getMovie(let query):
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            return "\(Constants.youtubeBaseUrl)q=\(query)&key=\(Constants.youtubeAPIKey)"
        }
    }
}

enum APIError: Error {
    case failedToGetData
}

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.trendingMovies)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.trendingTV)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TrendingTVResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.upcomingMovies)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UpcomingMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.popularMovies)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.topRatedMovies)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TopRatedMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.discoverMovies)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DiscoverMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.search(query: query))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DiscoverMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.getMovie(query: query))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(YoutubeSearchResults.self, from: data)
                completion(.success(response.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
