//
//  CardContainerView.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import UIKit

class CardContainerView: UIView {
    
    // MARK: - Properties
    
    private enum Constants {
        static let cardAspectRatio: CGFloat = 2/3
        static let boundsCoordinatesRatio: CGFloat = 0.001
        static let boundsSizeRatio: CGFloat = 0.99
        static let insetValue: CGFloat = 3
    }
    
    var cardButtons = [CardButton]()
    private(set) var grid = Grid(layout: Grid.Layout.aspectRatio(Constants.cardAspectRatio))
    private var viewFrame: CGRect {
        get {
            return CGRect(x: bounds.size.width * Constants.boundsCoordinatesRatio,
                          y: bounds.size.height * Constants.boundsCoordinatesRatio,
                          width: bounds.size.width * Constants.boundsSizeRatio,
                          height: bounds.size.height * Constants.boundsSizeRatio)
        }
    }
    
    var deck: CGRect {
        get {
            return CGRect(origin: CGPoint(x: 0, y: bounds.maxY),
                          size: CGSize(width: 80, height: 120))
        }
    }
    
    var discardPoint: CGRect {
        get {
            return CGRect(origin: CGPoint(x: bounds.midX, y: bounds.maxY),
                          size: CGSize(width: 80, height: 120))
        }
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: - Utils
    
    func createCardButtons(for cards: [SetCard]) {
        let buttons = cards.map { CardButton(frame: deck, card: $0) }
        buttons.forEach { addSubview($0) }
        cardButtons += buttons
        grid.cellCount = cardButtons.count
    }
    
    func addCardButtons(for cards: [SetCard]) {
        createCardButtons(for: cards)
        var delay = 0.2
        var cellIndex = grid.cellCount - cards.count
        cards.forEach({_ in
            dealCard(with: cellIndex, delay: delay)
            cellIndex += 1
            delay += 0.2
        })
    }
    
    func updateCardButtons(with cards: [SetCard], using positions: [Int]) {
       // var delay = 0
        // remove cards from view
        for index in positions.indices {
            removeCard(on: cardButtons[positions[index]], delay: 0)
        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)) {
        //          //  self.cardBehavior.removeItem(self)
        //          //  self.moveCardWithAnimation(to: position)
        //            for index in positions.indices {
        //                self.cardButtons[positions[index]].moveCardWithAnimation(to: self.discardPoint)
        //            }
        //        }
        // add cards from deck
//        for index in positions.indices {
//            delay += 0.7
//            cardButtons[positions[index]].card = cards[index]
//            dealCard(with: positions[index], delay: delay)
//        }
    }
    
    func refreshCardButtons(with cards: [SetCard]) {
        clearCardContainer()
        addCardButtons(for: cards)
    }
    
    private func configureUI() {
        grid.frame = viewFrame
        for (buttonIndex, button) in cardButtons.enumerated() {
            if let buttonFrame = grid[buttonIndex] {
                button.moveCardWithAnimation(to: buttonFrame.insetBy(dx: Constants.insetValue,
                                                                     dy: Constants.insetValue))
            }
        }
    }
    
    private func dealCard(with index: Int, delay: Double) {
        if let buttonFrame = grid[index] {
            cardButtons[index].dealCardWithAnimation(to: buttonFrame, delay: delay)
        }
    }
    
    private func removeCard(on button: CardButton, delay: Double) {
        button.removeCardWithAnimation(to: discardPoint, delay: delay)
        //   button.moveCardWithAnimation(to: discardPoint)
    }
    
    private func clearCardContainer() {
        cardButtons.removeAll()
        grid.cellCount = 0
        removeAllSubviews()
        setNeedsLayout()
    }
}
