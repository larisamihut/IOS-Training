//
//  Set.swift
//  SetGame
//
//  Created by Larisa Diana Mihuț on 04.04.2021.
//

import Foundation

class SetGame {
    
    // MARK: - Properties
    
    var deckCards = [Card]()
    var cardsInGame = [Card]()
    var selectedCards = [Card]()
    var score = 0
    
    enum SetRulesEnum {
        case notASet
        case isASet
        case invalid
    }
    
    private enum Constants {
        static let intialNumberOfCards = 12
        static let maxSelectedCards = 3
        static let allowedSimilarities = 2
        static let pointsForMismatch = 3
        static let pointsForMatch = 5
        static let pointsForReselection = 1
    }
    
    // MARK: - Init
    
    init() {
        deckCards = createDeck()
        cardsInGame = getCardsFromDeck(numberOfCards: Constants.intialNumberOfCards)
    }
    
    // MARK: - Utils
    
    private func createDeck() -> [Card] {
        var cards = [Card]()
        for color in Card.ColorEnum.allCases {
            for symbol in Card.SymbolEnum.allCases {
                for number in Card.NumberEnum.allCases {
                    for shading in Card.ShadingEnum.allCases {
                        cards.append(Card(withColor: color, withSymbol: symbol, withNumber: number, withShading: shading))
                    }
                }
            }
        }
        cards.shuffle()
        return cards
    }
    
    func getCardsFromDeck(numberOfCards: Int) -> [Card] {
        var cards: [Card] = []
        for _ in 0...numberOfCards-1 {
            if let newCard = deckCards.popLast() {
                cards.append(newCard)
            }
        }
        cards.shuffle()
        return cards
    }
    
    func selectCard(forIndex cardIndex: Int) -> SetRulesEnum {
        let card = cardsInGame[cardIndex]
        if selectedCards.contains(card) && !checkCardsForSet() {
            removeFromSelectedCards(card: card)
            score -= Constants.pointsForReselection
            return .invalid
        } else if !selectedCards.contains(card) {
            clearSelectedCardsIfNeeded()
            selectedCards.append(card)
            return computeScore()
        }
        return .invalid
    }
    
    private func clearSelectedCardsIfNeeded() {
        guard getNumberOfSelectedCards() == Constants.maxSelectedCards else {
            return
        }
        
        if checkCardsForSet() {
            replaceMatchedCards()
        }
        
        selectedCards.removeAll()
    }
    
    private func computeScore() -> SetRulesEnum {
        guard getNumberOfSelectedCards() == Constants.maxSelectedCards else {
            return .invalid
        }
        
        if checkCardsForSet() {
            score += Constants.pointsForMatch
            return .isASet
        } else {
            score -= Constants.pointsForMismatch
            return .notASet
        }
    }
    
    func checkCardsForSet() -> Bool {
        let setOfColors = Set(selectedCards.map { $0.color })
        let setOfNumbers = Set(selectedCards.map { $0.number })
        let setOfSymbols = Set(selectedCards.map { $0.symbol })
        let setOfShadings = Set(selectedCards.map { $0.shading })
        return !((setOfColors.count == Constants.allowedSimilarities) || (setOfSymbols.count == Constants.allowedSimilarities) || (setOfNumbers.count == Constants.allowedSimilarities) || (setOfShadings.count == Constants.allowedSimilarities)) && getNumberOfSelectedCards() == Constants.maxSelectedCards
    }
    
    func replaceMatchedCards() {
        for card in selectedCards {
            if let selectedCardIndex = cardsInGame.firstIndex(of: card) {
                cardsInGame.remove(at: selectedCardIndex)
                if let newCard = deckCards.popLast() {
                    cardsInGame.insert(newCard, at: selectedCardIndex)
                }
            }
        }
    }
    
    func removeFromSelectedCards(card: Card) {
        if let cardIndex = selectedCards.firstIndex(of: card){
            selectedCards.remove(at: cardIndex )
        }
    }
    
    func addThreeCardsFromDeckToGame() {
        let newCards = getCardsFromDeck(numberOfCards: Constants.maxSelectedCards)
        addCardsToGame(cards: newCards)
    }
    
    func addCardsToGame(cards: [Card]) {
        cardsInGame.append(contentsOf: cards)
    }
    
    func getNumberOfSelectedCards() -> Int {
        return selectedCards.count
    }
}
