//
//  ContentView.swift
//  Memorize
//
//  Created by Yusuf Ergoz on 2023. 05. 24..
//

import SwiftUI

struct ContentView: View {
    /*
     var body: some /*we are telling the compiler that the type is some View, figure out what it actually is. In this case, it is a Text so it will be replaced with Text. It is called opaque type*/ View { //not stored in the memory. The value of body is being calculated by this function
     /*there is a hidden return here*/
     Text("Hello, world!")
     .foregroundColor(Color.blue)
     .padding([.leading, .bottom, .trailing], 8.0) //This function exists for all structs that behave like a view. When we use this function, it no longer returns Text object but it returns ModifiedContent something something
     RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).foregroundColor(Color.red).padding(20)
     
     }
     */
    /*
    var body: some View {
        return ZStack(alignment: .center, content: {
            Text("Hello, world!")
                .foregroundColor(Color.blue)
                .padding([.leading, .bottom, .trailing], 8.0)
            
            RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).foregroundColor(Color.red).padding(8)
        }).padding(16)
    }
     */
    var body: some View {
        ZStack(alignment: .center) {
            Text("Hello, world!")
                .padding([.leading, .bottom, .trailing], 8.0)
            
            RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3).padding(8)
        }
        .padding(16)
        .foregroundColor(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
