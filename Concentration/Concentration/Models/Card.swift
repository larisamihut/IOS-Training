//
//  Card.swift
//  Concentration
//
//  Created by Larisa Diana Mihuț on 30.03.2021.
//

import Foundation

struct Card: Hashable {
    
    // MARK: - Properties
    
    var isFacedUp = false
    var isMatched = false
    var alreadySeen = false
    var identifier: Int
    private static var identifierFactory = 0
    
    // MARK: - Init
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
    
    // MARK: - Utils
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
