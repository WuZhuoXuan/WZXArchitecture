//
//  AppDelegate+WZX.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/24.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "AppDelegate+WZX.h"
#import "JLRoutes.h"
#import "WZXTabBarController.h"
#import "WZXNavigationController.h"
#import "WZXHomeViewController.h"
#import "WZXFindViewController.h"
#import "WZXCircleFriendsViewController.h"
#import "WZXAccountViewController.h"
@implementation AppDelegate (WZX)

- (void)registerRoutes{
    
    
    WZXTabBarController *rootVC = [WZXTabBarController  tabBarControllerWithAddChildVCsBlock:^(WZXTabBarController *tabBarC) {
        
        [tabBarC addChildVC:[WZXHomeViewController new] title:@"主页" normalImageName:@"tabar_zhuye2.png" selectedImageName:@"tabar_zhuye.png" isRequiredNavController:YES];
        [tabBarC addChildVC:[WZXCircleFriendsViewController new] title:@"主页2" normalImageName:@"tabar_tuijian2.png" selectedImageName:@"tabar_tuijiani.png" isRequiredNavController:YES];
        [tabBarC addChildVC:[WZXHomeViewController new] title:@"中间按钮" normalImageName:@"tabar_suishoupai2.png" selectedImageName:@"tabar_suishoupai.png" isRequiredNavController:YES];
        [tabBarC addChildVC:[WZXFindViewController new] title:@"朋友" normalImageName:@"tabar_linxin2.png" selectedImageName:@"tabar_linxin.png" isRequiredNavController:YES];
        [tabBarC addChildVC:[WZXAccountViewController new] title:@"我的" normalImageName:@"tabar_geren2.png" selectedImageName:@"tabar_geren.png" isRequiredNavController:YES];
        
    }];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    // navigation Push规则
    [[JLRoutes globalRoutes] addRoute:@"/NaviPush/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        NSLog(@"parameters==%@",parameters);
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [[self currentViewController] pushViewController:v animated:YES];
        return YES;
    }];
    
    
    // 模态窗口规则
    [[JLRoutes globalRoutes] addRoute:@"/PresentModal/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        NSLog(@"parameters==%@",parameters);
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [[self currentViewController].visibleViewController presentViewController:v animated:YES completion:^{}];
        return YES;
    }];
}

-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

/**
 *          获取当前控制器
 */
-(UINavigationController *)currentViewController{
    
    WZXTabBarController *WZXTabBar = (WZXTabBarController *)self.window.rootViewController;
    return WZXTabBar.selectedViewController;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", options[UIApplicationOpenURLOptionsSourceApplicationKey]);
    NSLog(@"URL scheme:%@", [url scheme]);
    
#pragma mark - JLRoutes（默认的Scheme）
    
    return [[JLRoutes globalRoutes] routeURL:url];
}



@end
