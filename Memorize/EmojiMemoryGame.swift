//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import SwiftUI // This is a View Model so it is a part of the UI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card // With this change, the full name of it is EmojiMemoryGame.Card and it is available outside of this class
    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model = EmojiMemoryGame.createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    // MARK: - Intent(s)

    func choose(_ card: Card) {
        model.choose(card)
    }
}
