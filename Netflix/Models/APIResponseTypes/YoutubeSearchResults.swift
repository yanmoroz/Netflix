//
//  YoutubeSearchResults.swift
//  Netflix
//
//  Created by Yan Moroz on 08.01.2023.
//

import Foundation

struct YoutubeSearchResults: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let kind, etag: String
    let id: ID
}

struct ID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
