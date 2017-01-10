//
//  UIView+Extension.m
//  移动掌控
//
//  Created by Shuangwutech on 16/1/19.
//  Copyright © 2016年 Shuangwutech. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)lhz_width
{
    return self.frame.size.width;
}

- (CGFloat)lhz_height
{
    return self.frame.size.height;
}

- (void)setLhz_width:(CGFloat)lhz_width
{
    CGRect frame = self.frame;
    frame.size.width = lhz_width;
    self.frame = frame;
}

- (void)setLhz_height:(CGFloat)lhz_height
{
    CGRect frame = self.frame;
    frame.size.height = lhz_height; 
    self.frame = frame;
}


- (CGFloat)lhz_x
{
    return self.frame.origin.x;
}

- (void)setLhz_x:(CGFloat)lhz_x
{
    CGRect frame = self.frame;
    frame.origin.x = lhz_x;
    self.frame = frame;
}

- (CGFloat)lhz_y
{
    return self.frame.origin.y;
}

- (void)setLhz_y:(CGFloat)lhz_y
{
    CGRect frame = self.frame;
    frame.origin.y = lhz_y;
    self.frame = frame;
}

- (CGFloat)lhz_centerX
{
    return self.center.x;
}

- (void)setLhz_centerX:(CGFloat)lhz_centerX
{
    CGPoint center = self.center;
    center.x = lhz_centerX;
    self.center = center;
}


- (CGFloat)lhz_centerY
{
    return self.center.y;
}

- (void)setLhz_centerY:(CGFloat)lhz_centerY
{
    CGPoint center = self.center;
    center.y = lhz_centerY;
    self.center = center;
}


@end
