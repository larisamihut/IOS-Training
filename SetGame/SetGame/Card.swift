//
//  Card.swift
//  SetGame
//
//  Created by Larisa Diana Mihuț on 03.04.2021.
//

import Foundation

class Card: Equatable {
    
    // MARK: - Properties
    
    var color: ColorEnum
    var number: NumberEnum
    var shading: ShadingEnum
    var symbol: SymbolEnum
    
    // MARK: - Init
    
    init(withColor color: ColorEnum, withSymbol symbol: SymbolEnum, withNumber number: NumberEnum, withShading shading: ShadingEnum) {
        self.color = color
        self.symbol = symbol
        self.number = number
        self.shading = shading
    }
    
    // MARK: - Utils
    
    static func ==(lhs:Card, rhs:Card) -> Bool {
        return lhs.color == rhs.color && lhs.number == rhs.number && lhs.symbol == rhs.symbol && lhs.shading == rhs.shading
    }
    
    enum ColorEnum: CaseIterable {
        case red
        case green
        case blue
    }
    
    enum SymbolEnum: String, CaseIterable {
        case triangle = "▲"
        case circle = "●"
        case square = "◼︎"
    }
    
    enum ShadingEnum: CaseIterable {
        case open
        case underlined
        case solid
    }
    
    enum NumberEnum: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
}
