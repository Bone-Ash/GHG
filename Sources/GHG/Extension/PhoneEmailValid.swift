//
//  PhoneEmailValid.swift
//  
//
//  Created by GH on 7/23/24.
//

import Foundation

public extension String {
    /// 验证电子邮件格式
    /// - Returns: 是否为一个邮箱格式(Bool)
    ///
    /// - Author: GH
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// 验证手机号和邮箱格式
    /// - Returns: 是否为标准手机号格式(Bool)
    ///
    /// - Author: GH
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
}
