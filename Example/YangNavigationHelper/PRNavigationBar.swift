//
//  PRNavigationBar.swift
//  PersonalResume
//
//  Created by yanghuang on 2017/6/8.
//  Copyright © 2017年 com.yang. All rights reserved.
//

import UIKit

protocol PRNavigationBarDelegate: class {
    func backButtonAction(withBackButton button: UIButton)

}

class PRNavigationBar: UIView {
    
    fileprivate let leftView: UIView = UIView()
    fileprivate let centerView: UIView = UIView()
    fileprivate let rightView: UIView = UIView()
    
    // MARK: - 左边按钮部分
    private var _backMessage = ""
    var backMessage: String {
        get {
            return _backMessage
        } set(newVlaue) {
            _backMessage = newVlaue
            if !_backMessage.isEmpty {
                backButton.setTitle("取消", for: UIControlState.normal)
                backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
                backButton.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: UIControlState.highlighted)
                backButton.setImage(nil, for: UIControlState.normal)
                backButton.setImage(nil, for: UIControlState.selected)
            } else {
                backButton.setTitle("", for: UIControlState.normal)
                backButton.setImage(#imageLiteral(resourceName: "nav_back_nor"), for: UIControlState.normal)
                backButton.setImage(#imageLiteral(resourceName: "nav_back_pre"), for: UIControlState.selected)
                backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
        }
    }
    
    let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(#imageLiteral(resourceName: "nav_back_nor"), for: UIControlState.normal)
        button.setImage(#imageLiteral(resourceName: "nav_back_pre"), for: UIControlState.selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private var _title: String = ""
    open var title: String {
        get{
            return _title
        }
        set {
            _title = newValue
            titleLabel.text = _title
        }
    }
    
    private var _subTitle: String = ""
    open var subTitle: String {
        get{
            return _subTitle
        }
        set {
            _subTitle = newValue
            subTitleLabel.text = _subTitle
        }
    }
    
    // MARK: - 中间titleView
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    fileprivate let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    

    fileprivate var _leftItem: UIView?
    open var leftItem: UIView? {
        get{
            return _leftItem
        }
        set{
            guard let view = newValue else {
                _ = self.leftView.subviews.map { $0.removeFromSuperview() }
                return
            }
            customLeftView(view: view)
        }
    }
    
    fileprivate var _centerItem: UIView?
    open var centerItem: UIView? {
        get{
            return _centerItem
        }
        set{
            guard let view = newValue else {
                _ = self.centerView.subviews.map { $0.removeFromSuperview() }
                return
            }
            customCenterView(view: view)
        }
    }
    
    fileprivate var _rightItem: UIView?
    open var rightItem: UIView? {
        get{
            return _rightItem
        }
        set{
            guard let view = newValue else {
                _ = self.rightView.subviews.map { $0.removeFromSuperview() }
                return
            }
            customRightView(view: view)
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: 44))
//        self.backgroundColor = App.navColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - 初始化UI
extension PRNavigationBar {

    fileprivate func initUI() {
        
        self.addSubview(leftView)
        self.addSubview(centerView)
        self.addSubview(rightView)
        
        leftView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.leading.bottom.equalTo(self)
            make.width.equalTo(44)
        }
        centerView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(self.leftView.snp.trailing)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self.rightView.snp.leading)
        }
        rightView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(self.centerView.snp.trailing)
            make.trailing.bottom.equalTo(self)
            make.width.equalTo(44)
        }
        createOrResetLeftView()
        createOrResetCenterView()

    }
    
    //MARK: - 还原默认leftView内容
    open func createOrResetLeftView() {
        _ = self.leftView.subviews.map { $0.removeFromSuperview() }
        _leftItem = nil
        leftView.addSubview(self.backButton)
        self.backButton.addTarget(self, action: #selector(backButtonAction), for: UIControlEvents.touchUpInside)
    }
    //MARK: - 移除leftView内容
    open func removeLeftView() {
        _ = self.leftView.subviews.map { $0.removeFromSuperview() }
    }
    
    //MARK: - 用户自定义leftView内容
    fileprivate func customLeftView(view: UIView) {
        _ = self.leftView.subviews.map { $0.removeFromSuperview() }
        _leftItem = view
        self.leftView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.leftView)
        }
    }
    
    //MARK: - 还原默认CenterView内容
    open func createOrResetCenterView() {
        _ = self.centerView.subviews.map { $0.removeFromSuperview() }
        _centerItem = nil
        self.centerView.addSubview(self.titleLabel)
        self.centerView.addSubview(self.subTitleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.subTitleLabel.snp.top).offset(-2)
            make.centerX.equalTo(self.centerView)
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.centerView).offset(9)
            make.centerX.equalTo(self.centerView)
        }
    }
    
    //MARK: - 用户自定义CenterView内容
    fileprivate func customCenterView(view: UIView) {
        _ = self.centerView.subviews.map { $0.removeFromSuperview() }
        self.centerView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.centerView)
        }
    }
    
    //MARK: - 还原默认RightView内容
    fileprivate func createOrResetRightView() {
        _ = self.rightView.subviews.map { $0.removeFromSuperview() }
        //doNothing
    }
    
    //MARK: - 用户自定义RightView内容
    fileprivate func customRightView(view: UIView) {
        _ = self.rightView.subviews.map { $0.removeFromSuperview() }
        self.rightView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.rightView)
        }
    }
    
    @objc fileprivate func backButtonAction() {
        
//        guard let delegate = self.delegate else {
//            return
//        }
//        delegate.backButtonAction(withBackButton: self.backButton)
    }
}

//MARK: - 其他内容
extension PRNavigationBar {

    

}
