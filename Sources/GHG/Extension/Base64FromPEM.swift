//
//  Base64FromPEM.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

/// 从 PEM 格式的公钥字符串中提取 Base64 编码的公钥字符串。
/// - Parameter pemString: 包含 PEM 格式公钥的字符串。
/// - Returns: Base64 编码的公钥字符串。
///
/// - Author: GH
public func base64FromPEM(_ pemString: String) -> String {
    let base64String = pemString
        .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
        .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
        .replacingOccurrences(of: "\r\n", with: "")
        .replacingOccurrences(of: "\n", with: "")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    return base64String
}
