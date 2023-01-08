//
//  DiscoverMoviesResponse.swift
//  Netflix
//
//  Created by Yan Moroz on 08.01.2023.
//

import Foundation

struct DiscoverMoviesResponse: Codable {
    let page: Int
    let results: [Title]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
