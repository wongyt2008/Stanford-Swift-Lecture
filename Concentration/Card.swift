//
//  Card.swift
//  Concentration
//
//  Created by Wong Tsz wai on 29/7/2019.
//  Copyright © 2019 Isaac Wong. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier () -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
