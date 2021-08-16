//
//  ContentView.swift
//  Memorize
//
//  Created by Артём Леознов on 08.08.2021.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🛵", "🚂", "🚤", "🚃", "✈️", "🏍", "🛴", "🚁", "🚀", "🚲", "⛵️",
                  "🛰", "🛸", "🛶", "🚛", "🚑", "🚄", "🚒", "🚙", "🛳", "🏎", "⛴"]
    @State var emojiCount = 6
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer(minLength: 20)
            .padding(.horizontal)
            .font(.largeTitle)
        }
        
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if isFaceUp {
                rectangle.fill().foregroundColor(.white)
                rectangle.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                rectangle.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
