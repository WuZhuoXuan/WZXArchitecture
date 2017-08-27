//
//  Utils.m
//  RomanticAppiontment
//
//  Created by MacBook on 15/3/20.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

//小写验证码
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        //        [ret appendFormat:@"%02x",result[i]];
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

//大写验证码
+ (NSString *)MD5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        //        [ret appendFormat:@"%02x",result[i]];
        [ret appendFormat:@"%02X",result[i]];
    }
    
    return ret;
}


#pragma mark-md5加密


//16位MD5加密方式   大写

+(NSString *)md5sss:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[16];
    
    
    
    //    CC_MD5( cStr, strlen(cStr), result );
    
    //这是xcode更新后，类型上的一个写法
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    
    
    return [NSString stringWithFormat:
            
            
            
            @"%X%X%X%X%X%X%X%X",
            
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11]];
    
    
    
    //            result[0],result[1],result[2],result[3],
    //
    //            result[4],result[5],result[6],result[7],
    //
    //            result[8],result[9],result[10],result[11],
    //
    //            result[12],result[13],result[14],result[15],
    //
    //            result[16], result[17],result[18], result[19],
    //
    //            result[20], result[21],result[22], result[23],
    //
    //            result[24], result[25],result[26], result[27],
    //
    //            result[28], result[29],result[30], result[31]];
    
}


//32位MD5加密方式   大写

+(NSString *)md5sssLiu:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[16];
    
    
    
    //    CC_MD5( cStr, strlen(cStr), result );
    
    //这是xcode更新后，类型上的一个写法
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    
    
    return [NSString stringWithFormat:
            
            
            
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
    
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
    
    
    

    
}


#pragma mark - 身份证识别
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}


@end
