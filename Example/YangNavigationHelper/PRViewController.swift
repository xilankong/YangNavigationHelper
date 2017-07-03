//
//  PRViewController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/16.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class PRViewController: UIViewController {
    let customItemTag: Int = 999999
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let backButton = UIButton(type: UIButtonType.custom)
        backButton.tag = customItemTag
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        if self.preferredStatusBarStyle == UIStatusBarStyle.lightContent {
            backButton.setImage(#imageLiteral(resourceName: "nav_back_nor"), for: UIControlState.normal)
            backButton.setImage(#imageLiteral(resourceName: "nav_back_pre"), for: UIControlState.selected)
        } else {
            backButton.setImage(#imageLiteral(resourceName: "black_nor"), for: UIControlState.normal)
            backButton.setImage(#imageLiteral(resourceName: "black_nor"), for: UIControlState.selected)
        }
        backButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        return UIBarButtonItem(customView: backButton)
    }
}
