//
//  SetCard.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import Foundation

class SetCard: Equatable {
    
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
    
    static func ==(lhs:SetCard, rhs:SetCard) -> Bool {
        return lhs.color == rhs.color && lhs.number == rhs.number && lhs.symbol == rhs.symbol && lhs.shading == rhs.shading
    }

    enum ColorEnum: CaseIterable {
        case red
        case green
        case purple
    }
    
    enum SymbolEnum: CaseIterable {
        case diamond
        case oval
        case squiggle
    }
    
    enum ShadingEnum: CaseIterable {
        case unfilled
        case striped
        case solid
    }
    
    enum NumberEnum: CaseIterable {
        case one
        case two
        case three
    }
}
