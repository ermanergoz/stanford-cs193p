//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import Foundation
// This is our model

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    mutating func choose(_ card: Card) {
        //if let chosenIndex = index(of: card) {    // Not needed anymore
        if let chosenIndex = cards.firstIndex(where: { aCardInTheCardsArray in aCardInTheCardsArray.id == card.id }) {
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    //func index(of card: Card) -> Int? {   // Not needed anymore
    //    for index in 0 ..< cards.count {
    //        if cards[index].id == card.id {
    //            return index
    //        }
    //    }
    //    return nil
    //}
    
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
