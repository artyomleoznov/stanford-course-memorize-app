//
//  MemoryGame.swift
//  Memorize
//
//  Created by Артём Леознов on 16.08.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var previousSelectedCardIndex: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched
        else { return }
        
        guard let potentionalMatchIndex = previousSelectedCardIndex else {
            previousSelectedCardIndex = chosenIndex
            return
        }
        
        if cards[chosenIndex].content == cards[potentionalMatchIndex].content {
            cards[chosenIndex].isMatched = true
            cards[potentionalMatchIndex].isMatched = true
        }
        cards[chosenIndex].isFaceUp = true
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0...numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        }
        return nil
    }
}
