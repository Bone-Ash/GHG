//
//  ShakeEffect.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import SwiftUI

public struct ShakeEffect: GeometryEffect {
    /// 震动的幅度
    public var amount: CGFloat = 10
    /// 每单位时间的震动次数
    public var shakesPerUnit: CGFloat = 3
    /// 动画数据，用于控制动画进度
    public var animatableData: CGFloat
    
    /// 初始化 `ShakeEffect` 结构体
    /// - Parameters:
    ///   - amount: 震动的幅度，默认为 10
    ///   - shakesPerUnit: 每单位时间的震动次数，默认为 3
    ///   - animatableData: 动画数据，用于控制动画进度
    ///
    /// - Author: GH
    public init(amount: CGFloat = 10, shakesPerUnit: CGFloat = 3, animatableData: CGFloat) {
        self.amount = amount
        self.shakesPerUnit = shakesPerUnit
        self.animatableData = animatableData
    }
    
    /// 正弦抖动效果
    /// - Parameter size: 视图的大小
    /// - Returns: 投影变换，用于应用震动效果
    /// - Note: 只要在视图上加 `.modifier(ShakeEffect(animatableData: 变量))`，然后使用 `withAnimation` 改动这个变量，即可实现震动效果。
    ///
    /// - Author: GH
    public nonisolated func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * shakesPerUnit), y: 0))
    }
}
