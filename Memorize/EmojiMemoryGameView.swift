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
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
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
                    ProgressPie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                        .padding(DrawingConstants.progressPiePaddding)
                        .opacity(DrawingConstants.progressPieOpacity)
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let emojiFontSizeScale: CGFloat = 0.60
        static let progressPiePaddding: CGFloat = 5
        static let progressPieOpacity = 0.5
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
        
    }
}
