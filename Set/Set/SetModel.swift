//
//  SetModel.swift
//  Set
//
//  Created by Yusuf Ergoz on 25/10/2023.
//

import Foundation

struct SetModel<ShapeType, ShapeColor, ShapeShade, NumberOfShapes> where ShapeType: Hashable, ShapeColor: Hashable, ShapeShade: Hashable {
    private(set) var cards: [Card]
    private var numberOfCardsOnDeck = 0
    private var createContent: (Int) -> (Card.Content)
    private(set) var score = 0

    // Constants
    private let maxDeckSize = 81
    private let maxNumberOfChosenCards = 3

    init(numberOfCards: Int, createContent: @escaping (Int) -> (Card.Content)) {
        self.createContent = createContent
        numberOfCardsOnDeck = numberOfCards
        cards = []

        for index in 0 ..< numberOfCards {
            let content = createContent(index)
            cards.append(Card(content: content))
        }
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[chosenIndex].isChosen.toggle()
        }
        var chosenCards = cards.filter { $0.isChosen }

        if chosenCards.count == maxNumberOfChosenCards {
            if isSet(chosenCards: chosenCards) {
                score += 1
            }
            chosenCards = []

            for index in 0 ..< cards.count {
                if cards[index].isChosen {
                    cards[index].isChosen = false
                }
            }
        }
    }

    mutating func dealThreeCards() -> Bool {
        let limit = min(numberOfCardsOnDeck + maxNumberOfChosenCards, maxDeckSize)

        for index in cards.count ..< limit {
            let content = createContent(index)
            cards.append(Card(content: content))
        }
        numberOfCardsOnDeck = limit
        return numberOfCardsOnDeck < maxDeckSize
    }

    private mutating func isSet(chosenCards: [Card]) -> Bool {
        if isCardPropertyValid(chosenCards: chosenCards, keyPath: \.color) &&
            isCardPropertyValid(chosenCards: chosenCards, keyPath: \.numberOfShapes) &&
            isCardPropertyValid(chosenCards: chosenCards, keyPath: \.shape) &&
            isCardPropertyValid(chosenCards: chosenCards, keyPath: \.shade)
        {
            let _ = dealThreeCards()
            removeSet(chosenCards: chosenCards)
            return true
        }
        return false
    }

    private func isCardPropertyValid<ContentProperty: Hashable>(chosenCards: [Card], keyPath: KeyPath<Card.Content, ContentProperty>) -> Bool {
        let values = Set(chosenCards.map { $0.content[keyPath: keyPath] })
        // 1 if all same, 3 if all different
        return values.count == 1 || values.count == 3
    }

    private mutating func removeSet(chosenCards: [Card]) {
        chosenCards.forEach { chosenCard in
            if let index = cards.firstIndex(where: { $0.id == chosenCard.id }) {
                cards[index].isMatched = true
            }
        }
    }

    struct Card: Identifiable {
        var id = UUID()
        var isMatched = false
        var isChosen: Bool = false
        var content: Content

        struct Content: Hashable {
            let shape: ShapeType
            let color: ShapeColor
            let shade: ShapeShade
            let numberOfShapes: Int
        }
    }
}
