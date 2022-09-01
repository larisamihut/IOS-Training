//
//  CardButton+.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

extension CardButton {
    
    // MARK: - Properties
    
    var symbolWidth: CGFloat {
        return bounds.size.width * Constants.symbolWidthRatio
    }
    
    var symbolSize: CGSize {
        return CGSize(width: symbolWidth, height: symbolWidth * Constants.symbolRatio)
    }
    
    var centerSymbol: CGRect {
        let origin = CGPoint(x: bounds.midX - symbolSize.width / 2, y: bounds.midY - symbolSize.height / 2)
        return CGRect(origin: origin, size: symbolSize)
    }
    
    var twoSymbolsTop: CGRect {
        return centerSymbol.applying(CGAffineTransform(translationX: 0, y: -symbolSize.height))
    }
    
    var twoSymbolsBottom: CGRect {
        return centerSymbol.applying(CGAffineTransform(translationX: 0, y: symbolSize.height))
    }
    
    var threeSymbolsTop: CGRect {
        return centerSymbol.applying(CGAffineTransform(translationX: 0, y: -(symbolSize.height + symbolSize.height * 0.5)))
    }
    
    var threeSymbolsBottom: CGRect {
        return centerSymbol.applying(CGAffineTransform(translationX: 0, y: symbolSize.height + symbolSize.height * 0.5))
    }
}
