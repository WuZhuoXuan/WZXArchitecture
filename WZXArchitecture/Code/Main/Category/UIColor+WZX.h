//
//  UIColor+WZX.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/25.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WZX)

// #开头的六位十六进制数仅仅表示颜色
// 0x开头的数字表示包括颜色在内的一般数值。

// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithWzx:(long)hexColor;

// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithWzx:(long)hexColor alpha:(float)opacity;

// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)colorWithWzxString:(NSString *)color;

@end
