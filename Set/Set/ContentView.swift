//
//  ContentView.swift
//  Set
//
//  Created by Yusuf Ergoz on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetViewModel
    @State var isDeckFull = false

    var body: some View {
        VStack {
            Text("\(ViewConstants.scoreText) \(viewModel.getScore())")
            AspectVGrid(items: viewModel.getCards, aspectRatio: ViewConstants.cardAspectRatio) { card in
                if card.isMatched {
                    Rectangle().opacity(ViewConstants.matchedCardOpacity)
                } else {
                    CardView(card: card)
                        .foregroundStyle(card.content.color.getColor())
                        .padding(ViewConstants.cardPadding)
                        .onTapGesture {
                            viewModel.chooseCard(card: card)
                        }
                }
            }
            HStack {
                Button {
                    viewModel.onNewGamePressed()
                } label: {
                    Text(ViewConstants.newGameButtonText)
                }
                Spacer()
                Button {
                    isDeckFull = !viewModel.onDealThreeMoreCardsPressed()
                } label: {
                    Text(ViewConstants.threeMoreCardsButtonText)
                }.disabled(isDeckFull)
            }.padding()
        }
    }

    private enum ViewConstants {
        static let cardAspectRatio: CGFloat = 2 / 3
        static let cardPadding: CGFloat = 4
        static let matchedCardOpacity: CGFloat = 0
        static let newGameButtonText: String = "New game"
        static let threeMoreCardsButtonText: String = "Deal 3 More Cards"
        static let scoreText: String = "Score:"
    }
}

struct CardView: View {
    let card: SetViewModel.Card

    var body: some View {
        GeometryReader { _ in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                cardShape.fill().foregroundColor(.white)
                let cardShapeBorder = cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)

                if !card.isChosen, !card.isMatched {
                    renderCard(card: card)
                    cardShapeBorder
                } else if card.isChosen {
                    renderCard(card: card).opacity(DrawingConstants.chosenCardOpacity)
                    cardShapeBorder.foregroundColor(.gray)
                }
            }
        }
    }

    @ViewBuilder
    private func renderCard(card: SetViewModel.Card) -> some View {
        VStack {
            ForEach(0 ..< card.content.numberOfShapes, id: \.self) { _ in
                renderShape(content: card.content)
            }
        }.padding(DrawingConstants.cardPadding)
    }

    @ViewBuilder
    private func renderShape(content: SetViewModel.Card.Content) -> some View {
        switch content.shape {
        case .diamond:
            renderShapeShade(shape: Diamond(), content: content).aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
        case .roundedRectangle:
            renderShapeShade(shape: RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius), content: content).aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
        case .squiggle:
            renderShapeShade(shape: Squiggle(), content: content).aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
        }
    }

    @ViewBuilder
    private func renderShapeShade<SymbolShape>(shape: SymbolShape, content: SetViewModel.Card.Content) -> some View where SymbolShape: Shape {
        switch content.shade {
        case .filled:
            shape.fill()
        case .shaded:
            StripeView(shape: shape, color: content.color.getColor())

        case .stroked:
            shape.stroke()
        }
    }

    private enum DrawingConstants {
        static let symbolAspectRatio: CGFloat = 2 / 1
        static let symbolOpacity: Double = 0.7
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let chosenCardOpacity: CGFloat = 0.5
        static let cardPadding: CGFloat = 8
    }
}

#Preview {
    ContentView(viewModel: SetViewModel())
}
