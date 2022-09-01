//
//  CGFloat+.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 22.04.2021.
//

import UIKit

extension CGFloat {
    var arc4random: CGFloat {
        if self > 0 {
            return CGFloat(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -CGFloat(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
