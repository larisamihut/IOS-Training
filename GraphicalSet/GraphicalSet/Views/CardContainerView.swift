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
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: - Utils
    
    func createCardButtons(for cards: [Card]) {
        let buttons = cards.map { CardButton(frame: frame, card: $0) }
        buttons.forEach { addSubview($0) }
        cardButtons += buttons
        grid.cellCount = cardButtons.count
    }
    
    func addCardButtons(for cards: [Card]) {
        createCardButtons(for: cards)
        setNeedsLayout()
    }
    
    func updateCardButtons(with cards: [Card], using positions: [Int]) {
        for index in positions.indices {
            cardButtons[positions[index]].card = cards[index]
        }
    }
    
    func refreshCardButtons(with cards: [Card]) {
        clearCardContainer()
        createCardButtons(for: cards)
        setNeedsLayout()
    }
    
    private func configureUI() {
        grid.frame = viewFrame
        for (buttonIndex, button) in cardButtons.enumerated() {
            if let buttonFrame = grid[buttonIndex] {
                button.frame = buttonFrame.insetBy(dx: Constants.insetValue, dy: Constants.insetValue)
            }
        }
    }
    
    private func clearCardContainer() {
        cardButtons.removeAll()
        grid.cellCount = 0
        removeAllSubviews()
        setNeedsLayout()
    }
}
