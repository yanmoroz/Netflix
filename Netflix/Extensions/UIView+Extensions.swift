//
//  UIView+Extensions.swift
//  Netflix
//
//  Created by Yan Moroz on 04.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}
