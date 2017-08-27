//
//  CheckMethod.m
//  RomanticAppiontment
//
//  Created by baichun on 15-2-10.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "CheckMethod.h"

@implementation CheckMethod


//验证手机
+ (BOOL) validateMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (mobile.length != 11)
        
    {
        
        return NO;
        
    }else{
        
     
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
         * 电信号段: 133,134,153,170,177,180,181,189
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         */
        NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,145,152,155,156,170,171,176,185,186
         */
        NSString *CU = @"^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,134,153,170,177,180,181,189
         */
        NSString *CT = @"^1(3[34]|53|7[07]|8[019])\\d{8}$";
        
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:mobile] == YES)
            || ([regextestcm evaluateWithObject:mobile] == YES)
            || ([regextestct evaluateWithObject:mobile] == YES)
            || ([regextestcu evaluateWithObject:mobile] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
}




//验证邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)validatePassword:(NSString *)passwordStr{
    if ([passwordStr length]<6) {
        return NO;
    }
    
    if ([passwordStr length]>20) {
        return NO;
    }
    return YES;
}

@end
