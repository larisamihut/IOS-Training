//
//  SetGameViewController.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import UIKit

class SetGameViewController: UIViewController {
    
    // MARK: - Properties
    
    var game = SetGame()
    var cardButtons: [CardButton]  {
        return cardContainerView.cardButtons
    }
    
    private enum Constants {
        static let minNumberOfCards = 2
        static let maxSelectedCards = 3
        static let pointsForNewCards = 4
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var cardContainerView: CardContainerView! {
        didSet {
            configureGestures()
        }
    }
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
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        startGame()
    }
    
    @IBAction private func addThreeCardsFromDeck(_ sender: UIButton) {
        addThreeCards()
    }
    
    // MARK: - UI Gestures
    
    @objc func tapCard(_ sender: UIButton) {
        guard let cardButton = sender as? CardButton else {
            return
        }
        
        if let cardIndex = cardButtons.firstIndex(of: cardButton) {
            if cardIndex < game.cardsInGame.count {
            //    let previousSelectedIndices = game.getSelectedCardsIndices()
            //    let previousCheckForSet = game.checkCardsForSet()
                let gameSelection = game.selectCard(forIndex: cardIndex)
                switch gameSelection {
                case .isASet:
                //    makeSelectedCardsMatch()
                    replaceMatchedCards(selectedCardsIndices: game.getSelectedCardsIndices())
                    resetSelectedCardsState()
                case .notASet:
                    makeSelectedCardsMismatch()
                default:
                    // the user won't be able to deselect a card that is part of a matched trio
//                    if !game.checkCardsForSet() {
//                        // replace cards if previous move was a matched trio
//                        if previousCheckForSet {
//                          //  replaceMatchedCards(selectedCardsIndices: previousSelectedIndices)
//                        }
                        // update selected cards
                        resetSelectedCardsState()
                        makeSelectedCardsSelected()
                 //   }
                }
            }
            updateScoreLabel()
            updateAddThreeCardsButton()
        }
    }
    
    @objc func swipeDownAction() {
        addThreeCards()
    }
    
    @objc func rotateGestureAction() {
        game.cardsInGame.shuffle()
        addThreeSetGameButtons()
    }
    
    private func configureGestures() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipe.direction = .down
        cardContainerView.addGestureRecognizer(swipe)
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureAction))
        cardContainerView.addGestureRecognizer(rotate)
    }
    
    // MARK: - UI Configuration
    
    private func assignTargetAction(for buttons: [CardButton]) {
        buttons.forEach { $0.addTarget(self, action: #selector(tapCard(_:)), for: .touchUpInside) }
    }
    
    private func addThreeCards() {
//        if game.checkCardsForSet() {
//            replaceMatchedCards(selectedCardsIndices: game.getSelectedCardsIndices())
//            resetSelectedCardsState()
//        } else
        if game.deckCards.count > Constants.minNumberOfCards {
            game.score -= Constants.pointsForNewCards
            addThreeSetGameButtons()
        }
        updateScoreLabel()
    }
    
    private func replaceMatchedCards(selectedCardsIndices: [Int]) {
        game.replaceMatchedCardsIfNeeded()
        cardContainerView.updateCardButtons(with: game.getCards(using: selectedCardsIndices), using: selectedCardsIndices)
    }
        
    private func addThreeSetGameButtons() {
        cardContainerView.addCardButtons(for: game.addThreeCardsFromDeckToGame())
        assignTargetAction(for: cardContainerView.cardButtons.suffix(3))
    }
    
    private func refreshSetGameButtons() {
        cardContainerView.refreshCardButtons(with: game.cardsInGame)
        assignTargetAction(for: cardContainerView.cardButtons)
    }
    
    private func startGame() {
        game = SetGame()
        addThreeCardsButton.isEnabled = true
        refreshSetGameButtons()
        updateScoreLabel()
    }
    
    private func resetSelectedCardsState() {
        for cardIndex in game.cardsInGame.indices {
            guard cardIndex < cardButtons.count else {
                return
            }
            cardButtons[cardIndex].deselectButton()
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
        if game.deckCards.count < Constants.minNumberOfCards {
            addThreeCardsButton.isEnabled = false
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
