//
//  UINavigationBar+Custom.h
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Custom)
- (void)rt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)rt_setLineColor:(UIColor *)color;
- (void)rt_setElementsAlpha:(CGFloat)alpha;
- (void)rt_setTranslationY:(CGFloat)translationY;
- (void)rt_reset;
@end
