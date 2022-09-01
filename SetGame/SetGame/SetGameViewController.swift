//
//  ViewController.swift
//  SetGame
//
//  Created by Larisa Diana Mihuț on 02.04.2021.
//

import UIKit

class SetGameViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var game = SetGame()
    
    private enum Constants {
        static let maxNumberOfCards = 24
        static let minNumberOfCards = 2
        static let maxSelectedCards = 3
        static let pointsForNewCards = 4
    }
    
    // MARK: - Outlets
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var addThreeCardsButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    // MARK: - Actions
    
    @IBAction private func tapCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            if cardIndex < game.cardsInGame.count {
                let gameSelection = game.selectCard(forIndex: cardIndex)
                switch gameSelection {
                case .isASet:
                    makeSelectedCardsMatch()
                case .notASet:
                    makeSelectedCardsMismatch()
                default:
                    if !game.checkCardsForSet() {
                        updateSetGameViewModel()
                        makeSelectedCardsSelected()
                    }
                }
            }
            updateScoreLabel()
            updateAddThreeCardsButton()
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game = SetGame()
        startGame()
    }
    
    @IBAction private func addThreeCardsFromDeck(_ sender: UIButton) {
        if game.checkCardsForSet() {
            game.replaceMatchedCards()
            updateSetGameViewModel()
        } else if game.cardsInGame.count < Constants.maxNumberOfCards && game.deckCards.count > Constants.minNumberOfCards {
            game.addThreeCardsFromDeckToGame()
            updateSetGameViewModel()
            updateSelectedCards()
            game.score -= Constants.pointsForNewCards
            updateScoreLabel()
        }
    }
    
    // MARK: - UI Configuration
    
    private func updateSetGameViewModel() {
        resetSelectedCardsState()
        updateScoreLabel()
    }
    private func startGame() {
        resetButtonsState()
        addThreeCardsButton.isEnabled = true
        updateSetGameViewModel()
    }
    
    private func resetSelectedCardsState() {
        var cardAttrString = NSAttributedString(string: "")
        for cardIndex in game.cardsInGame.indices {
            cardAttrString = computeFinalSymbol(for: game.cardsInGame[cardIndex])
            cardButtons[cardIndex].deselectButton()
            cardButtons[cardIndex].setAttributedTitle(cardAttrString, for: .normal)
        }
    }
    
    private func resetButtonsState() {
        for button in cardButtons {
            button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            button.deselectButton()
        }
    }
    
    private func updateSelectedCards() {
        if game.getNumberOfSelectedCards() == Constants.maxSelectedCards {
            makeSelectedCardsMismatch()
        } else {
            makeSelectedCardsSelected()
        }
    }
    
    private func updateAddThreeCardsButton() {
        if game.deckCards.count < Constants.minNumberOfCards && game.cardsInGame.count == Constants.maxNumberOfCards {
            addThreeCardsButton.isEnabled = false
        }
    }
    
    private func computeFinalSymbol(for card: Card) -> NSAttributedString {
        return NSAttributedString(string: computeSymbol(for: card), attributes: computeAttributes(for: card))
    }
    
    private func computeAttributes(for card: Card) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.foregroundColor] = UIColor.color(from: card.color)
        if card.shading == .underlined {
            attributes[.underlineStyle] = NSUnderlineStyle.patternDash.rawValue | NSUnderlineStyle.single.rawValue
        } else if card.shading == .open {
            attributes[.strokeWidth] = 10
        }
        return attributes
    }
    
    private func computeSymbol(for card: Card) -> String {
        switch card.number {
        case .one: return card.symbol.rawValue
        case .two: return card.symbol.rawValue + card.symbol.rawValue
        case .three: return card.symbol.rawValue + card.symbol.rawValue + card.symbol.rawValue
        }
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedString.Key: Any] = [.strokeColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func makeSelectedCardsMatch() {
        for card in game.selectedCards {
            if let selectedCardIndex = game.cardsInGame.firstIndex(of: card) {
                cardButtons[selectedCardIndex].matchCard()
            }
        }
    }
    
    private func makeSelectedCardsMismatch() {
        for card in game.selectedCards {
            if let selectedCardIndex = game.cardsInGame.firstIndex(of: card) {
                cardButtons[selectedCardIndex].mismatchCard()
            }
        }
    }
    
    private func makeSelectedCardsSelected() {
        for card in game.selectedCards {
            if let selectedCardIndex = game.cardsInGame.firstIndex(of: card) {
                cardButtons[selectedCardIndex].selectButton()
            }
        }
    }
}
