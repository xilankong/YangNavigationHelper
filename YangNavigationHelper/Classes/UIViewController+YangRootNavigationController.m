//
//  UIViewController+YangRootNavigationController.m
//  
//
//  Created by yanghuang on 2017/9/4.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UIViewController+YangRootNavigationController.h"
#import "YangRootNavigationController.h"
#import "YangNavigationHelper.h"
#import <objc/runtime.h>

#define textColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]
#define lineColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]

@implementation UIViewController (YangRootNavigationController)
@dynamic yang_disableInteractivePop;

-(void)setYang_disableInteractivePop:(BOOL)yang_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(yang_disableInteractivePop), @(yang_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yang_disableInteractivePop
{
    return [objc_getAssociatedObject(self, @selector(yang_disableInteractivePop)) boolValue];
}

- (Class)yang_navigationBarClass
{
    return nil;
}

- (YangRootNavigationController *)yang_navigationController
{
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[YangRootNavigationController class]]) {
        vc = vc.navigationController;
    }
    return (YangRootNavigationController *)vc;
}

- (void)modalViewController:(UIViewController *)viewController needNavigation:(BOOL) navNeed sender:(id) sender {
    if (navNeed) {
        UIViewController *vc = [[YangRootNavigationController alloc]initWithRootViewController:viewController];
        [self showDetailViewController:vc sender:sender];
    } else {
        [self showDetailViewController:viewController sender:sender];
    }
}
@end


@implementation UIViewController (NavigationBar)

@dynamic yang_lightContentBar;
@dynamic yang_backButton;
@dynamic yang_hideBackButton;

- (void)setYang_lightContentBar:(BOOL)yang_lightContentBar {
    objc_setAssociatedObject(self, @selector(yang_lightContentBar), @(yang_lightContentBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yang_lightContentBar {
    return  [objc_getAssociatedObject(self, @selector(yang_lightContentBar)) boolValue];
}

- (void)setYang_backButton:(UIButton *)yang_backButton {
    objc_setAssociatedObject(self, @selector(yang_backButton), yang_backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIButton *)yang_backButton {
    return (UIButton *)objc_getAssociatedObject(self, @selector(yang_backButton));
}
-(void)setYang_hideBackButton:(BOOL)yang_hideBackButton
{
    objc_setAssociatedObject(self, "@selector(yang_hideBackButton)", @(yang_hideBackButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yang_hideBackButton
{
    return [objc_getAssociatedObject(self, "@selector(yang_hideBackButton)") boolValue];
}
//自定义返回按钮
- (UIBarButtonItem *)yang_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIButton *hisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hisButton.tag = kCATCustomExcludeAlphaTag;
    hisButton.frame = CGRectMake(0, 0, 25, 25);
    [hisButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
        [hisButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [hisButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    } else {
        [hisButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [hisButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    }
    [hisButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.yang_backButton = hisButton;
    return  [[UIBarButtonItem alloc]initWithCustomView:hisButton];
}

//控制状态栏
-(UIStatusBarStyle)preferredStatusBarStyle {
    if (self.yang_lightContentBar) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)yang_setNavigationBackgroundColor:(UIColor *)color {
    [self.navigationController.navigationBar at_setBackgroundColor:color];
}

- (void)yang_setNavigationBottomLineColor:(UIColor *)color {
    [self.navigationController.navigationBar at_setBottomLineColor:color];
}

#pragma mark 用于一些有透明头部的页面滑动时产生的statusBar色值影响的变更。

- (void)yang_setNavigationStatusBarStatus:(UIStatusBarStyle)style {
    if (style == self.preferredStatusBarStyle) {
        return;
    }
    if (style == UIStatusBarStyleDefault) {
        if (self.navigationController) {
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : textColor};
            self.yang_lightContentBar = NO;
            [self.navigationController.navigationBar at_setBottomLineColor:lineColor];
            if (self.yang_backButton) {
                [self.yang_backButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                [self.yang_backButton setImage:[UIImage imageNamed:@"blackarrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
            }
        }
    } else {
        if (self.navigationController) {
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor  whiteColor]};
            self.yang_lightContentBar = YES;
            [self.navigationController.navigationBar at_setBottomLineColor:[UIColor clearColor]];
            if (self.yang_backButton) {
                [self.yang_backButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                [self.yang_backButton setImage:[UIImage imageNamed:@"whitearrow" inBundle:navBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
            }
        }
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)yang_resetNavigation {
    [self.navigationController.navigationBar at_undo];
}

@end
