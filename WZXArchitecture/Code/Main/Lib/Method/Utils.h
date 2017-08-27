//
//  Utils.h
//  RomanticAppiontment
//
//  Created by MacBook on 15/3/20.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/*小写加密*/
+ (NSString *)md5HexDigest:(NSString*)input;
/*大写加密*/
+ (NSString *)MD5HexDigest:(NSString*)input;

//16位MD5加密方式   大写
+(NSString *)md5sss:(NSString *)str;

//32位MD5加密方式   大写

+(NSString *)md5sssLiu:(NSString *)str;


#pragma mark - 身份证识别
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

@end
