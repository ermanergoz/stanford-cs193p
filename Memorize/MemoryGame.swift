//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import Foundation
//This is our model

/*CardContent is a Generic. It is a "do not care type"*/
struct MemoryGame<CardContent> {
    private(set/*other classes can look at the model but cant change it*/) var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //Add numbersOfPairsOfCards x 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
