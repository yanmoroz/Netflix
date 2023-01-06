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
    
    var description: String {
        switch self {
        case .apiKey: return "401407e903d0a8663e49a497eeefa10a"
        case .baseUrl: return "https://api.themoviedb.org"
        }
    }
}

enum Endpoints: CustomStringConvertible {
    case trendingMovies
    case trendingTV
    case upcomingMovies
    case popularMovies
    case topRatedMovies
    
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
                let  response = try JSONDecoder().decode(TopRatedMoviesResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
         }
        task.resume()
    }
}
