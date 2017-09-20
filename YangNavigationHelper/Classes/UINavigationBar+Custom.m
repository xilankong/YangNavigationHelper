//
//  UINavigationBar+JFZCustom.m
//  Pods
//
//  Created by lben on 6/15/16.
//
//

#import "UINavigationBar+Custom.h"
#import "YangNavigationHelper.h"
#import <objc/runtime.h>

NSInteger const kCATCustomExcludeAlphaTag = 999012;

@implementation UIImage (JFZCustom)

+ (UIImage *)at_imageWithColor:(UIColor *)color withSize:(CGSize)size
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

@implementation UINavigationBar (JFZCustom)
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


- (void)at_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        CGFloat topMargin = IS_IPHONE_X() ? 44 : 20;
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + topMargin)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight` !!! ???
        self.backgroundColor = backgroundColor;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)at_undo
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

- (void)at_setBottomLineColor:(UIColor *)color
{
    if (self.overlayLine) {
        self.overlayLine.backgroundColor = color;
    } else {
        if (self.overlay) {
            CGFloat topMargin = IS_IPHONE_X() ? 44 : 20;
            self.overlayLine = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) + topMargin) - 1.0 / [UIScreen mainScreen].scale , CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
            self.overlayLine.userInteractionEnabled = NO;
            
            [self.overlay addSubview:self.overlayLine];
            self.overlayLine.backgroundColor = color;
        } else {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.shadowImage = [UIImage new];
            UIImage *line = [UIImage at_imageWithColor:color withSize:CGSizeMake(CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
            [self setShadowImage:line];
        }
    }
}

- (UIView *)_findUIBarBackgroundIn:(UIView *)father {
 
    for (UIView *v in father.subviews) {
        if ([v isKindOfClass: NSClassFromString(@"_UIBarBackground")]) {
            return v;
        }
    }
    return nil;
}

#pragma mark - privates methods
- (void)_setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *v in view.subviews) {
		
        if ([v isKindOfClass: NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            continue;
        } else if (v.tag == kCATCustomExcludeAlphaTag) {
            continue;
        } else if ([v isKindOfClass: NSClassFromString(@"UINavigationItemButtonView")]) {
            continue;
        } else if ([v isKindOfClass: NSClassFromString(@"UINavigationItemView")]) {
            continue;
        } else if ([v isKindOfClass: NSClassFromString(@"_UIButtonBarStackView")]) {
//            [self _setAlpha:alpha forSubviewsOfView:v];
            continue;
        } else if ([v isKindOfClass: NSClassFromString(@"_UINavigationBarContentView")]) {
            [self _setAlpha:alpha forSubviewsOfView:v];
            continue;
        } else if ([v isKindOfClass: NSClassFromString(@"_UIBarBackground")]) {
            [self _setAlpha:alpha forSubviewsOfView:v];
            continue;
        }

        v.alpha = alpha;

        [self _setAlpha:alpha forSubviewsOfView:v];
    }
}

@end
