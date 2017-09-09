//
//  AboutMeViewController.swift
//  PersonalResume
//
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
        self.yang_setNavigationBackgroundColor(App.navColor)
        self.yang_setNavigationStatusBarStatus(.lightContent)
        let button = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        button.setTitle("push", for: UIControlState.normal)
        button.setTitleColor(App.navColor, for: UIControlState.normal)
        button.addTarget(self, action: #selector(goTo), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
        button2.setTitle("modal", for: UIControlState.normal)
        button2.setTitleColor(App.navColor, for: UIControlState.normal)
        button2.addTarget(self, action: #selector(goToTwo), for: UIControlEvents.touchUpInside)
        view.addSubview(button2)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        animationStart()
    }
    
//    func animationStart() {
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.duration = 1.2
//        animation.repeatCount = HUGE
//        animation.autoreverses = true
//        animation.fromValue = 1.0
//        animation.toValue = 1.1
//        imageView.layer.add(animation, forKey: "animation")
//    }
    
    func goTo() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    func goToTwo() {
        self.modalViewController(ModalViewController(), needNavigation: true, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
