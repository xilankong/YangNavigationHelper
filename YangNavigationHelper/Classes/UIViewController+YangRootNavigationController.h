//
//  UIViewController+YangRootNavigationController.h
//  
//  UIViewController 关于YangRootNavigationController的扩展
//  Created by yanghuang on 2017/9/4.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YangRootNavigationController;

@protocol YangNavigationItemCustomizable <NSObject>

@optional

/*!
 *  @brief 实现此方法自定义返回按钮、默认返回按钮为 “back” 文案按钮
 *
 *  @return a custom UIBarButtonItem
 */
- (UIBarButtonItem *)yang_customBackItemWithTarget:(id)target action:(SEL)action;

@end

IB_DESIGNABLE
@interface UIViewController (YangRootNavigationController)

/*!
 *  @brief 控制手势返回
 */
@property (nonatomic, assign) IBInspectable BOOL yang_disableInteractivePop;

/*!
 *  @brief self.navigationController 获取到的是  YangContainerNavigationController
 *  当需要获取真实推送导航的时候使用 yang_navigationController
 */
@property (nonatomic, readonly, strong) YangRootNavigationController *yang_navigationController;

/*!
 *  @brief 重写此方法自定义UINavigationBar，默认返回 nil
 *
 *  @return new UINavigationBar class
 */
- (Class)yang_navigationBarClass;

/*!
 *  @brief 模态控制器，可以设置是否需要导航
 *
 */
- (void)modalViewController:(UIViewController *)viewController needNavigation:(BOOL) navNeed sender:(id) sender;
@end


#pragma mark NavigationBar 部分扩展

@interface UIViewController (NavigationBar) <YangNavigationItemCustomizable>

IB_DESIGNABLE

/*!
 *  @brief 状态栏控制使用,建议使用：
 *  - (void)yang_setNavigationStatusBarStatus:(UIStatusBarStyle)style
 */
@property (nonatomic, assign) IBInspectable BOOL yang_lightContentBar;

/*!
 *  @brief 控制返回按钮设置
 */
@property (nonatomic, strong, readonly) UIButton *yang_backButton;

/*!
 *  @brief 控制返回显示
 */
@property (nonatomic, assign) BOOL yang_hideBackButton;

@end
