//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import Foundation
// This is our model

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]  //means that the getter for cards is public, but the setter is private

    private var indexOfTheOneAndOnlyFaceUpCard: Int?

    mutating func choose(_ card: Card) { //this function is internal by default so we don't have to specify it explicitly
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), /* We cant use && in if statement if we have let but we can use , It is same as the && but it will do if let */
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content { // We are Binary operator '==' cannot be applied to two 'CardContent' operands error because CardContent is a don't care type. To fiz that, we added where CardContent: Equatable so they can be compared
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }

    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards = [] //Swift knows it's [Card]() This is called type inference

        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
