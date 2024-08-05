//
//  FlowItem.swift
//  GHG
//
//  Created by GH on 8/5/24.
//

import SwiftUI

public struct FlowItem: View {
    public let text: String
    public let action: (() -> Void)?
    
    public init(text: String, action: (() -> Void)? = nil) {
        self.text = text
        self.action = action
    }
    
    public var body: some View {
        Text(text)
            .padding(6)
            .padding(.horizontal, 3)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onTapGesture {
                action?()
            }
    }
}
