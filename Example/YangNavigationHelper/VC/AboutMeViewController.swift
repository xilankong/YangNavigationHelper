//
//  AboutMeViewController.swift
//  PersonalResume
//  原生样式
//  1、导航颜色变更、下边线
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "ABOUT ME"
        self.yang_setNavigationStatusBarStatus(.default)
//        self.yang_resetNavigation()
//        self.yang_setNavigationBackgroundColor(UIColor.green.withAlphaComponent(0.5))
        let button = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        button.setTitle("push 转场", for: UIControl.State.normal)
        button.setTitleColor(App.navColor, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goTo), for: UIControl.Event.touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
        button2.setTitle("modal 模态", for: UIControl.State.normal)
        button2.setTitleColor(App.navColor, for: UIControl.State.normal)
        button2.addTarget(self, action: #selector(goToTwo), for: UIControl.Event.touchUpInside)
        view.addSubview(button2)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func goTo() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
     @objc func goToTwo() {
        self.modalViewController(ModalViewController(), needNavigation: true, sender: nil)
    }
    
}
