//
//  ModalViewController.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/7/3.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "modalVC"
        view.backgroundColor = UIColor.white
        let button2 = UIButton(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
        button2.setTitle("back", for: UIControl.State.normal)
        button2.setTitleColor(App.navColor, for: UIControl.State.normal)
        button2.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        view.addSubview(button2)
        let button = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        button.setTitle("home", for: UIControl.State.normal)
        button.setTitleColor(App.navColor, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goTo), for: UIControl.Event.touchUpInside)
        view.addSubview(button)
    }
    
    override func yang_navigationBarClass() -> AnyClass! {
        return YangNavigationBar.classForCoder()
    }

    @objc func goTo() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
