//
//  UIButton+.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    // MARK: - Properties
    private enum Constants {
        static let borderWidth: CGFloat = 5
    }
    
    // MARK: - Utils
    
    func selectButton() {
        layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        layer.borderWidth = Constants.borderWidth
    }
    
    func deselectButton() {
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func matchCard() {
        layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        layer.borderWidth = Constants.borderWidth
    }
    
    func mismatchCard() {
        layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        layer.borderWidth = Constants.borderWidth
    }
}
