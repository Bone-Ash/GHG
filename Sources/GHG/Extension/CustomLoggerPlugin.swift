//
//  CustomLoggerPlugin.swift
//  GHG
//
//  Created by GH on 8/5/24.
//

import Moya

public final class CustomLoggerPlugin: PluginType {
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
#if DEBUG
        if let httpRequest = request.request {
            print("----Request Start----")
            print("Request URL:")
            print(httpRequest.url?.absoluteString ?? "nil")
            print("Method:" + (httpRequest.httpMethod ?? "nil"))
            print("Headers:")
            print(httpRequest.allHTTPHeaderFields ?? "nil")
            
            if let body = httpRequest.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("Body:")
                print(bodyString)
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
            
            if let responseString = String(data: response.data, encoding: .utf8) {
                if !responseString.isEmpty {
                    print("Response Body:")
                    print(responseString)
                }
            }
            
        case .failure(let error):
            print("Error:")
            print(error)
        }
        print("----Response End----")
#endif
    }
}
