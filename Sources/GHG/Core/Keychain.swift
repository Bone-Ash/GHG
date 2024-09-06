//
//  Keychain.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import KeychainSwift

/// `KeychainManager` 用于管理 Keychain 中的各种令牌和标识符。
public struct KeychainManager {
    /// 保存 Access Token 至 Keychain
    /// - Parameter accessToken: accessToken(String)
    ///
    /// - Author: GH
    public static func saveAccessTokenToKeychain(_ accessToken: String) {
        KeychainSwift().set(accessToken, forKey: "AccessToken")
#if DEBUG
//        print("Access Token: \(accessToken)")
#endif
    }
    
    /// 保存 Refresh Token 至 Keychain
    /// - Parameter refreshToken: refreshToken(String)
    ///
    /// - Author: GH
    public static func saveRefreshTokenToKeychain(_ refreshToken: String) {
        KeychainSwift().set(refreshToken, forKey: "RefreshToken")
#if DEBUG
//        print("Refresh Token: \(refreshToken)")
//        print("---Saved successfully!---")
#endif
    }
    
    /// 从 Keychain 中读取 Access Token
    /// - Returns: accessToken(String)
    ///
    /// - Author: GH
    public static func getAccessTokenFromKeychain() -> String? {
        return KeychainSwift().get("AccessToken")
    }
    
    /// 从 Keychain 中读取 Refresh Token
    /// - Returns: refreshToken(String)
    ///
    /// - Author: GH
    public static func getRefreshTokenFromKeychain() -> String? {
        return KeychainSwift().get("RefreshToken")
    }
    
    /// 从 Keychain 中删除 Token
    ///
    /// - Author: GH
    public static func deleteToken() {
        KeychainSwift().delete("AccessToken")
        KeychainSwift().delete("RefreshToken")
    }
    
    /// 保存 Device Token 至 Keychain
    /// - Parameter deviceToken: 设备令牌 (String)
    ///
    /// - Author: GH
    public static func saveDeviceTokenToKeychain(_ deviceToken: String) {
        KeychainSwift().set(deviceToken, forKey: "DeviceToken")
#if DEBUG
        print("Device Token: \(deviceToken)")
        print("---Saved successfully!---")
#endif
    }
    
    /// 从 Keychain 中读取 Device Token
    /// - Returns: 设备令牌 (String)
    ///
    /// - Author: GH
    public static func getDeviceTokenFromKeychain() -> String? {
        return KeychainSwift().get("DeviceToken")
    }
    
    /// 从 Keychain 中删除 Device Token
    ///
    /// - Author: GH
    public static func deleteDeviceToken() {
        KeychainSwift().delete("DeviceToken")
    }
    
    /// 保存 UUID 至 Keychain
    /// - Parameter UUID: UUID 字符串
    ///
    /// - Author: GH
    public static func saveUUID(_ UUID: String) {
        KeychainSwift().set(UUID, forKey: "UUID")
#if DEBUG
        print("UUID: \(UUID)")
        print("---Saved successfully!---")
#endif
    }
    
    /// 从 Keychain 中读取 UUID
    /// - Returns: UUID 字符串
    ///
    /// - Author: GH
    public static func getUUID() -> String? {
        return KeychainSwift().get("UUID")
    }
    
    /// 从 Keychain 中删除 UUID
    ///
    /// - Author: GH
    public static func deleteUUID() {
        KeychainSwift().delete("UUID")
    }
}
