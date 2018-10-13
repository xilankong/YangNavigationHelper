//
//  PRHelper.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/7.
//  Copyright © 2017年 com.yang. All rights reserved.
//
import UIKit
import Foundation
import SnapKit

class App: NSObject {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let navHeight: CGFloat = 64
    static let navColor = UIColor(red: 1.0, green: 0.41, blue: 0.27, alpha: 1.0)
    static let textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)
    static let lineColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    
    static func navColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 1.0, green: 0.41, blue: 0.27, alpha: alpha)
    }
    
    static public func methodSwizze(cls:AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(cls, originalSelector), let swizzleMethod = class_getInstanceMethod(cls, swizzledSelector)  else {
            return
        }
        
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
    
    //是否IphoneX以上系列，判断是否有安全区域
    
    static func safeAreaTop() -> CGFloat {
        if #available(iOS 11.0, *) {
            //iOS 12.0以后的非刘海手机top为 20.0
            if (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom == 0 {
                return 20.0
            }
            return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.top ?? 20.0
        }
        return 20.0
    }
    
    static func safeAreaBottom() -> CGFloat {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    static func hasSafeArea() -> Bool {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? CGFloat(0) > CGFloat(0)
        } else { return false }
    }
    
    static func toolBarHeight() -> CGFloat {
        return 49 + safeAreaBottom()
    }
    
    static func navigationHeight() -> CGFloat {
        return 44 + safeAreaTop()
    }
    
}
