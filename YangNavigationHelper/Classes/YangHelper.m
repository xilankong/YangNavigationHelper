//
//  YangHelper.m
//  Pods-YangNavigationHelper_Example
//
//  Created by yanghuang on 2018/10/13.
//

#import "YangHelper.h"

@implementation YangHelper

+ (BOOL)hasSafeArea {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 0;
    }
    return false;
}

+ (NSBundle *)navigationBundle {
    return [NSBundle bundleForClass:YangHelper.class];
}

+ (UIColor *)titleColor {
    return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
}

+ (UIColor *)lineColor {
    return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
}

@end
