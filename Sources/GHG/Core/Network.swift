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
        URLCache.shared.removeAllCachedResponses()
        cancelAllRequests()
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

public final class CustomLoggerPlugin: PluginType {
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
#if DEBUG
        if let httpRequest = request.request {
            print("----Request Start----")
            print("----Send Request----")
            print(httpRequest.url?.absoluteString ?? "nil")
            print("----Method----")
            print(httpRequest.httpMethod ?? "nil")
            print("----Headers----")
            print(httpRequest.allHTTPHeaderFields ?? "nil")
            
            if let body = httpRequest.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("----Body----")
                print(bodyString)
            }
            print("----Request End----")
            
        }
#endif
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
#if DEBUG
        print("----Response Start----")
        switch result {
        case .success(let response):
            print("Received response(\(response.statusCode)) from: \(response.response?.url?.absoluteString ?? "")")
            
            if let responseString = String(data: response.data, encoding: .utf8) {
                print("----Response Body----")
                print(responseString)
            }
            
        case .failure(let error):
            print("----Error----")
            print(error)
        }
        print("----Response End----")
#endif
    }
}
