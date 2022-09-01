//
//  UIColor+.swift
//  SetGame
//
//  Created by Larisa Diana Mihuț on 12.04.2021.
//

import Foundation
import UIKit

extension UIColor {
    static func color(from colorEnum: Card.ColorEnum) -> UIColor {
        switch colorEnum {
        case .red : return .red
        case .blue : return .blue
        case .green : return .green
        }
    }
}
