//
//  Stripes.swift
//  Set
//
//  Created by Yusuf Ergoz on 30/10/2023.
//

import SwiftUI

struct StripeView<SymbolShape>: View where SymbolShape: Shape {
    let numberOfStripes: Int = 4
    let borderLineWidth: CGFloat = 1.3

    let shape: SymbolShape
    let color: Color
    let spacingColor = Color.white

    var body: some View {
        VStack(spacing: 0.5) {
            ForEach(0 ..< numberOfStripes) { _ in
                spacingColor
                color
            }
            spacingColor
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
    }
}
