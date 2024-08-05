//
//  CustomDividing.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import SwiftUI

/// 带有文字的水平分割线
public struct CustomDividing: View {
    /// 分割线文本
    public var text: String = ""
    /// 是否使用填充
    public var padding: Bool = true
    
    /// 初始化方法
    /// - Parameters:
    ///   - text: 分割线文本，默认为空字符串
    ///   - padding: 是否使用填充，默认为 `true`
    ///
    /// - Author: GH
    public init(text: String = "", padding: Bool = true) {
        self.text = text
        self.padding = padding
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(.quaternary)
            
            // 如果 text 非空，则显示文本并在文本两侧绘制分割线
            if !text.isEmpty {
                Text(text)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                
                Rectangle()
                    .fill(.quaternary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 2)
        .padding(.vertical, padding ? 8 : 0)
    }
}
