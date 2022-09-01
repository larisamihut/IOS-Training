//
//  SetGame.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import Foundation

class SetGame {
    
    // MARK: - Properties
    
    var deckCards = [SetCard]()
    var cardsInGame = [SetCard]()
    var selectedCards = [SetCard]()
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
    
    private func createDeck() -> [SetCard] {
        var cards = [SetCard]()
        for color in SetCard.ColorEnum.allCases {
            for symbol in SetCard.SymbolEnum.allCases {
                for number in SetCard.NumberEnum.allCases {
                    for shading in SetCard.ShadingEnum.allCases {
                        cards.append(SetCard(withColor: color, withSymbol: symbol, withNumber: number, withShading: shading))
                    }
                }
            }
        }
        cards.shuffle()
        return cards
    }
    
    func getCardsFromDeck(numberOfCards: Int) -> [SetCard] {
        var cards: [SetCard] = []
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
            replaceMatchedCardsIfNeeded()
            selectedCards.append(card)
            return computeScore()
        }
        return .invalid
    }
    
    func replaceMatchedCardsIfNeeded() {
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
    
    private func replaceMatchedCards() {
        for card in selectedCards {
            if let selectedCardIndex = cardsInGame.firstIndex(of: card) {
                cardsInGame.remove(at: selectedCardIndex)
                if let newCard = deckCards.popLast() {
                    cardsInGame.insert(newCard, at: selectedCardIndex)
                }
            }
        }
    }
    
    func getCards(using indices: [Int]) -> [SetCard] {
        return indices.compactMap { cardsInGame[$0] }
    }
    
    func getSelectedCardsIndices() -> [Int] {
        return selectedCards.compactMap { (cardsInGame.firstIndex(of: $0)) }
    }
    
    func removeFromSelectedCards(card: SetCard) {
        if let cardIndex = selectedCards.firstIndex(of: card){
            selectedCards.remove(at: cardIndex )
        }
    }
    
    func addThreeCardsFromDeckToGame() -> [SetCard] {
        let newCards = getCardsFromDeck(numberOfCards: Constants.maxSelectedCards)
        addCardsToGame(cards: newCards)
        return newCards
    }
    
    func addCardsToGame(cards: [SetCard]) {
        cardsInGame.append(contentsOf: cards)
    }
    
    func getNumberOfSelectedCards() -> Int {
        return selectedCards.count
    }
}
