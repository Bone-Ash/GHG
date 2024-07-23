//
//  Network.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Moya
import SwiftyJSON
import SwiftUI

@MainActor
public class NetworkManager: @unchecked Sendable {
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
    
    /// 释放资源
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

// TODO: 使用 Apple 登陆/注册 封装进来
/// 使用 Google 登陆
/// - Parameter completion: 使用获取的 Google Token 处理 closure
///
/// - Author: GH
//    public func authWithGoogle(completion: @escaping (_ token: String?) -> Void) {
//        // 使用 GIDSignIn 的 signIn，使用 getRootView Controller 获取当前 View Controller，将 Action Button 显示于当前 View Controller 上
//        GIDSignIn.sharedInstance.signIn(withPresenting: Self.getRootViewController()) { result, error in
//            guard error == nil else {
//                print("Authentication error: \(error!.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            // 获取 Google Token
//            let googleToken = result?.user.idToken?.tokenString
//
//            print("Google Token: \(googleToken)")
//
//            completion(googleToken)
//        }
//    }

public final class CustomLoggerPlugin: PluginType {
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
#if DEBUG
        if let httpRequest = request.request {
            print("Sending request: \(httpRequest.url?.absoluteString ?? "")")
            print("Method: \(httpRequest.httpMethod ?? "")")
            if let headers = httpRequest.allHTTPHeaderFields {
                print("Headers: \(headers)")
            }
            if let body = httpRequest.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("Body: \(bodyString)")
            }
        }
#endif
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
#if DEBUG
        switch result {
        case .success(let response):
            print("Received response(\(response.statusCode)) from: \(response.response?.url?.absoluteString ?? "")")
            
            if let responseString = String(data: response.data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }
        case .failure(let error):
            print("Request failed with error: \(error)")
        }
#endif
    }
}
