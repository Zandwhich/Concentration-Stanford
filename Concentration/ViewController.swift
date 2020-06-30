//
//  ViewController.swift
//  Concentration
//
//  Created by First Last on 2020-06-28.
//  Copyright © 2020 Alex Zdanowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        self.game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = nil
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    let themes =
    [0: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],
     1: ["😀", "😃", "😄", "😅", "🤣", "🥰", "😋", "🤓", "🤩"],
     2: ["🦜", "🦔", "🦓", "🐓", "🐄", "🦛", "🦙", "🐈", "🐕"],
     3: ["⚾️", "🏐", "🏏", "⚽️", "🏓", "🏀", "🏈", "🏑", "🥍"],
     4: ["🚗", "🚜", "🚝", "🏍", "🛺", "🚁", "🚠", "⛵️", "🚀"],
     5: ["🍆", "🥦", "🥝", "🌯", "🍕", "🍙", "🥖", "🍗", "🥕"]]
    
    var emoji = [Int:String]()
    
    var emojiChoices: [String]?
    
    func emoji(for card: Card) -> String {
        if self.emojiChoices == nil {
            self.emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]!
        }
        if emoji[card.identifier] == nil , emojiChoices!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices!.count)))
            emoji[card.identifier] = emojiChoices!.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

