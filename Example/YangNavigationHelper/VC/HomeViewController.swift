//
//  HomeViewController.swift
//  PersonalResume
//  渐变色、改变状态栏、
//  Created by yanghuang on 2017/6/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let tableViewHeadHight: CGFloat = 200 / 320  * App.screenWidth
    static let triggerMargin: CGFloat = 30
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableView.Style.plain)
        return tableView
    }()

    lazy var bgImageView: UIImageView = {
        let image = #imageLiteral(resourceName: "bgImageView")
        let bgView = UIImageView(image: image)
        bgView.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: HomeViewController.tableViewHeadHight)
        bgView.contentMode = UIView.ContentMode.center
        bgView.clipsToBounds = true
        return bgView
    }()
    
    var iconView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
             self.automaticallyAdjustsScrollViewInsets = false
        }
        self.yang_hideBackButton = true
//        放这里不行，简直是神经病，必须视图完全展示才可以
//        self.yang_setNavigationBackgroundColor(UIColor(white: 1, alpha: 0))
//        self.yang_setNavigationStatusBarStatus(.lightContent)
    }
    
    override func viewDidLayoutSubviews() {
//        super.viewDidAppear(animated)
        super.viewDidLayoutSubviews()
    }

    func initUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = tableHeadViewInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - tableHeadView init
extension HomeViewController {
    
    func tableHeadViewInit() -> UIView {
        let tableHeadView = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: HomeViewController.tableViewHeadHight))
        tableHeadView.backgroundColor = UIColor.clear
        tableHeadView.addSubview(bgImageView)
        let iconView = UIImageView(image: UIImage.init(color: UIColor.red))
        iconView.layer.cornerRadius = 35
        iconView.layer.masksToBounds = true
        tableHeadView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        return tableHeadView
    }
}

// MARK: - tableView代理、数据源
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "123456"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetialViewController(), animated: true)
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y < (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin)){
  
            self.title = ""
        }else if (scrollView.contentOffset.y >= (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin) && scrollView.contentOffset.y <= (HomeViewController.tableViewHeadHight - App.navHeight) ){
            let alpha = ((scrollView.contentOffset.y - (HomeViewController.tableViewHeadHight - App.navHeight - HomeViewController.triggerMargin)) / HomeViewController.triggerMargin)

            self.title = ""
        }else if (scrollView.contentOffset.y > (HomeViewController.tableViewHeadHight - App.navHeight)){
            self.title = "HOME"
        }
    }
    
}

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    
}
