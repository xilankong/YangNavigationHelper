//
//  YangNavigationHelper.h
//  Pods
//
//  Created by yanghuang on 2017/7/3.
//
//

#ifndef YangNavigationHelper_h
#define YangNavigationHelper_h

#import "YangRootNavigationController.h"
#import "UIViewController+YangRootNavigationController.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationItem+Custom.h"

#define navBundle [NSBundle bundleForClass:YangRootNavigationController.class]
#define nav_titleColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]
#define nav_lineColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]
#define IS_IPHONE_X() (([UIScreen mainScreen].bounds.size.height == 812))


#endif /* YangNavigationHelper_h */
