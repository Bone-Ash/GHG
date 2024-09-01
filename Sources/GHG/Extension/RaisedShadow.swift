//
//  File.swift
//  GHG
//
//  Created by GH on 8/19/24.
//

import SwiftUI

struct RaisedShadowModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    private var shadowColor: Color {
        switch colorScheme {
        case .light:
            return Color(white: 0.333).opacity(0.1)
        case .dark:
            return Color(white: 1).opacity(0.5)
        @unknown default:
            return Color(white: 0.7).opacity(0.1)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .shadow(color: shadowColor, radius: 1, x: 0, y: 0)
    }
}

extension View {
    public func raisedShadow() -> some View {
        self.modifier(RaisedShadowModifier())
    }
}
