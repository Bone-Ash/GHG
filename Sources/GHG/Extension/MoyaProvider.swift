//
//  MoyaProvider.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Moya
import Foundation
import SwiftyJSON

@MainActor
public extension MoyaProvider where Target == MultiTarget {
    /// 带超时处理和 Toast 显示的请求方法
    /// - Parameters:
    ///   - target: 请求接口
    ///   - showLoading: 是否显示 Loading
    ///   - completion: 处理响应的闭包
    ///
    /// - Author: GH
    func moyaRequest(_ target: TargetType, showLoading: Bool = false, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        if showLoading { ToastManager.shared.loadingToast() }
        
        self.request(MultiTarget(target)) { [weak self] result in
            if showLoading { ToastManager.shared.hideLoadingToast() }
            
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                completion(.success(response))
#if DEBUG
                // TODO: 后续可删除
                let json = JSON(response.data)
                print(json)
#endif
            case .failure(let error):
                if let underlyingError = (error as NSError).userInfo[NSUnderlyingErrorKey] as? URLError, underlyingError.code == .timedOut {
                    self.handleRequestTimeout()
                } else {
                    self.handleRequestError(error: error)
                }
                
                completion(.failure(error))
            }
        }
    }
    
    /// 异步请求
    /// - Parameters:
    ///   - target: 请求接口
    ///   - showLoading: 是否显示 Loading
    ///   - successFeedback: 是否在成功时显示反馈
    ///   - failureFeedBack: 是否在失败时显示反馈
    ///   - successAction: 请求成功后的处理闭包
    ///   - failureAction: 请求失败后的处理闭包
    ///
    /// - Author: GH
    func moyaRequest(_ target: TargetType, showLoading: Bool = false, successFeedback: Bool = false, failureFeedBack: Bool = false, successAction: @escaping (JSON) -> Void, failureAction: (() -> Void)? = nil) {
        if showLoading { ToastManager.shared.loadingToast() }
        
        self.request(MultiTarget(target)) { result in
            if showLoading { ToastManager.shared.hideLoadingToast() }
            
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                
                if json["code"].intValue == 200 {
                    if successFeedback {
                        Hap.success()
                        ToastManager.shared.completeToast(title: json["message"].stringValue)
                    }
                    
                    successAction(json["data"])
                    
                } else {
                    if failureFeedBack {
                        Hap.error()
                        ToastManager.shared.errorToast(title: json["message"].stringValue)
                    }
#if DEBUG
                    if !json["message"].stringValue.isEmpty {
                        print("Error message: \n\(json["message"])")
                    }
#endif
                    failureAction?()
                }
                
            case .failure(let error):
                if let underlyingError = (error as NSError).userInfo[NSUnderlyingErrorKey] as? URLError, underlyingError.code == .timedOut {
                    self.handleRequestTimeout()
                } else {
                    self.handleRequestError(error: error)
                }
                
                failureAction?()
            }
        }
    }
    
    /// 处理请求超时
    ///
    /// - Author: GH
    private func handleRequestTimeout() {
        DispatchQueue.main.async {
            // ToastManager.shared.errorToast(title: "Request Timed Out", subTitle: "The request took too long to complete.")
            NetworkManager.shared.releaseResources()
        }
    }
    
    /// 处理请求错误
    ///
    /// - Author: GH
    private func handleRequestError(error: MoyaError) {
        DispatchQueue.main.async {
            // ToastManager.shared.errorToast(title: "Request Failed", subTitle: error.localizedDescription)
            NetworkManager.shared.releaseResources()
        }
    }
}

//
//struct CustomTarget: TargetType {
//    let base: TargetType
//    let additionalHeaders: [String: String]
//
//    var baseURL: URL { base.baseURL }
//    var path: String { base.path }
//    var method: Moya.Method { base.method }
//    var sampleData: Data { base.sampleData }
//    var task: Task { base.task }
//    var headers: [String: String]? {
//        var headers = base.headers ?? [:]
//        additionalHeaders.forEach { headers[$0] = $1 }
//        return headers
//    }
//}
//
//extension TargetType {
//    func withAdditionalHeaders(_ additionalHeaders: [String: String]) -> CustomTarget {
//        return CustomTarget(base: self, additionalHeaders: additionalHeaders)
//    }
//}
