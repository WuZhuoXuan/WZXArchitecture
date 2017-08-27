//
//  UIImage+WZXGImage.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/10.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WZXGImage)

// 加载最原始的图片，没有渲染
+ (UIImage *)originImageWithName: (NSString *)name;

// 绘制圆角
- (void)WZX_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

@end
