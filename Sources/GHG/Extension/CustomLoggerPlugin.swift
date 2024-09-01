//
//  CustomLoggerPlugin.swift
//  GHG
//
//  Created by GH on 8/5/24.
//

import Moya
import SwiftyJSON
import Foundation

import Moya
import SwiftyJSON
import Foundation

public final class CustomLoggerPlugin: PluginType {
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
#if DEBUG
        if let httpRequest = request.request {
            print("----Request Start----")
            print("Request URL:")
            print(httpRequest.url?.absoluteString ?? "nil")
            print("Method: " + (httpRequest.httpMethod ?? "nil"))
            print("Headers:")
            print(httpRequest.allHTTPHeaderFields ?? "nil")
            
            if let body = httpRequest.httpBody {
                print("Request Body:")
                print(formatJSON(body) ?? "nil")
            }
        }
#endif
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
#if DEBUG
        print("----Response Start----")
        switch result {
        case .success(let response):
            print("Received response(\(response.statusCode))")
            
            if !response.data.isEmpty {
                print("Response Body:")
                print(JSON(response.data))
            }
            
        case .failure(let error):
            print("Error:")
            print(error)
        }
        print("----Response End----")
#endif
    }
    
    private func formatJSON(_ data: Data) -> String? {
        let json = try? JSON(data: data)
        return json?.rawString(options: .prettyPrinted)
    }
}
