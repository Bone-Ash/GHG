//
//  StringToUTF-8.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

public extension String {
    /// 将字符串转换为 UTF-8 编码的 Data
    /// - Returns: 转换后的 Data，如果转换失败返回 nil
    ///
    /// - Author: GH
    func utf8() -> Data? {
        return self.data(using: .utf8)
    }
}
