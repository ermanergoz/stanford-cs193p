//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 06. 08..
//

import SwiftUI // This is a View Model so it is a part of the UI

class EmojiMemoryGame: ObservableObject {
    var theme: Theme

    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis = theme.emojis.shuffled()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }

    static let themes: [Theme] = [
        Theme(name: "Vehicles", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], numberOfPairs: 4, color: "red"),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"], numberOfPairs: 4, color: "blue"),
        Theme(name: "Foods", emojis: ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚", "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"], numberOfPairs: 4, color: "green"),
        Theme(name: "Sport", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷"], numberOfPairs: 4, color: "orange"),
        Theme(name: "Hearts", emojis: ["❤️", "🧡", "💛", "💚", "💙", "💜"], numberOfPairs: 4, color: "mint"),
        Theme(name: "Weather", emojis: ["☀️", "🌪", "☁️", "☔️", "❄️"], numberOfPairs: 4, color: "yellow"),
    ]

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String>

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    var themeColor: Color {
        switch theme.color {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        case "mint": return .mint
        case "yellow": return .yellow
        default: return .red
        }
    }

    var score: Int {
        return model.score
    }

    // MARK: - Intent(s)

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis = theme.emojis.shuffled()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
