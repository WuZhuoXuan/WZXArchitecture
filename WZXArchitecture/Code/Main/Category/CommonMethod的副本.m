//
//  CommonMethod.m
//  EasyHomePocket
//
//  Created by 易家口袋 on 2017/1/12.
//  Copyright © 2017年 易家口袋. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod
{
    UIImage *image;
}
//导航栏
+(void)setNavigationBarAttribute:(UINavigationController *)navigationController andNavigationItem:(UINavigationItem *)navigationItem{
    //设置navigationBar的title的字体大小和颜色
    [navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:kFont(17),NSForegroundColorAttributeName:kNavigationBarColor}];
    //设置导航栏的背景色
    navigationController.navigationBar.translucent = NO;
    [navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //设置返回按钮的字体颜色
    [navigationController.navigationBar setTintColor:kNavigationBarColor];
    //设置返回按钮文字
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]init];
    barButtonItem.title=@"";
    navigationItem.backBarButtonItem=barButtonItem;
}

//获取Storyboard中的视图
+ (id) getStoryboardInstanceByIdentity:(NSString*) identity
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identity];
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(UIButton *)createButtonTitle:(NSString *)title{
    UIButton *button=[[UIButton alloc]init];
    button.layer.cornerRadius=5;
    button.titleLabel.font=kFont(15);
    button.backgroundColor=kNavigationBarColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kRGB(255, 255, 255) forState:UIControlStateNormal];
    return button;
}

//去掉导航条下边的系统线条
+(UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

//给cell添加线条
+(UIView *)addCellLine:(CGRect)frame{
    UIView *line=[[UIView alloc]initWithFrame:frame];
    line.backgroundColor=kRGB(214, 214, 214);
    return line;
}

//修改头像大小
+(UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

//当前时间
-(NSString *)timestampToDetailTime:(NSDate *)date timeFormat:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:string];
    //时间戳转时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    dateFormatter=nil;
    return currentDateStr;
}

//获取lable高度
+(CGSize)getLabelSizeWithLabelMaxWidth:(float)width MaxHeight:(float)height FontSize:(UIFont *)font LabelText:(NSString *)labelText{
    CGSize fSize;
    CGSize size =CGSizeMake(width ,height);
    fSize = [labelText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    return fSize ;
}

#pragma mark - tap show Image
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    NSDictionary *dict=@{@"X":@(oldframe.origin.x),@"Y":@(oldframe.origin.y),@"W":@(oldframe.size.width),@"H":@(oldframe.size.height)};
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OldFrame"];
    //
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        NSDictionary *dict=[[NSUserDefaults standardUserDefaults] objectForKey:@"OldFrame"];
        imageView.frame=CGRectMake([dict[@"X"] floatValue], [dict[@"Y"] floatValue], [dict[@"W"] floatValue], [dict[@"H"] floatValue]);
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

+(UIAlertController *)alertControllerAction:(NSString *)string andNavigationController:(UINavigationController *)navigationController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:string preferredStyle:UIAlertControllerStyleAlert];
    //创建取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (navigationController) {
            [navigationController popViewControllerAnimated:YES];
        }
    }];
    //添加按钮
    [alert addAction:action1];
    //显示
    return alert;
}

//jisuan cell height
+(CGFloat)calculateCellHeight:(NSString *)string andFont:(UIFont *)font{
    CGSize sizes=[self getLabelSizeWithLabelMaxWidth:kScreenWidth-kCGFloat(20)-kCGFloat(18)-kCGFloat(20)-kCGFloat(20) MaxHeight:MAXFLOAT FontSize:font LabelText:string];
    if (sizes.height>kCGFloat(30)) {
        return sizes.height+kCGFloat(20);
    }
    return kCGFloat(50);
}
//去表情去空格
+ (BOOL)disable_emoji:(NSString *)text{
    int a=(int)text.length;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    if (a>(int)modifiedString.length) {
        return YES;
    }
    return NO;
}
//拼接省市区地址
+(NSString *)getAddress:(NSString *)province andCity:(NSString *)city andZone:(NSString *)zone andAddress:(NSString *)address{
    if ([province isEqualToString:city]) {
        if (![zone isEqualToString:@"其他"]) {
            province=[province stringByAppendingString:[NSString stringWithFormat:@" %@",zone]];
        }
    }
    else{
        province=[province stringByAppendingString:[NSString stringWithFormat:@" %@",city]];
        if (![zone isEqualToString:@"其他"]) {
            province=[province stringByAppendingString:[NSString stringWithFormat:@" %@",zone]];
        }
    }
    province = [province stringByAppendingString:[NSString stringWithFormat:@" %@",address]];
    return province;
}
//截取图片的某一部分
+ (UIImage *)clipImage:(UIImage *)image andInRect:(CGRect)rect{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    CGImageRef cgRef = image.CGImage;
    CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef,dianRect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}
