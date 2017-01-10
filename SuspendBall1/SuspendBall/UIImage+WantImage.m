//
//  UIImage+WantImage.m
//  小蜜蜂邮包包
//
//  Created by 李昊泽 on 16/7/1.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import "UIImage+WantImage.h"

@implementation UIImage (WantImage)
- (UIImage *)getWantImageWithSize:(CGSize)wantSize
{
    UIGraphicsBeginImageContextWithOptions(wantSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, wantSize.width, wantSize.height)];
    UIImage *wantImage = UIGraphicsGetImageFromCurrentImageContext();
    return wantImage;
}
@end
