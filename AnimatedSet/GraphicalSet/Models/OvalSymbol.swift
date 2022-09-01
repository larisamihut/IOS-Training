//
//  OvalSymbol.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

class OvalSymbol: CardSymbol {
    
    // MARK: - Utils
    
    override func draw() -> UIBezierPath {
        let bezierPath = UIBezierPath(roundedRect: bounds, cornerRadius: symbolSize.height * 0.5)
        
        return bezierPath
    }
}
