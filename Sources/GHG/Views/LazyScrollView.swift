//
//  LazyScrollView.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import SwiftUI

/// 包装了 LazyVStack/LazyHStack 和 ScrollView
/// - Parameters:
///   - showsIndicators: 是否显示滚动指示器`default: flase`
///   - axis: 滚动方向 `default: .vertical`
///   - spacing: 间距`default: 16`
///   - content: Content
/// - Returns: LazyScrollView
public func LazyScrollView<Content: View>(
    showsIndicators: Bool = false,
    axis: Axis.Set = .vertical,
    spacing: CGFloat = 16,
    @ViewBuilder content: @escaping () -> Content
) -> some View {
    ScrollView(axis, showsIndicators: showsIndicators) {
        if axis == .horizontal {
            LazyHStack(spacing: spacing) {
                content()
            }
            .padding(.horizontal)
        } else {
            LazyVStack(spacing: spacing) {
                content()
            }
        }
    }
}
