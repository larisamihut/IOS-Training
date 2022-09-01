//
//  UIButton+.swift
//  SetGame
//
//  Created by Larisa Diana Mihuț on 12.04.2021.
//

import Foundation
import UIKit

extension UIButton {
    func selectButton() {
        layer.borderWidth = 4.0
        layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        layer.cornerRadius = 8.0
    }
    
    func deselectButton() {
        layer.borderWidth = 0
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 0
    }
    
    func matchCard() {
        layer.borderWidth = 4.0
        layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        layer.cornerRadius = 8.0
    }
    
    func hideButton() {
        backgroundColor = .clear
        isEnabled = false
        layer.cornerRadius = 0
        layer.borderWidth = 0
        setAttributedTitle(NSAttributedString(string: ""), for: .normal)
    }
    
    func mismatchCard() {
        layer.borderWidth = 4.0
        layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        layer.cornerRadius = 8.0
    }
}
