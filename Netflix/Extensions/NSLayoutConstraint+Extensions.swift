//
//  NSLayoutConstraint+Extensions.swift
//  Netflix
//
//  Created by Yan Moroz on 04.01.2023.
//

import UIKit

extension NSLayoutConstraint {
    class func activate(_ constraints: [NSLayoutConstraint]...) {
        constraints.forEach({ self.activate($0) })
    }
}
