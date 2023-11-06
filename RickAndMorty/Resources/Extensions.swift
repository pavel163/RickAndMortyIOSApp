//
//  Extensions.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 06.11.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
