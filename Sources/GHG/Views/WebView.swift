//
//  WebView.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import SwiftUI
import WebKit

/// 使用 UIViewRepresentable 将 WKWebView 引入 SwiftUI 的结构体
public struct WebView: UIViewRepresentable {
    /// 要加载的 URL
    public let url: URL
    
    /// 初始化方法
    /// - Parameter url: 要加载的 URL
    ///
    /// - Author: GH
    public init(url: URL) {
        self.url = url
    }
    
    /// 创建并返回 WKWebView
    /// - Parameter context: 上下文
    /// - Returns: WKWebView 实例
    ///
    /// - Author: GH
    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    /// 更新 WKWebView 的内容，每次 SwiftUI 视图状态更新时调用
    /// - Parameters:
    ///   - uiView: WKWebView 实例
    ///   - context: 上下文
    ///
    /// - Author: GH
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        // 创建 URL 请求并在主线程中加载到 WKWebView 中
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
