//
//  ViewController.swift
//  Concentration
//
//  Created by Wong Tsz wai on 29/7/2019.
//  Copyright © 2019 Isaac Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Computed Properties
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    func reverse(text: String) -> String {
        return String(text.reversed())
    }
    
    //Lazy is used because Concentration(numberOfPairOfCards is not yet initialised. 
    //No didSet , only init when we are gonna to use it 
    lazy var game = Concentration(numberOfPairOfCards: numberOfPairsOfCards)

    
    
    var filpCount = 0 {
        didSet{
            filpCountLabel.text = "Filps: \(filpCount)"
        }
    }
    
    @IBOutlet weak var filpCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        filpCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emojiFor(card: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.red
            }else{
                button.setTitle(nil, for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.black : UIColor.orange
            }
        }
    }
    
    var emojiChoices  = ["👻","🎃", "😀","🏥","🌄","🌠","🌜","☀️","🌈"]
    
    //A Dictionary using Identifier to extract
    var emoji =  [Int:String]()
    
    func emojiFor(card: Card) -> String{
        if  emoji[card.identifier] == nil , emojiChoices.count > 0{
                let randomIndex = emojiChoices.count.arc4Random
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    //Add a new game button
    
    
//    func filpCard(withEmoji emoji: String , on Button: UIButton){
//        //Check if it is front
//        if Button.currentTitle == emoji { //Front
//            Button.setTitle(nil, for: UIControl.State.normal)
//            Button.backgroundColor = UIColor.red
//        }else{
//            print("Set to white")
//            Button.setTitle(emoji, for: UIControl.State.normal)
//            Button.backgroundColor = UIColor.white
//        }
//    }

}

extension Int {
    var arc4Random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self > 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
