//
//  Concentration.swift
//  Concentration
//
//  Created by Wong Tsz wai on 29/7/2019.
//  Copyright © 2019 Isaac Wong. All rights reserved.
//

import Foundation


struct Concentration{
    
    //Classes have free init, as long as all objs are set
    var cards = [Card]()
    var indexOfOneAndOnlyOneFaceUpCard : Int? {
        get{
            var foundIndex : Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        //Add this to assure that others can debug when users enter a non valid object 
        assert(cards.indices.contains(index),"Concentration.chooseCard(at:\(index):Chosen index not in the card")
        if !cards[index].isMatched{
            if let matchIndex =  indexOfOneAndOnlyOneFaceUpCard , matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                //Either no cards or 2 cards are face up
                //No need these codes as the computed properties have set it.
//                for filpDownIndex in cards.indices{
//                    cards[filpDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairOfCards: Int){
        
        //Countable range from 1 to numberOfPairOfCards(Included)
        for _ in 1...numberOfPairOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        //To Do Shuffle the card
        cards.shuffle()
    }
    
}
