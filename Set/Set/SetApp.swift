//
//  SetApp.swift
//  Set
//
//  Created by Yusuf Ergoz on 24/10/2023.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SetViewModel())
        }
    }
}
