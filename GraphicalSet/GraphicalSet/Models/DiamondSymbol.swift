//
//  DiamondSymbol.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

class DiamondSymbol: CardSymbol {
    
    // MARK: - Utils
    
    override func draw() -> UIBezierPath {
        bezierPath.move(to: CGPoint(x: bounds.origin.x, y: bounds.midY))
        bezierPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.origin.y))
        bezierPath.addLine(to: CGPoint(x: bounds.origin.x + bounds.size.width, y: bounds.midY))
        bezierPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.origin.y + bounds.size.height))
        bezierPath.close()
        
        return bezierPath
    }
}
