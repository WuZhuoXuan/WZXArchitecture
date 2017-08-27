//
//  NSString+WZXString.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/20.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WZXString)


/*小写加密*/
+ (NSString *)md5HexDigest:(NSString*)input;

/*大写加密*/
+ (NSString *)MD5HexDigest:(NSString*)input;

/*16位MD5加密方式   大写*/
+ (NSString *)md5sss:(NSString *)str;

/*32位MD5加密方式   大写*/
+ (NSString *)md5sssLiu:(NSString *)str;

/*验证身份证*/
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;

/*验证手机*/
+ (BOOL)validateMobile:(NSString *)mobile;

/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;

/*验证密码长度*/
+ (BOOL)validatePassword:(NSString *)passwordStr;

@end
