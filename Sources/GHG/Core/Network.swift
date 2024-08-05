//
//  Network.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Moya
import SwiftUI

@MainActor
public class NetworkManager {
    public static let shared = NetworkManager()
    
    private static let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Session(configuration: configuration)
    }()
    
    public var provider: MoyaProvider<MultiTarget>
    public var pluginProvider: MoyaProvider<MultiTarget>
    public var testProvider: MoyaProvider<MultiTarget>
    
    private init() {
        self.provider = MoyaProvider<MultiTarget>(session: NetworkManager.session)
        self.pluginProvider = MoyaProvider<MultiTarget>(session: NetworkManager.session, plugins: [CustomLoggerPlugin()])
        self.testProvider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    /// 释放资源（清理缓存 + 取消请求）
    ///
    /// - Author: GH
    public func releaseResources() {
        // 清理缓存
        URLCache.shared.removeAllCachedResponses()
        
        // 取消所有正在进行的网络请求
        cancelAllRequests()
        
        print("NetworkManager resources released.")
    }
    
    /// 取消所有请求
    ///
    /// - Author: GH
    private func cancelAllRequests() {
        provider.session.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
        
        pluginProvider.session.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
}
