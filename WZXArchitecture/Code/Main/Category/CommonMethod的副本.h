//
//  CommonMethod.h
//  EasyHomePocket
//
//  Created by 易家口袋 on 2017/1/12.
//  Copyright © 2017年 易家口袋. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonMethod : NSObject
/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
//导航栏
+(void)setNavigationBarAttribute:(UINavigationController *)navigationController andNavigationItem:(UINavigationItem *)navigationItem;
//获取Storyboard中的视图
+ (id) getStoryboardInstanceByIdentity:(NSString*) identity;
+(UIButton *)createButtonTitle:(NSString *)title;
//去掉导航条下边的系统线条
+(UIImage *)createImageWithColor:(UIColor *)color;
//给cell添加线条
+(UIView *)addCellLine:(CGRect)frame;
//修改头像大小
+(UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize;
//当前时间
-(NSString *)timestampToDetailTime:(NSDate *)date timeFormat:(NSString *)string;

//获取lable高度
+(CGSize)getLabelSizeWithLabelMaxWidth:(float)width MaxHeight:(float)height FontSize:(UIFont *)font LabelText:(NSString *)labelText;
//放大图片
+(void)showImage:(UIImageView *)avatarImageView;
//缩小图片
+(void)hideImage:(UITapGestureRecognizer*)tap;
//帐号密码为空的提示
+(UIAlertController *)alertControllerAction:(NSString *)string andNavigationController:(UINavigationController *)navigationController;
//cellHeight
+(CGFloat)calculateCellHeight:(NSString *)string andFont:(UIFont *)font;
//去表情去空格
+ (BOOL)disable_emoji:(NSString *)text;
//拼接省市区地址
+(NSString *)getAddress:(NSString *)province andCity:(NSString *)city andZone:(NSString *)zone andAddress:(NSString *)address;
//截取图片的某一部分
+ (UIImage *)clipImage:(UIImage *)image andInRect:(CGRect)rect;
//图片自适应高度
+(CGFloat)imageAdaptive:(NSString *)URL;
//设置Label的行间距和字间距
+(NSDictionary *)getDictLabelLineSpace:(CGFloat)lineSpace withFont:(UIFont*)font withWordSpace:(NSNumber *)wordSpace;
//保存登录信息
+(void)saveLoginInfomation:(NSDictionary *)dictionary;
//判断图片列表
+(NSMutableArray *)photoList:(NSString *)string;
//压缩图片到指定大小返回图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
+ (NSData *)compressData:(UIImage *)image toByte:(NSUInteger)maxLength;
//
+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;
//md5加密
+(NSString *)md5EncryptionString:(NSDictionary *)dict;
+(NSString *)md5:(NSString *)str;
@end
