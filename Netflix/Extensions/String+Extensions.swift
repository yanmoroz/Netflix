//
//  String+Extensions.swift
//  Netflix
//
//  Created by Yan Moroz on 05.01.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        let firstLetter = self.prefix(1).uppercased()
        let tail = self.lowercased().dropFirst()
        return "\(firstLetter)\(tail)"
    }
}
