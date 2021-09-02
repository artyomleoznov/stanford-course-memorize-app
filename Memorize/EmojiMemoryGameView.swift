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
                ProgressPie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                    .padding(DrawingConstants.progressPiePaddding)
                    .opacity(DrawingConstants.progressPieOpacity)
                Text(card.content)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.emojiFontSizeScale)
    }
    
    private func font(for size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * DrawingConstants.emojiFontSizeScale)
    }
    
    private struct DrawingConstants {
        static let emojiFontSizeScale: CGFloat = 0.60
        static let progressPiePaddding: CGFloat = 5
        static let progressPieOpacity = 0.5
        static let fontSize: CGFloat = 32
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
        
    }
}
