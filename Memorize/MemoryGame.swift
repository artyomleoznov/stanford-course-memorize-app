//
//  MemoryGame.swift
//  Memorize
//
//  Created by Артём Леознов on 16.08.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var previousSelectedCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched
        else {
            return
        }
        
        guard let potentionalMatchIndex = previousSelectedCardIndex else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            previousSelectedCardIndex = chosenIndex
            cards[chosenIndex].isFaceUp.toggle()
            return
        }
       
        if (cards[chosenIndex].content == cards[potentionalMatchIndex].content) {
            cards[chosenIndex].isMatched = true
            cards[potentionalMatchIndex].isMatched = true
        }
        previousSelectedCardIndex = nil
        
        cards[chosenIndex].isFaceUp.toggle()

    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0...numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
