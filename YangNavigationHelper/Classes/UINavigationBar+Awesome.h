//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setLineColor:(UIColor *)color;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
//不能和 lt_setBackgroundColor 一起在scroll环境用
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
