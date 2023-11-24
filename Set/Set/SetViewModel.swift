//
//  SetViewModel.swift
//  Set
//
//  Created by Yusuf Ergoz on 25/10/2023.
//

import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetModel<ShapeType, ShapeColor, ShapeShade, NumberOfShapes>.Card

    private static var cardContents: [Card.Content] = createCardContents()

    private static func createCardContents() -> [Card.Content] {
        var cardContents: [Card.Content] = []

        for shape in ShapeType.allCases {
            for color in ShapeColor.allCases {
                for shade in ShapeShade.allCases {
                    for numberOfShapes in NumberOfShapes.allCases {
                        cardContents.append(Card.Content(shape: shape, color: color, shade: shade, numberOfShapes: numberOfShapes.rawValue))
                    }
                }
            }
        }
        return cardContents.shuffled()
    }

    private static func createGame() -> SetModel<ShapeType, ShapeColor, ShapeShade, NumberOfShapes> {
        SetModel<ShapeType, ShapeColor, ShapeShade, NumberOfShapes>(numberOfCards: Constants.initialNumberOfCards) {
            /* return */ cardContents[$0]
        }
    }

    @Published private var model = createGame()

    var getCards: [Card] {
        return model.cards
    }

    func chooseCard(card: Card) {
        model.choose(card: card)
    }

    func onNewGamePressed() {
        SetViewModel.cardContents.shuffle()
        model = SetViewModel.createGame()
    }

    func onDealThreeMoreCardsPressed() -> Bool {
        return model.dealThreeCards()
    }

    func getScore() -> Int {
        return model.score
    }

    enum ShapeType: CaseIterable {
        case roundedRectangle
        case diamond
        case squiggle
    }

    enum ShapeColor: CaseIterable {
        case red
        case green
        case purple

        func getColor() -> Color {
            switch self {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
            }
        }
    }

    enum ShapeShade: CaseIterable {
        case filled
        case stroked
        case shaded
    }

    enum NumberOfShapes: Int, CaseIterable {
        case one = 1
        case two
        case three
    }

    private enum Constants {
        static let initialNumberOfCards = 12
    }
}
