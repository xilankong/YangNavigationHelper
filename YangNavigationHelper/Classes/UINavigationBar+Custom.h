//
//  UINavigationBar+JFZCustom.h
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import <UIKit/UIKit.h>

//导航栏中不需要隐藏的UI元素设置tag
OBJC_EXTERN NSInteger const kCATCustomExcludeAlphaTag;

@interface UIImage (JFZCustom)

+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end

@interface UINavigationBar (JFZCustom)

- (void)at_setBackgroundColor:(UIColor *)backgroundColor;
- (void)at_setBottomLineColor:(UIColor *)color;
- (void)at_undo;

////

@end
