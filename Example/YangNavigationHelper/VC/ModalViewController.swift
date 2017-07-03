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
        view.backgroundColor = UIColor.white
        let button2 = UIButton(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
        button2.setTitle("back", for: UIControlState.normal)
        button2.setTitleColor(App.navColor, for: UIControlState.normal)
        button2.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        view.addSubview(button2)
        let button = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        button.setTitle("home", for: UIControlState.normal)
        button.setTitleColor(App.navColor, for: UIControlState.normal)
        button.addTarget(self, action: #selector(goTo), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }

    func goTo() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
