//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import SwiftUI // This is a View Model so it is a part of the UI

class EmojiMemoryGame: ObservableObject // ObservableObject is a kind of object that can publish something changed
{
    // The order of the properties that are being initialized is random. We don't know which one gets initialized first. Thats why we might get "property initializers run before 'self' is available"
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"] // This is a type variable

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    } // This is a type function

    @Published /* Anytime the model changes, it will automatically call objectWillChange.send() */ private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    // MARK: - Intent(s)

    func choose(_ card: MemoryGame<String>.Card) {
        // objectWillChange.send() //It is defined by the system and we can call it anytime the model changes. We don't need it thanks to the @Published
        model.choose(card)
    }
}
