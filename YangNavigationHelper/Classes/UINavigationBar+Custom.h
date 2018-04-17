//
//  UINavigationBar+Custom.h
//  Pods
//
//  Created by yanghuang on 6/15/16.
//
//

#import <UIKit/UIKit.h>

//导航栏中不需要隐藏的UI元素设置tag
OBJC_EXTERN NSInteger const kCATCustomExcludeAlphaTag;

@interface UIImage (Custom)

+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end

@interface UINavigationBar (Custom)

//设置背景色
- (void)at_setBackgroundColor:(UIColor *)backgroundColor;
//设置底部边线颜色
- (void)at_setBottomLineColor:(UIColor *)color;
//还原
- (void)at_undo;

@end
