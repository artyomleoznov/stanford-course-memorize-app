//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Артём Леознов on 16.08.2021.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🚗", "🛵", "🚂", "🚤", "🚃", "✈️", "🏍", "🛴", "🚁", "🚀", "🚲", "⛵️",
                  "🛰", "🛸", "🛶", "🚛", "🚑", "🚄", "🚒", "🚙", "🛳", "🏎", "⛴"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}

