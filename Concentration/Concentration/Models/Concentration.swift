//
//  Concentration.swift
//  Concentration
//
//  Created by Larisa Diana Mihuț on 30.03.2021.
//

import Foundation

struct Concentration {
    
    
    // MARK: - Properties

    private(set) var cards = [Card]()
    private var indexofOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFacedUp }.oneAndOnly
        }
        set {
            for index in cards.indices{
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    var scoreCount = 0
    var flipsCount = 0
    
    // MARK: - Init
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    
    // MARK: - Utils
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index)): chosen index not in the cards")
        flipsCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexofOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                indexofOneAndOnlyFaceUpCard = index
            }
        }
        calculateScore(for: cards[index])
        cards[index].alreadySeen = true
    }
    
    mutating func calculateScore(for card: Card) {
        if card.isMatched {
            scoreCount += 2
        } else if card.alreadySeen && !card.isMatched {
            scoreCount -= 1
        }
    }
}
