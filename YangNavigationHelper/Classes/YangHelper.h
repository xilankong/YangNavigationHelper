//
//  YangHelper.h
//  Pods-YangNavigationHelper_Example
//
//  Created by yanghuang on 2018/10/13.
//

#import <Foundation/Foundation.h>
#import "YangRootNavigationController.h"

#define navBundle [NSBundle bundleForClass:YangRootNavigationController.class]
#define nav_titleColor [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]
#define nav_lineColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]

@interface YangHelper: NSObject

+ (BOOL)hasSafeArea;

@end
