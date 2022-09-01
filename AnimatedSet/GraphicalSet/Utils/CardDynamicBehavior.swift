//
//  CardDynamicBehavior.swift
//  GraphicalSet
//
//  Created by Larisa Diana Mihuț on 22.04.2021.
//

import UIKit

class CardDynamicBehavior: UIDynamicBehavior {
    
    // MARK: - Properties
    
    private enum Constants {
        static let resistence: CGFloat = -0.1
        static let elasticity: CGFloat = 1.1
        static let magnitude: CGFloat = 10.0
        static let angle: CGFloat = 2
    }
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = true
        behavior.elasticity = Constants.elasticity
        behavior.resistance = Constants.resistence
        return behavior
    }()
    
    // MARK: - Init
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
    
    // MARK: - Utils
    
    func addBounceBehavior(item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = (Constants.angle * CGFloat.pi).arc4random
        push.magnitude = Constants.magnitude
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        addBounceBehavior(item: item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
