//
//  FlowLayout.swift
//  GHG
//
//  Created by GH on 8/5/24.
//

import SwiftUI

public struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    public let items: Data
    public let spacing: CGFloat
    public let content: (Data.Element) -> Content
    
    @State private var totalHeight: CGFloat = .zero
    
    public init(items: Data, spacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }
    
    public func generateContent(in geometry: GeometryProxy) -> some View {
        var currentWidth = CGFloat.zero
        var currentHeight = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                content(item)
                    .padding(spacing / 2)
                    .alignmentGuide(.leading) { dimension in
                        let result = self.calculateWidth(dimension: dimension, geometry: geometry, currentWidth: &currentWidth, currentHeight: &currentHeight, item: item)
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = currentHeight
                        if item == items.last! {
                            currentHeight = 0
                        }
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func calculateWidth(dimension: ViewDimensions, geometry: GeometryProxy, currentWidth: inout CGFloat, currentHeight: inout CGFloat, item: Data.Element) -> CGFloat {
        if abs(currentWidth - dimension.width) > geometry.size.width {
            currentWidth = 0
            currentHeight -= dimension.height
        }
        
        let result = currentWidth
        
        if item == items.last! {
            currentWidth = 0
        } else {
            currentWidth -= dimension.width
        }
        
        return result
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.size.height
            }
            return Color.clear
        }
    }
}
