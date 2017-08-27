//
//  UserInfo.m
//  SingletonDemo
//
//  Created by Qiang on 15/6/18.
//  Copyright (c) 2015年 QiangTech. All rights reserved.
//

#import "UserInfo.h"

// 第一步 定义一个静态变量指针
static UserInfo *_instance = nil;

@implementation UserInfo

// 第二步 写一个得到单例对象的类方法
+ (UserInfo *)shareUserInfo
{
    @synchronized(self)//线程加锁
    {
        static dispatch_once_t onceToken ;
        dispatch_once(&onceToken, ^{
            _instance = [[super allocWithZone:NULL] init] ;
        }) ;
    }
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [UserInfo shareUserInfo] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [UserInfo shareUserInfo] ;
}



@end
