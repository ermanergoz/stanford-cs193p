//
//  SetModel.swift
//  Set
//
//  Created by Yusuf Ergoz on 25/10/2023.
//

import Foundation

struct SetModel<ShapeType, ShapeColor, ShapeShade, NumberOfShapes> where ShapeType: Equatable, ShapeColor: Equatable, ShapeShade: Equatable {
    private(set) var cards: [Card]
    private var numberOfCardsOnDeck = 0
    private var createContent: (Int) -> (Card.Content)
    private(set) var score = 0
    
    init(numberOfCards: Int, createContent: @escaping (Int) -> (Card.Content)) {
        self.createContent = createContent
        numberOfCardsOnDeck = numberOfCards
        cards = []
        
        for index in 0 ..< numberOfCards {
            let content = createContent(index)
            cards.append(Card(content: content, id: index))
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[chosenIndex].isChosen.toggle()
        }
        
        var chosenCards = cards.filter { $0.isChosen }
        
        if chosenCards.count == 3 {
            if isSet(chosenCards: chosenCards) {
                score+=1
            }
            chosenCards = []
            
            for index in 0 ... cards.count - 1 {
                if cards[index].isChosen {
                    cards[index].isChosen = false
                }
            }
        }
    }
    
    mutating func dealThreeCards() -> Bool {
        let limit = min(numberOfCardsOnDeck + 3, 81)
        
        for index in cards.count ..< limit {
            let content = createContent(index)
            cards.append(Card(content: content, id: index+81))
        }
        
        numberOfCardsOnDeck = cards.count
        return numberOfCardsOnDeck < 81
    }
        
    mutating private func isSet(chosenCards: [Card]) -> Bool {
        if isContentValid(chosenCards: chosenCards, keyPath: \.numberOfShapes, comparison: .allSame) ||
                    isContentValid(chosenCards: chosenCards, keyPath: \.numberOfShapes, comparison: .allDifferent),
                  isContentValid(chosenCards: chosenCards, keyPath: \.shape, comparison: .allSame) ||
                    isContentValid(chosenCards: chosenCards, keyPath: \.shape, comparison: .allDifferent),
                  isContentValid(chosenCards: chosenCards, keyPath: \.shade, comparison: .allSame) ||
                    isContentValid(chosenCards: chosenCards, keyPath: \.shade, comparison: .allDifferent),
                  isContentValid(chosenCards: chosenCards, keyPath: \.color, comparison: .allSame) ||
                    isContentValid(chosenCards: chosenCards, keyPath: \.color, comparison: .allDifferent)
        {
            cards = cards.filter({ item in !chosenCards.contains(where: { $0.id == item.id }) })
            let _ = dealThreeCards()
            return true
        }
        return false
    }
    
    private func isContentValid<T: Equatable>(chosenCards: [Card], keyPath: KeyPath<Card.Content, T>, comparison: ShapeComparison) -> Bool {
        // Can't use generics https://developer.apple.com/forums/thread/12770
        for currentCardIndex in 0 ..< chosenCards.count {
            for nextCardIndex in (currentCardIndex + 1) ..< chosenCards.count {
                let currentCard = chosenCards[currentCardIndex].content[keyPath: keyPath]
                let nextCard = chosenCards[nextCardIndex].content[keyPath: keyPath]
                
                switch comparison {
                case .allSame:
                    if currentCard != nextCard {
                        return false
                    }
                case .allDifferent:
                    if currentCard == nextCard {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    struct Card: Identifiable {
        var isMatched = false
        var isChosen: Bool = false
        var content: Content
        var id: Int
        
        struct Content {
            let shape: ShapeType
            let color: ShapeColor
            let shade: ShapeShade
            let numberOfShapes: Int
        }
    }
    
    enum ShapeComparison {
        case allSame
        case allDifferent
    }
}
