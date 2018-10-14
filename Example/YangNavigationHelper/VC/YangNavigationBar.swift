//
//  YangNavigationBar.swift
//  YangNavigationHelper_Example
//
//  Created by huang on 2018/10/14.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class YangNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: 100))
        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27)]
        let view = UIView(frame: CGRect(x: 0, y: -44, width: App.screenWidth, height: 100))
        view.backgroundColor = UIColor.red
        self.addSubview(view)
        self.bringSubviewToFront(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
