//
//  ViewController.swift
//  Concentration
//
//  Created by Larisa Diana Mihuț on 29/03/2021.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var emojiChoices: [String]? = Theme().getNewTheme(theme: "Hearts")
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme
            emoji = [:]
            updateViewModel()
        }
    }
    private var emoji = [Card:String]()
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapStartNewGameButton(_ sender: UIButton) {
        restartGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewModel()
        } else {
            print("not in cardButtons ")
        }
    }
    
    // MARK: - Utils
    
    private func restartGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewModel()
    }
    
    private func updateViewModel() {
        guard cardButtons != nil else {
            return
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(setEmoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = false
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                button.isEnabled = true
            }
            if card.isMatched {
                button.isEnabled = false
            }
        }
        scoreCountLabel.text = "Score: \(game.scoreCount)"
        updateFlipCountLabel()
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipsCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func setEmoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices!.count > 0 {
            emoji[card] = emojiChoices!.remove(at: emojiChoices!.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}
