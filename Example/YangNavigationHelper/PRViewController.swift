////
////  PRViewController.swift
////  PersonalResume
////
////  Created by yanghuang on 2017/6/16.
////  Copyright © 2017年 com.yang. All rights reserved.
////
//
//import UIKit
//
//class PRViewController: UIViewController {
//    let customItemTag: Int = 999999
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func yang_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
//        let backButton = UIButton(type: UIButton.ButtonType.custom)
//        backButton.tag = customItemTag
//        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        if self.preferredStatusBarStyle == UIStatusBarStyle.lightContent {
//            backButton.setImage(#imageLiteral(resourceName: "nav_back_nor"), for: UIControl.State.normal)
//            backButton.setImage(#imageLiteral(resourceName: "nav_back_pre"), for: UIControl.State.selected)
//        } else {
//            backButton.setImage(#imageLiteral(resourceName: "black_nor"), for: UIControl.State.normal)
//            backButton.setImage(#imageLiteral(resourceName: "black_nor"), for: UIControl.State.selected)
//        }
//        backButton.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
//        return UIBarButtonItem(customView: backButton)
//    }
//}
