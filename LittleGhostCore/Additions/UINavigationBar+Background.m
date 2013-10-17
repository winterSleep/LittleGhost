//
//  UINavigationBar+Background.m
//  DPScope
//
//  Created by gft  on 13-3-20.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import "UINavigationBar+Background.h"

@implementation UINavigationBar (Background)

#pragma mark -
#pragma mark 重载navigationBar的背景图片
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }else{
        [self insertSubview:[[[UIImageView alloc] initWithImage:backgroundImage] autorelease] atIndex:1];
        [self drawRoundCorner];
    }
    
}

- (void)drawRoundCorner{
    CGRect bounds = self.bounds;
    bounds.size.height +=10;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
}

@end
