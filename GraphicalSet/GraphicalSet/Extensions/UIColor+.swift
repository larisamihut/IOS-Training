//
//  UIColor+.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 13.04.2021.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Utils
    
    static func color(from colorEnum: Card.ColorEnum) -> UIColor {
        switch colorEnum {
        case .red : return .red
        case .purple : return .purple
        case .green : return .green
        }
    }
}
