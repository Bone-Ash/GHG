//
//  Base64URLEncodedString.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

public extension Data {
    /// 将 Base64 Data 编码转换为 Base64Url 编码
    /// - Returns: Base64Url String
    ///
    /// - Author: GH
    func base64UrlEncodedString() -> String {
        let base64EncodedString = self.base64EncodedString()
        
        let base64UrlEncodedString = base64EncodedString
            .replacingOccurrences(of: "+", with: "-")   // 替换 '+' 为 '-'
            .replacingOccurrences(of: "/", with: "_")   // 替换 '/' 为 '_'
            .replacingOccurrences(of: "=", with: "")    // 删除所有 '='
        
        return base64UrlEncodedString
    }
}

public extension String {
    /// 将对应的 Base64 加密字符串转为 Base64Url 字符串
    /// - Returns: Base64Url String
    ///
    /// - Author: GH
    func base64UrlEncodedString() -> String? {
        let base64UrlEncodedString = self
            .replacingOccurrences(of: "+", with: "-")   // 替换 '+' 为 '-'
            .replacingOccurrences(of: "/", with: "_")   // 替换 '/' 为 '_'
            .replacingOccurrences(of: "=", with: "")    // 删除所有 '='
        
        return base64UrlEncodedString
    }
}
