//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import SwiftUI //This is a View Model so it is a part of the UI

//func makeCardContent(index: Int) -> String {
//    return "🥲"
//}

class EmojiMemoryGame {
    //private var model: MemoryGame<String> /*We have emojis and they are strings. Here we are telling what is the type of CardContent*/ = MemoryGame<String>(numberOfPairsOfCards: 4, createContent: { index in
    //    /*return*/ "😂" //We could also pass a function by typing makeCardContent that is declared above
    //})
    
    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in "😂" } //this is a much cleaner way
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
