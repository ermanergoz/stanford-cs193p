//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import SwiftUI //This is a View Model so it is a part of the UI

class EmojiMemoryGame {
    //The order of the properties that are being initialized is random. We don't know which one gets initialized first. Thats why we might get "property initializers run before 'self' is available"
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"] //This is a type variable
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    } //This is a type function
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
 
