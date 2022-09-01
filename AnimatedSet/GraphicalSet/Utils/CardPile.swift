//
//  CardPileUtils.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 28.04.2021.
//

import UIKit

@IBDesignable
class CardPile: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
}
