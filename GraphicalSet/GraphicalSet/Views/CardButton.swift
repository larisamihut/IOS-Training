//
//  CardButton.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import UIKit

class CardButton: UIButton {
    
    // MARK: - Properties
    
    enum Constants {
        static let buttonCornerRatio: CGFloat = 0.2
        static let symbolWidthRatio: CGFloat = 0.6
        static let symbolRatio: CGFloat = 0.4
        static let stripesXRatio: CGFloat = 0.03
        static let stripesPathRatio: CGFloat = 0.005
        static let layerCornerRadius: CGFloat = 10
    }
    
    var card: Card? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Init
    
    init(frame: CGRect, card: Card) {
        super.init(frame: frame)
        self.card = card
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Utils
    
    override func draw(_ rect: CGRect) {
        drawCardButton()
        drawFinalSymbol()
    }
    
    private func drawCardButton() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = Constants.layerCornerRadius
    }
    
    private func drawFinalSymbol() {
        guard let card = card else {
            return
        }
        
        switch card.number {
        case .one:
            drawSymbol(withBounds: centerSymbol)
        case .two:
            drawSymbol(withBounds: twoSymbolsTop)
            drawSymbol(withBounds: twoSymbolsBottom)
        case .three:
            drawSymbol(withBounds: threeSymbolsTop)
            drawSymbol(withBounds: centerSymbol)
            drawSymbol(withBounds: threeSymbolsBottom)
        }
    }
    
    private func drawSymbol(withBounds: CGRect) {
        switch card!.symbol {
        case .diamond: drawShading(on: DiamondSymbol.init(bounds: withBounds).draw() , bounds: withBounds)
        case .oval: drawShading(on: OvalSymbol.init(bounds: withBounds).draw() , bounds: withBounds)
        case .squiggle: drawShading(on: SquiggleSymbol.init(bounds: withBounds).draw() , bounds: withBounds)
        }
    }
    
    private func drawShading(on symbol: UIBezierPath, bounds: CGRect) {
        guard let cgContext = UIGraphicsGetCurrentContext() else {
            print("Current CGContext is nil, cannot draw shading.")
            return
        }
        cgContext.saveGState()
        switch card!.shading {
        case .solid:
            UIColor.color(from: card!.color).setFill()
            symbol.fill()
        case .unfilled:
            UIColor.color(from: card!.color).setStroke()
            symbol.stroke()
        case .striped:
            symbol.addClip()
            UIColor.color(from: card!.color).setStroke()
            symbol.stroke()
            computeStripes()
        }
        cgContext.restoreGState()
    }
    
    private func computeStripes() {
        var currentX: CGFloat = 0
        let stripedPath = UIBezierPath()
        stripedPath.lineWidth = Constants.stripesPathRatio * frame.size.width
        while currentX < frame.size.width {
            stripedPath.move(to: CGPoint(x: currentX, y: 0))
            stripedPath.addLine(to: CGPoint(x: currentX, y: frame.size.height))
            currentX += Constants.stripesXRatio * frame.size.width
        }
        UIColor.color(from: card!.color).setStroke()
        stripedPath.stroke()
    }
}
