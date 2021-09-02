//
//  Cardify.swift
//  Memorize
//
//  Created by Артём Леознов on 01.09.2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                rectangle.fill().foregroundColor(.white)
                rectangle.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                rectangle.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
