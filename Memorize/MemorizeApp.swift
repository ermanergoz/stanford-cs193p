//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 05. 24..
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
