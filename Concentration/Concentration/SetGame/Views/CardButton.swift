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
    
    var card: SetCard? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var isFaceUp = false {
        didSet {
            if !isFaceUp {
                drawCardButton()
            }
            setNeedsDisplay()
        }
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: self)
    lazy var cardBehavior = CardDynamicBehavior(in: animator)
    
    // MARK: - Init
    
    init(frame: CGRect, card: SetCard) {
        super.init(frame: frame)
        self.card = card
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    
    override func draw(_ rect: CGRect) {
        drawCardButton()
        if isFaceUp == true {
            drawFinalSymbol()
        }
    }
    
    // MARK: - Animations
    
    private func turnFaceUp() {
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .transitionFlipFromBottom,
                          animations: {
                            self.isFaceUp = true
                          })
    }
    
    private func bounce() {
        self.cardBehavior.addItem(self)
    }
    
    func removeCardWithAnimation(to position: CGRect, delay: Double) {
        bounce()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.cardBehavior.removeItem(self!)
         //   self?.moveCardWithAnimation(to: position)
        })
        
        //        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.7,
        //                                                       delay: delay,
        //                                                       options: [],
        //                                                       animations: {
        //                                                        self.frame = position
        //                                                        self.isFaceUp = false
        //                                                        self.cardBehavior.addItem(self)
        //                                                       },
        //                                                       completion: {_ in
        //                                                        self.cardBehavior.removeItem(self)
        //                                                        self.isFaceUp = false
        //                                                       })
        //self.cardBehavior.addItem(self)
        //  _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        //  moveCardWithAnimation(to: position)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
        //            self.cardBehavior.removeItem(self)
        //            self.moveCardWithAnimation(to: position)
        //        }
    }
    
    //    @objc func onTimerFires()
    //    {
    //        self.cardBehavior.removeItem(self)
    //    }
    
    func dealCardWithAnimation(to position: CGRect, delay: Double) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: delay,
                                                       options: [],
                                                       animations: {
                                                        self.frame = position
                                                       },
                                                       completion: {_ in
                                                        self.turnFaceUp()
                                                       })
    }
    
    func moveCardWithAnimation(to position: CGRect) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0.2,
                                                       options: [],
                                                       animations: {
                                                        self.frame = position
                                                       })
    }
    

    
    // MARK: - Utils
    
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
