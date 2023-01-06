//
//  UpcomingMoviesResponse.swift
//  Netflix
//
//  Created by Yan Moroz on 06.01.2023.
//

import Foundation

struct UpcomingMoviesResponse: Codable {
    let dates: Dates
    let page: Int
    let results: [Title]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Dates: Codable {
        let maximum, minimum: String
    }
}
