//
//  MBProgressHUD+WZX.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/10.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WZX)


/**
 显示成功信息

 @param success 成功的信息
 */
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;


/**
 显示错误信息

 @param error 错误信息
 */
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;


/**
 显示加载中

 @param message 加载中文字
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;



/**
 关闭
 */
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
