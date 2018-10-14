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

NSInteger const yangOverLayerTag = 999012;

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

static char overlayerKey;
static char overlayerLineKey;

//颜色覆盖层
- (UIView *)overlayer {
    return objc_getAssociatedObject(self, &overlayerKey);
}

- (void)setOverlayer:(UIView *)overlayer {
    objc_setAssociatedObject(self, &overlayerKey, overlayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//底线
- (UIView *)overlayerLine {
    return objc_getAssociatedObject(self, &overlayerLineKey);
}

- (void)setOverlayerLine:(UIView *)overlayerLine {
    objc_setAssociatedObject(self, &overlayerLineKey, overlayerLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yang_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlayer && [self.overlayer superview] != nil) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        CGFloat topMargin = 20.0;
        if (YangHelper.hasSafeArea) { topMargin = 44; }
        self.overlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + topMargin)];
        self.overlayer.tag = yangOverLayerTag;
        self.overlayer.userInteractionEnabled = NO;
        self.overlayer.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight` !!! ???
//        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [[self.subviews firstObject] insertSubview:self.overlayer atIndex:0];
    } else {
       self.overlayer.backgroundColor = backgroundColor;
    }
    
}

- (void)yang_setBottomLineColor:(UIColor *)color
{
    if (self.overlayerLine) {
        self.overlayerLine.backgroundColor = color;
    } else {
        if (self.overlayer) {
            CGFloat topMargin = YangHelper.hasSafeArea ? 44 : 20;
            self.overlayerLine = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) + topMargin) - 1.0 / [UIScreen mainScreen].scale , CGRectGetWidth(self.bounds), 1.0 / [UIScreen mainScreen].scale)];
            self.overlayerLine.userInteractionEnabled = NO;
            [self.overlayer addSubview:self.overlayerLine];
            self.overlayerLine.backgroundColor = color;
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
    [self.overlayer removeFromSuperview];
    self.overlayer = nil;
}

@end
