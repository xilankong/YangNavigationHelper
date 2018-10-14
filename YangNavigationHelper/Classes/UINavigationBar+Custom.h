//
//  UINavigationBar+Custom.h
//  Pods
//
//  Created by yanghuang on 6/15/16.
//
//

#import <UIKit/UIKit.h>

//导航栏中不需要隐藏的UI元素设置tag
OBJC_EXTERN NSInteger const yangOverLayerTag;

@interface UIImage (Custom)


/**
 生成色值图片

 @param color 色值
 @param size 大小
 @return 图片
 */
+ (UIImage *)yang_imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end

@interface UINavigationBar (Custom)

/**
 设置背景色
 @param backgroundColor 色值
 */
- (void)yang_setBackgroundColor:(UIColor *)backgroundColor;

/**
 设置shadow线颜色
 @param color 色值
 */
- (void)yang_setBottomLineColor:(UIColor *)color;

/**
 还原导航条
 */
- (void)yang_reset;

@end
