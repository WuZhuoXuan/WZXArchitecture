//
//  CheckMethod.h
//  RomanticAppiontment
//
//  Created by baichun on 15-2-10.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckMethod : NSObject
/*验证手机*/
+ (BOOL) validateMobile:(NSString *)mobile;

/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;
/*验证密码长度*/
+(BOOL)validatePassword:(NSString *)passwordStr;
@end
