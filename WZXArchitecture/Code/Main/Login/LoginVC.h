//
//  LoginVC.h
//  YangGuangZaoCan
//
//  Created by small路飞nj on 16/4/28.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (assign, nonatomic) BOOL select;

+(void)requestWithUserInfo;
//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
@end
