//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)
static char overlayKey;
static char overlayLineKey;

//颜色覆盖层
- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//底线
- (UIView *)overlayLine
{
    return objc_getAssociatedObject(self, &overlayLineKey);
}

- (void)setOverlayLine:(UIView *)overlayLine
{
    objc_setAssociatedObject(self, &overlayLineKey, overlayLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight` !!! ???
        
        self.overlayLine = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) + 20) - 1.0 / [UIScreen mainScreen].scale , CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
        self.overlayLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.overlayLine.userInteractionEnabled = NO;
        
        [self.overlay addSubview:self.overlayLine];
        
        UIView *backgroundView = [self.subviews firstObject];
        [backgroundView insertSubview:self.overlay atIndex:0];
        //用于适配 lt_setTranslationY  存在问题
//        NSLayoutConstraint *constraint_left = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//        NSLayoutConstraint *constraint_right = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//        NSLayoutConstraint *constraint_top = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *constraint_bottom = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        [backgroundView addConstraints:@[constraint_left,constraint_right,constraint_top,constraint_bottom]];
//        
//        self.overlayLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//        NSLayoutConstraint *line_constraint_left = [NSLayoutConstraint constraintWithItem:self.overlayLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.overlay attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//        NSLayoutConstraint *line_constraint_right = [NSLayoutConstraint constraintWithItem:self.overlayLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.overlay attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//        NSLayoutConstraint *line_constraint_bottom = [NSLayoutConstraint constraintWithItem:self.overlayLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.overlay attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        NSLayoutConstraint *line_constraint_height = [NSLayoutConstraint constraintWithItem:self.overlayLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.overlay attribute:NSLayoutAttributeHeight multiplier:1.0 constant: 1.0 / [UIScreen mainScreen].scale];
//        [self.overlay addConstraints:@[line_constraint_left,line_constraint_right,line_constraint_bottom,line_constraint_height]];
    }
    self.overlay.backgroundColor = backgroundColor;
}
- (void)lt_setLineColor:(UIColor *)color {
    if (self.overlayLine) {
        self.overlayLine.backgroundColor = color;
    }
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
    
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
