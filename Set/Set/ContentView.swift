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
            Text("Score: \(viewModel.getScore())")
            AspectVGrid(items: viewModel.getCards, aspectRatio: ViewConstants.cardAspectRatio) { card in
                if card.isMatched {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .foregroundStyle(card.content.color.getColor())
                        .padding(ViewConstants.cardPadding)
                        .onTapGesture {
                            viewModel.choose(card: card)
                        }
                }
            }
            HStack {
                Button {
                    viewModel.onNewGamePressed()
                } label: {
                    Text("New game")
                }
                Spacer()
                Button {
                    isDeckFull = !viewModel.onDealThreeMoreCardsPressed()
                } label: {
                    Text("Deal 3 More Cards")
                }.disabled(isDeckFull)
            }.padding()
        }
    }
    
    private enum ViewConstants {
        static let cardAspectRatio: CGFloat = 2 / 3
        static let cardPadding: CGFloat = 4
        static let removedCardOpacity: CGFloat = 0
    }
}

struct CardView: View {
    let card: SetViewModel.Card

    var body: some View {
        GeometryReader { _ in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)

                if !card.isChosen, !card.isMatched {
                    renderCard(card: card)
                } else if card.isChosen {
                    renderCard(card: card).opacity(DrawingConstants.chosenCardOpacity).background(Color.gray)
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
            renderShapeShade(shape: Diamond(), content: content)
        case .roundedRectangle:
            renderShapeShade(shape: RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius), content: content)
        case .squiggle:
            renderShapeShade(shape: Squiggle(), content: content)
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
