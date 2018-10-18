//
//  ViewController.swift
//  Concentration
//
//  Created by June Kim on 7/16/18.
//  Copyright © 2018 Kippum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emoji = [Int:String]()
        emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScoreLabel.text = "Score: \(game.gameScore)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5747592449, blue: 0.009939291514, alpha: 1)
            }
        }
    }
    
    let emojiChoicesHalloween = ["👻", "🎃", "🦇", "😱", "😈", "🍬", "🌚", "🍫"]
    let emojiChoicesColor = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "💔"]
    
    lazy var themes = [emojiChoicesHalloween, emojiChoicesColor]
    
    lazy var emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }

}

