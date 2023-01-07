//
//  TitleViewModel.swift
//  Netflix
//
//  Created by Yan Moroz on 07.01.2023.
//

import Foundation

struct TitleViewModel {
    let titleName: String
    let posterURL: String
}

extension TitleViewModel {
    init(title: Title) {
        titleName = title.originalName ?? title.originalTitle ?? "Unknown"
        posterURL = title.posterPath ?? ""
    }
}
