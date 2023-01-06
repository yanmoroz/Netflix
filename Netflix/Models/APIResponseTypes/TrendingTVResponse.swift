//
//  TrendingTVsResponse.swift
//  Netflix
//
//  Created by Yan Moroz on 06.01.2023.
//

import Foundation

struct TrendingTVResponse: Codable {
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
