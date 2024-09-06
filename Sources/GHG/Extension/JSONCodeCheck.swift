//
//  JSONCodeCheck.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation
import SwiftyJSON

/// 判断回传 JSON 的字段值是否符合预期条件
/// - Parameters:
///   - json: JSON 实例
///   - successFeedback: 是否在成功时开启反馈震动，默认为 false
///   - failureFeedback: 是否在失败时开启反馈震动，默认为 false
///   - successAction: 当 JSON 中的指定字段值符合预期条件时执行的闭包，传递 `json["data"]` 作为参数
///   - failureAction: 当 JSON 中的指定字段值不符合预期条件时执行的可选闭包
///
/// - Author: GH
@MainActor
public func jsonCodeCheck(_ json: JSON, successFeedback: Bool = false, failureFeedBack: Bool = false, successAction: (_ data: JSON) -> Void, failureAction: (() -> Void)? = nil) {
    if json["code"].intValue == 200 {
        if successFeedback {
            Hap.success()
            ToastManager.shared.completeToast(title: json["message"].stringValue)
        }
        
        successAction(json["data"])
    } else {
        if failureFeedBack {
            Hap.error()
            // 显示错误的 Toast
            ToastManager.shared.errorToast(title: json["message"].stringValue)
            failureAction?()
        }
#if DEBUG
        if !json["message"].stringValue.isEmpty {
            print("Error message: \n\(json["message"])")
        }
#endif
    }
}
