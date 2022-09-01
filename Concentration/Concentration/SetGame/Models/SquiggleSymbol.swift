//
//  SquiggleSymbol.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

class SquiggleSymbol: CardSymbol {
    
    // MARK: - Utils
    
    override func draw() -> UIBezierPath {
        let leftArcStart = CGPoint (x: bounds.minX + bounds.height / 4, y: bounds.maxY)
        let leftArcStop = CGPoint (x: bounds.minX + 3 * bounds.height / 4, y: bounds.minY)
        let rightArcStart = CGPoint (x: bounds.maxX - bounds.height / 4, y: bounds.minY)
        let rightArcStop = CGPoint (x: bounds.maxX - 3 * bounds.height / 4, y: bounds.maxY)
        
        bezierPath.move(to: leftArcStart)
        bezierPath.addCurve(to: leftArcStop,
                        controlPoint1: CGPoint(x: bounds.minX, y: bounds.maxY),
                        controlPoint2: CGPoint(x: bounds.minX, y: bounds.minY))
        bezierPath.addCurve(to: rightArcStart,
                        controlPoint1: CGPoint(x: bounds.midX + bounds.height / 4, y: bounds.minY),
                        controlPoint2: CGPoint(x: bounds.midX + bounds.height/4, y: bounds.midY))
        bezierPath.addCurve(to: rightArcStop,
                        controlPoint1: CGPoint(x: bounds.maxX, y: bounds.minY),
                        controlPoint2: CGPoint(x: bounds.maxX, y: bounds.maxY))
        bezierPath.addCurve(to: leftArcStart,
                        controlPoint1: CGPoint(x: bounds.midX - bounds.height / 2, y: bounds.midY),
                        controlPoint2: CGPoint(x: bounds.midX - bounds.height / 2, y: bounds.maxY))
        return bezierPath
    }
}
