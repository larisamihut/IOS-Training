//
//  UIView+.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 14.04.2021.
//

import UIKit

extension UIView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Utils
    
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
