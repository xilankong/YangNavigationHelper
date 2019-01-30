//
//  DetialViewController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/12.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class DetialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.pr_setNavColor(color: App.navColor)
        let scrollview = UIScrollView(frame: view.frame)
        scrollview.contentSize = CGSize(width: App.screenWidth, height: 1000)
        view.addSubview(scrollview)
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
