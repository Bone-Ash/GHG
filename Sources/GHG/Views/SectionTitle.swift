//
//  SectionTitle.swift
//  GHG
//
//  Created by GH on 9/1/24.
//

import SwiftUI

public struct SectionTitle<Destination: View>: View {
    var title: String
    var destination: (() -> Destination)?
    
    public init(_ title: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    public init(_ title: String) where Destination == EmptyView {
        self.title = title
        self.destination = nil
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let destination = destination {
                NavigationLink(destination: destination()) {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontDesign(.rounded)
                }
                .tint(.primary)
            }
        }
    }
}
