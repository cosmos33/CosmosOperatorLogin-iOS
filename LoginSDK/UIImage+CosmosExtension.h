//
//  UIImage+CosmosExtension.h
//  LoginSDK
//
//  Created by wangxuefei on 2019/11/14.
//  Copyright © 2019 MOMO. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CosmosExtension)

/** 生成纯色图片 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/** 生成圆角图片 */
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius;


@end

NS_ASSUME_NONNULL_END
