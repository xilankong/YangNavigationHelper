//
//  PRLayer.swift
//  PersonalResume
//  root
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit
import YangNavigationHelper

class PRLayer: NSObject {
    
    var mainWindow: UIWindow?
    var rootViewController: UIViewController?
    var navigationController: YangRootNavigationController?
    var tabBarViewController: PRTabBarController?
    
    static let layer: PRLayer = PRLayer()

    // MARK: - 初始化
    override init() {
        super.init()
        createObjects()
    }
    
    func createObjects() {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        tabBarViewController = PRTabBarController()
        navigationController = YangRootNavigationController(rootViewControllerNoWrapping: PRTabBarController())
        rootViewController = navigationController
    }
    
    
    // MARK: - 展示第一个UI页面
    func appUIBegin() {
        mainWindow?.rootViewController = navigationController
        mainWindow?.makeKeyAndVisible()
    }
    
}
