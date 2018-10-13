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

@end
