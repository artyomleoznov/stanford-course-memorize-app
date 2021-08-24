//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Артём Леознов on 08.08.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let rectangle = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    rectangle.fill().foregroundColor(.white)
                    rectangle.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(for: geometry.size))
                } else if card.isMatched {
                    rectangle.opacity(0)
                } else {
                    rectangle.fill()
                }
            }
        }
    }
    
    private func font(for size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * DrawingConstants.emojiFontSizeScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 16
        static let lineWidth: CGFloat = 3
        static let emojiFontSizeScale: CGFloat = 0.7
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        Group {
            EmojiMemoryGameView(game: game)
            //                .preferredColorScheme(.dark)
        }
    }
}
