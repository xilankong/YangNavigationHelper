//
//  UINavigationBar+Custom.m
//
//  Created by yanghuang on 2017/6/24.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "UINavigationBar+Custom.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Custom)
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

- (void)rt_setBackgroundColor:(UIColor *)backgroundColor
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
        self.backgroundColor = backgroundColor;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
- (void)rt_setLineColor:(UIColor *)color {
    if (self.overlayLine) {
        self.overlayLine.backgroundColor = color;
    } else {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        UIImage *line = [self rt_imageWithColor:color withSize:CGSizeMake(CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
        [self setShadowImage:line];
    }
}

- (void)rt_setTranslationY:(CGFloat)translationY
{
    /**
     _UIBarBackground属于动态部署,根据navigationBar的位置不一样，会自动做出调整
     目的: 我们需要把overlay插入_UIBarBackground 所以 _UIBarBackground需要按规律来变更frame
     key: _UIBarBackground.height +_UIBarBackground.y = 44（不管怎么变，这个值不会改）
     注意点: 当navigation刷新的时候 _UIBarBackground.height会进行frame上的变化,并且刷新后 _UIBarBackground的frame不再变成原样\不再根据navigationBar的translationY变化。
     解决: 根据当前 navigationBar 的y值 正负区分处理。保证 _UIBarBackground.height +_UIBarBackground.y = 44
     */
    
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
    CGFloat selfY = -(64 + translationY);
    
    UIView *barbg = [self.subviews firstObject];
    if (selfY > 0) {
        barbg.frame = CGRectMake(0, 0, barbg.frame.size.width,44);
    } else {
        barbg.frame = CGRectMake(0, 44 + selfY, barbg.frame.size.width,-selfY);
    }
    self.overlay.frame = CGRectMake(0, 0, self.frame.size.width,barbg.frame.size.height);
}

- (void)rt_setElementsAlpha:(CGFloat)alpha
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

- (void)rt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

- (UIImage *)rt_imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
