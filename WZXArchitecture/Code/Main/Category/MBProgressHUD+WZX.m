//
//  MBProgressHUD+WZX.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/10.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "MBProgressHUD+WZX.h"

@implementation MBProgressHUD (WZX)


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = text;
    // 设置图标
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",icon]]];
    // 在设置模式
    hub.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hub.removeFromSuperViewOnHide = YES;
    // 1秒之后在消失
    [hub hideAnimated:YES afterDelay:0.7];
}





/**
 显示成功信息
 
 @param success 成功的信息
 */
+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}


/**
 显示成功信息

 @param success 信息内容
 @param view 显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}


/**
 显示错误信息
 
 @param error 错误信息
 */
+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

/**
 显示错误信息

 @param error 错误信息
 @param view 需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}


/**
 显示加载中,需手动关闭
 
 @param message 加载中文字
 */
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}


/**
 显示一些信息

 @param message 信息内容
 @param view 需要显示信息的视图
 @return 直接返回一个MBProgressHUD,需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if(view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个显示信息
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:nil];
    hub.label.text = message;
    // 隐藏时候从父控件
    hub.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hub.dimBackground = YES;
    return hub;
}



/**
 手动关闭MBPrgressHUD
 */
+ (void)hideHUD{
    [self hideHUDForView:nil];
}

/**
 手动关闭MBProgressHUD

 @param view 显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view{
    if(view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}



@end
