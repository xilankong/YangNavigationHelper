//
//  YangRootNavigationController.h
//
//  来自RTNavigationController、已做适配
//  Created by yanghuang on 2017/9/4.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+YangRootNavigationController.h"
#import "YangNavigationHelper.h"

@interface YangContainerController : UIViewController
@property (nonatomic, readonly, strong) __kindof UIViewController *contentViewController;
@end

/**
 *  @class YangContainerNavigationController
 *  @brief This Controller will forward all @a Navigation actions
 *  使用Demo
 *  带 UITabBarController 场景：
     tabController.viewControllers = @[[[YangContainerNavigationController alloc] initWithRootViewController:vc1],
     [[YangContainerNavigationController alloc] initWithRootViewController:vc2],
     [[YangContainerNavigationController alloc] initWithRootViewController:vc3],
     [[YangContainerNavigationController alloc] initWithRootViewController:vc4]];
     self.window.rootViewController = [[YangRootNavigationController alloc] initWithRootViewControllerNoWrapping:tabController];
 *  普通场景：
 
 *
 */
@interface YangContainerNavigationController : UINavigationController
@end


/*!
 *  @class YangRootNavigationController
 *  @superclass UINavigationController
 *  @coclass YangContainerController
 *  @coclass YangContainerNavigationController
 */
IB_DESIGNABLE
@interface YangRootNavigationController : UINavigationController

/*!
 *  @brief use system original back bar item or custom back bar item returned by
 *  @c -(UIBarButtonItem*)customBackItemWithTarget:action: , default is NO
 *  @warning Set this to @b YES will @b INCREASE memory usage!
 */
@property (nonatomic, assign) IBInspectable BOOL useSystemBackBarButtonItem;

/// Weather each individual navigation bar uses the visual style of root navigation bar. Default is @b NO
@property (nonatomic, assign) IBInspectable BOOL transferNavigationBarAttributes;

/*!
 *  @brief use this property instead of @c visibleViewController to get the current visiable content view controller
 */
@property (nonatomic, readonly, strong) UIViewController *yang_visibleViewController;

/*!
 *  @brief use this property instead of @c topViewController to get the content view controller on the stack top
 */
@property (nonatomic, readonly, strong) UIViewController *yang_topViewController;

/*!
 *  @brief use this property to get all the content view controllers;
 */
@property (nonatomic, readonly, strong) NSArray <__kindof UIViewController *> *yang_viewControllers;

/**
 *  Init with a root view controller without wrapping into a navigation controller
 *
 *  @param rootViewController The root view controller
 *
 *  @return new instance
 */
- (instancetype)initWithRootViewControllerNoWrapping:(UIViewController *)rootViewController;

/*!
 *  @brief Remove a content view controller from the stack
 *
 *  @param controller the content view controller
 */
- (void)removeViewController:(UIViewController *)controller NS_REQUIRES_SUPER;
- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag NS_REQUIRES_SUPER;

/*!
 *  @brief Push 到指定控制器
 *
 *  @param viewController 新控制器
 *  @param animated       是否使用动画转场
 *  @param block          转场完成回调
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  complete:(void(^)(BOOL finished))block;

/*!
 *  @brief Pop 掉当前控制器
 *
 *  @param animated       是否使用动画转场
 *  @param block          转场完成回调
 *
 *  @return The current UIViewControllers(content controller) poped from the stack
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated complete:(void(^)(BOOL finished))block;

/*!
 *  @brief Pop 到导航中指定控制器
 *
 *  @param viewController 控制器
 *  @param animated       是否使用动画转场
 *  @param block          转场完成回调
 *
 *  @return A array of UIViewControllers(content controller) poped from the stack
 */
- (NSArray <__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                      animated:(BOOL)animated
                                                      complete:(void(^)(BOOL finished))block;

/*!
 *  @brief Pop 回根控制器
 *
 *  @param animated 是否使用动画转场
 *  @param block    转场完成回调
 *
 *  @return A array of UIViewControllers(content controller) poped from the stack
 */
- (NSArray <__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
                                                                  complete:(void(^)(BOOL finished))block;
@end
