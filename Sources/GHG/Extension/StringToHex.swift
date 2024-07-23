//
//  StringToHex.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

public extension Data {
    /// 转换为 16 进制字符串
    /// - Returns: HexString
    ///
    /// - Author: GH
    func hexEncodedString() -> String {
        return map { String(format: "%02.2hhx", $0) }.joined()
    }
}
