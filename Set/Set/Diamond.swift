//
//  Diamond.swift
//  Set
//
//  Created by Yusuf Ergoz on 30/10/2023.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width
        let height = rect.width / 2

        let topPoint = CGPoint(x: center.x, y: center.y + height / 2)
        let bottomPoint = CGPoint(x: center.x, y: center.y - height / 2)
        let leftPoint = CGPoint(x: center.x - width / 2, y: center.y)
        let rightPoint = CGPoint(x: center.x + width / 2, y: center.y)

        p.move(to: topPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: topPoint)

        return p
    }
}
