//
//  UIImage+CosmosExtension.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/11/14.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "UIImage+CosmosExtension.h"


@implementation UIImage (CosmosExtension)
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return resultImage;
}

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius{
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // 绘制图片
    [self drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
   
}

@end
