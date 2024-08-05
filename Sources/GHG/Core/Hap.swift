//
//  Hap.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import UIKit

/// `Hap` 结构体提供了各种触觉反馈生成器的封装方法。
@MainActor
public struct Hap {
    /// 触发错误通知反馈。
    ///
    /// - Author: GH
     public static func error() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    /// 触发成功通知反馈。
    ///
    /// - Author: GH
    public static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    /// 触发轻度触觉反馈。
    ///
    /// - Author: GH
    public static func light() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    /// 触发中度触觉反馈。
    ///
    /// - Author: GH
    public static func medium() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    /// 触发重度触觉反馈。
    ///
    /// - Author: GH
    public static func heavy() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    /// 触发轻柔触觉反馈。
    ///
    /// - Note: 仅在 iOS 13.0 及以上版本可用。
    /// - Author: GH
    public static func soft() {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }
    
    /// 触发刚性触觉反馈。
    ///
    /// - Note: 仅在 iOS 13.0 及以上版本可用。
    /// - Author: GH
    public static func rigid() {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        }
    }
    
    /// 触发选择变化反馈。
    ///
    /// - Author: GH
    public static func selection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}
