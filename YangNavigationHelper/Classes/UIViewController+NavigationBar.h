//
//  UIViewController+RTNavigationBar.h
//  PersonalResume
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+Custom.h"
#import "RTRootNavigationController.h"
@interface UIViewController (NavigationBar)

IB_DESIGNABLE
/*!
 *  @brief use to control the statusBarStatus
 */
@property (nonatomic, assign) IBInspectable BOOL rt_lightContentBar;

@property (nonatomic, strong) UIButton *rt_backButton;
/**
 @brief use to change the total navBar color status
 
 @param style statusBarStatus
 */
- (void)rt_setNavigationStatusBarStatus:(UIStatusBarStyle)style;

/**
 @brief use to change the navigationBar backgroundColor
 
 @param color UIColor
 */
- (void)rt_setNavigationBackgroundColor:(UIColor *)color;


/**
 @brief use to change the navigationBar positionY
 
 @param positionY CGFloat
 */
- (void)rt_setNavigationTranslationY:(CGFloat)positionY;

/**
 @brief use to change the navigation alpha
 
 @param alpha CGFloat
 */
- (void)rt_setNavigationElementsAlpha:(CGFloat)alpha;

/**
 @brief use to change the bottomLineColor

 @param color bottomLineColor
 */
- (void)rt_setNavigationBottomLineColor:(UIColor *)color;

/**
 @brief reset
 */
- (void)rt_resetNavigation;


@end
