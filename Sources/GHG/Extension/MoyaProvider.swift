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
    
    func moyaRequest(_ target: TargetType, showLoading: Bool = false, successFeedback: Bool = false, failureFeedBack: Bool = false, successAction: @escaping (JSON) -> Void, failureAction: (() -> Void)? = nil) {
        if showLoading { ToastManager.shared.loadingToast() }
        
        self.request(MultiTarget(target)) { result in
            if showLoading { ToastManager.shared.hideLoadingToast() }
            
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                
                if json["code"].stringValue == "0" {
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
