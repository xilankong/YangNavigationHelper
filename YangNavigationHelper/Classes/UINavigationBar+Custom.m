//
//  UINavigationBar+Custom.m
//  Pods
//
//  Created by yanghuang on 6/15/16.
//
//

#import "UINavigationBar+Custom.h"
#import "YangHelper.h"
#import <objc/runtime.h>

NSInteger const kCATCustomExcludeAlphaTag = 999012;

#pragma mark 颜色生成图片

@implementation UIImage (Custom)

+ (UIImage *)yang_imageWithColor:(UIColor *)color withSize:(CGSize)size
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

@implementation UINavigationBar (Custom)

static char overlayKey;
static char overlayLineKey;

//颜色覆盖层
- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//底线
- (UIView *)overlayLine {
    return objc_getAssociatedObject(self, &overlayLineKey);
}

- (void)setOverlayLine:(UIView *)overlayLine {
    objc_setAssociatedObject(self, &overlayLineKey, overlayLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yang_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        CGFloat topMargin = 20.0;
        if (YangHelper.hasSafeArea) { topMargin = 44; }
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + topMargin)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight` !!! ???
//        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)yang_setBottomLineColor:(UIColor *)color
{
    if (self.overlayLine) {
        self.overlayLine.backgroundColor = color;
    } else {
        if (self.overlay) {
            CGFloat topMargin = YangHelper.hasSafeArea ? 44 : 20;
            self.overlayLine = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) + topMargin) - 1.0 / [UIScreen mainScreen].scale , CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
            self.overlayLine.userInteractionEnabled = NO;
            
            [self.overlay addSubview:self.overlayLine];
            self.overlayLine.backgroundColor = color;
        } else {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.shadowImage = [UIImage new];
            UIImage *line = [UIImage yang_imageWithColor:color withSize:CGSizeMake(CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
            [self setShadowImage:line];
        }
    }
}

- (void)yang_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
