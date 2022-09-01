//
//  CardSymbol.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

class CardSymbol {
    
    // MARK: - Properties
    
    enum Constants {
        static let symbolWidthRatio: CGFloat = 0.8
        static let symbolRatio: CGFloat = 0.4
    }
    
    let bezierPath = UIBezierPath()
    var bounds: CGRect
    
    var symbolWidth: CGFloat {
        return bounds.size.width * Constants.symbolWidthRatio
    }
    
    var symbolSize: CGSize {
        return CGSize(width: symbolWidth, height: symbolWidth * Constants.symbolRatio)
    }
    
    // MARK: - Init
    
    init(bounds: CGRect) {
        self.bounds = bounds
    }
    
    // MARK: - Utils
    
    func draw() -> UIBezierPath {
        return bezierPath
    }
}
