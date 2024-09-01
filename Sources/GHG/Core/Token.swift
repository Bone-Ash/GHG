//
//  Token.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation

/// `TokenManager` 负责管理和刷新应用的访问令牌
public actor TokenManager {
    /// 全局并发队列，用于同步访问 Token
    private static let tokenQueue = DispatchQueue(label: "com.token.manager.queue", attributes: .concurrent)
    
    /// 当前的访问令牌，初始化时从 Keychain 中获取
    private static var accessToken: String? = KeychainManager.getAccessTokenFromKeychain()
    
    /// 标记是否正在刷新 Token，避免并发刷新
    private static var isRefreshing = false
    
    /// 获取当前有效的 Token。
    /// - Returns: 当前有效的 Token，如果不存在则尝试刷新并返回新 Token。
    ///
    /// - Author: GH
    public static func currentToken() -> String? {
        return tokenQueue.sync {
            if !isRefreshing {
                // 如果 Token 已存在且不在刷新状态，则直接返回当前 Token
                return accessToken
            } else {
                // 如果正在刷新，等待刷新完成后返回新 Token
                return refreshTokenIfNeeded()
            }
        }
    }
    
    /// 检查是否需要刷新 Token，并根据需要启动刷新流程。
    /// - Returns: 新 Token (String) 或现有 Token。
    ///
    /// - Author: GH
    private static func refreshTokenIfNeeded() -> String? {
        return tokenQueue.sync(flags: .barrier) {
            if isRefreshing {
                // 如果正在刷新 Token，则等待刷新完成后返回新 Token
                return accessToken
            } else {
                // 标记开始刷新 Token
                isRefreshing = true
                
                // 执行 Token 刷新操作
                let newToken = refreshToken()
                accessToken = newToken
                
                // 标记刷新完成
                isRefreshing = false
                return newToken
            }
        }
    }
    
    /// 同步刷新 Token 的实现。
    /// - Returns: 新生成的 Token。
    ///
    /// - Author: GH
    private static func refreshToken() -> String {
        // 实际的 Token 刷新逻辑
        return "new_token_string"
    }
    
    /// 绑定 Device Token 至后端服务器。
    /// - Parameter token: 需要绑定的 Device Token。
    ///
    /// - Author: GH
    public static func bindingDeviceToken(_ token: String) {
        // 实现绑定 Device Token 的逻辑
    }
}