//图片自适应高度
+(CGFloat)imageAdaptive:(NSString *)URL{
    __block CGFloat imageW = kScreenWidth;
    __block CGFloat imageH = 0;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *url=[manager cacheKeyForURL:[NSURL URLWithString:URL]];
    UIImage *image;
    if (url.length>0) {
        //判断是否有缓存
        image = [[manager imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:URL].absoluteString];
    }
    else{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        image = [UIImage imageWithData:data];
    }
    //根据image的比例来设置高度
    if (image.size.width) {
        imageH = image.size.height / image.size.width * imageW;
    }
    return imageH;
}

//设置Label的行间距和字间距
+(NSDictionary *)getDictLabelLineSpace:(CGFloat)lineSpace withFont:(UIFont*)font withWordSpace:(NSNumber *)wordSpace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:wordSpace};
    return dic;
}

//保存登录信息
+(void)saveLoginInfomation:(NSDictionary *)dictionary{
    SetDefaults(@"NickName", dictionary[@"nickName"]);
    SetDefaults(@"HeadImageURL",dictionary[@"icon"]);
    SetDefaults(@"Point", dictionary[@"sorce"]);
    SetDefaults(@"UserId",dictionary[@"id"]);
    //SetDefaults(@"UID",dictionary[@"uid"]);
    SetDefaults(@"IsSign",dictionary[@"isSign"]);
    //省市区
    SetDefaults(@"ProvinceID",dictionary[@"proid"]);
    SetDefaults(@"CityID",dictionary[@"cityid"]);
    SetDefaults(@"AreaID",dictionary[@"areaid"]);
    //具体地址
    NSString *address=[NSString stringWithFormat:@"%@%@%@%@",dictionary[@"proid"][@"name"],dictionary[@"cityid"][@"name"],dictionary[@"areaid"][@"name"],dictionary[@"addr"]];
    SetDefaults(@"Address",address);
    //星座性别（1男2女）
    SetDefaults(@"Constellation", dictionary[@"constellation"]);
    SetDefaults(@"Sex",@"男");
    if ([dictionary[@"sex"] intValue]!=1) {
        SetDefaults(@"Sex",@"女");
    }
    //生日
    NSString *birthday=[NSString stringWithFormat:@"%@年%@月%@日",dictionary[@"year"],dictionary[@"month"],dictionary[@"day"]];
    SetDefaults(@"Birthday",birthday);
}

+(NSMutableArray *)photoList:(NSString *)string{
    NSMutableArray *mulPreview=[[NSMutableArray alloc]init];
    if (![string isEqual:[NSNull null]]){
        NSArray *imags = [string componentsSeparatedByString:@","];
        for (int i=0; i<imags.count; i++) {
            if (![imags[i] isEqualToString:@""]) {
                [mulPreview addObject:imags[i]];
            }
        }
    }
    return mulPreview;
}
//压缩图片到指定大小
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    NSLog(@"当前大小:%fkb",(float)[data length]/1024.0f);
    return resultImage;
}

//压缩图片到指定大小
+ (NSData *)compressData:(UIImage *)image toByte:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    NSLog(@"当前大小:%fkb",(float)[data length]/1024.0f);
    return data;
}

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc{
    if (phoneStr.length >= 10) {
        NSString *str2 = [[UIDevice currentDevice] systemVersion];
        if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
        {
            NSString* PhoneStr = [NSString stringWithFormat:@"telprompt://%@",phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"phone success");
            }];
            
        }else {
            NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
            if (phoneStr.length == 10) {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
            }else {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
            }
            NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
            // 设置popover指向的item
            alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
            // 添加按钮
            [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                NSLog(@"点击了呼叫按钮10.2下");
                NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
                if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                        //[app openURL:[NSURL URLWithString:PhoneStr]];
                        [app openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                            
                        }];
                    }
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }]];
            [selfvc presentViewController:alert animated:YES completion:nil];
        }
    }
}

+(NSString *)md5EncryptionString:(NSDictionary *)dict{
    //判空
    if ([dict count]==0) {
        return NULL;
    }
    //键值对排序
    NSArray *jsonKey = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //键值对拼接
    NSString *string=@"";
    for (int i=0; i<jsonKey.count; i++) {
        if (![dict[jsonKey[i]] isEqualToString:@""] && ![dict[jsonKey[i]] isEqual:[NSNull null]] ) {
            NSString *str=[NSString stringWithFormat:@"%@=%@&",jsonKey[i],dict[jsonKey[i]]];
            string=[string stringByAppendingString:str];
        }
    }
    //加密前拼接字符串
    string=[string substringToIndex:string.length-1];
    //返回加密前字符串
    return string;
}

//md5加密
+(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
