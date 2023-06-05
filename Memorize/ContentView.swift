//
//  ContentView.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 05. 24..
//

import SwiftUI

struct ContentView: View {
    var emojis: Array<String> = ["✈️", "🚀", "🚁", "🚝", "🚝"]
    
    var body: some View {
        HStack {
            /*id is the emoji itself at the moment. When the train is tapped, 2 of them gets marked*/
            ForEach(emojis, id: \.self, content: { emoji in
                CardView(content: emoji)
            })
            //for index in emojis.count {
            //    CardView(content: emojis[index])
            //}
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct CardView: View {
    /*@State turns it into a pointer that points to some boolean in the memory*/
    @State var isFaceUp: Bool = true //{ return false}
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
