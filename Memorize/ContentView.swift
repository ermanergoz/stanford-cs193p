//
//  ContentView.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 05. 24..
//

import SwiftUI

struct ContentView: View {
    var vehicleEmojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]
    var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚",
                      "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    
    @State var emojis: [String]
    
    init() {
        //The @State property wrapper automatically generates a property with a leading underscore for us
        _emojis = State(initialValue: vehicleEmojis)
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).bold().padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: ContentMode.fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                theme1
                Spacer()
                theme2
                Spacer()
                theme3
            }
            .padding(.horizontal)
        }
        .navigationTitle("Memorize!")
        .padding(.horizontal)
    }
    
    var theme1 : some View {
        Button(action: {
            emojis = vehicleEmojis.shuffled()
        }, label: {
            VStack {
                Image(systemName: "car.circle").font(.largeTitle)
                Text("Vehicle")
            }
        })
    }
    
    var theme2: some View {
        return Button(action: {
            emojis = animalEmojis.shuffled()
        }, label: {
            VStack {
                Image(systemName: "fish.circle").font(.largeTitle)
                Text("Animal")
            }
        })
    }
    
    var theme3: some View {
        return Button(action: {
            emojis = foodEmojis.shuffled()
        }, label: {
            VStack {
                Image(systemName: "fork.knife.circle").font(.largeTitle)
                Text("Food")
            }
        })
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
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
