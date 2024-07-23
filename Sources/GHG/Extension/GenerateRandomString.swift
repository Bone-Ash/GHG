//
//  GenerateRandomString.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

/// 生成特定长度的随机字符串
/// - Parameter length: 长度
/// - Returns: 随机字符串
///
/// - Author: GH
public func generateRandomString(_ length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).compactMap { _ in characters.randomElement() })
}
