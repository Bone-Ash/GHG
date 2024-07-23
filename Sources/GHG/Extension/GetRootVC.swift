//
//  GetRootVC.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import UIKit

/// 获取当前视图
/// - Returns: 当前 UIViewController
///
/// - Author: GH
@MainActor
public func getRootViewController() -> UIViewController {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
        fatalError("No root view controller found.")
    }
    return rootViewController
}
