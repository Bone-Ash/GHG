//
//  Toast.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import AlertToast
import Foundation
import Observation

/// `ToastManager` 用于管理不同类型的 Toast 显示。
@MainActor @Observable
public class ToastManager {
    /// 单例实例
    public static let shared = ToastManager()
    private init() {}
    
    /// 是否显示普通 Toast
    public var showToast = false
    /// 是否显示加载中 Toast
    public var showLoadingToast = false
    /// 是否显示 HUD Toast
    public var showHUDToast = false
    /// 是否显示横幅 Toast
    public var showBannerToast = false
    
    /// 普通 Toast 对象
    public var toast = AlertToast(type: .regular)
    /// 加载中 Toast 对象
    public var loading = AlertToast(type: .loading, title: "Loading...")
    /// HUD Toast 对象
    public var hud = AlertToast(displayMode: .hud, type: .complete(.green))
    /// 横幅 Toast 对象
    public var banner = AlertToast(displayMode: .banner(.pop), type: .complete(.green))
    
    /// 显示加载中的 Toast
    ///
    /// - Author: GH
    public func loadingToast() {
        self.showLoadingToast = true
    }
    
    public func completeToast(title: String, subTitle: String? = nil) {
        self.toast = AlertToast(type: .complete(.green), title: title, subTitle: subTitle)
        self.showToast = true
    }
    
    /// 显示错误类型的 Toast
    /// - Parameters:
    ///   - title: Toast 的标题
    ///   - subTitle: Toast 的副标题，可选
    ///
    /// - Author: GH
    public func errorToast(title: String, subTitle: String? = nil) {
        self.hud = AlertToast(displayMode: .hud, type: .error(.red), title: title, subTitle: subTitle)
        self.showHUDToast = true
    }
    
    /// 显示 HUD Toast
    /// - Parameters:
    ///   - title: Toast 的标题
    ///   - subTitle: Toast 的副标题，可选
    public func HUDToast(successful: Bool = true, title: String, subTitle: String? = nil) {
        self.hud = AlertToast(
            displayMode: .hud,
            type: successful ? .complete(.green) : .error(.red),
            title: title,
            subTitle: subTitle
        )
        self.showHUDToast = true
    }
    
    /// 显示横幅类型的 Toast
    /// - Parameters:
    ///   - title: Toast 的标题
    ///   - subTitle: Toast 的副标题，可选
    ///
    /// - Author: GH
    public func bannerToast(title: String, subTitle: String? = nil) {
        self.banner = AlertToast(
            displayMode: .banner(.pop),
            type: .complete(.green),
            title: title,
            subTitle: subTitle
        )
        self.showBannerToast = true
    }
    
    /// 隐藏 Loading Toast
    ///
    /// - Author: GH
    public func hideLoadingToast() {
        self.showLoadingToast = false
    }
}
