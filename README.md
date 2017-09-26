
# 搭建app框架-MVVM+RAC+路由
### 项目的介绍
项目使用了ReactiveCocoa框架，实现了MVVM架构，使用MVVM架构主要目的是分离视图(View)和模型(Model)。

#### MVVM四大优点:
* 1. 低耦合。视图（View）可以独立于Model变化和修改，一个ViewModel可以绑定到不同的"View"上，当View变化的时候Model可以不变，当Model变化的时候View也可以不变。
* 2. 可重用性。你可以把一些视图逻辑放在一个ViewModel里面，让很多view重用这段视图逻辑。
* 3. 独立开发。开发人员可以专注于业务逻辑和数据的开发（ViewModel），设计人员可以专注于页面设计，使用Expression Blend可以很容易设计界面并生成xaml代码。
* 4. 可测试。界面素来是比较难于测试的，而现在测试可以针对ViewModel来写


##### 项目的搭建
* 1.搭建项目主框架

![](https://github.com/WuZhuoXuan/WZXArchitecture/blob/master/1.png)












* 2.CocoaPods集成的第三方框架
    * AFNetworking       网络请求
    * DateTools          日期的相对处理
    * JLRoutes           路由跳转
    * JPFPSStatus        显示屏幕的帧数
    * MBProgressHUD      蒙版
    * MJExtension        字典转模型框架
    * MJRefresh          界面刷新
    * MYLayout           浮动布局
    * ReactiveCocoa      函数响应式编程
    * SDAutoLayout       简单的布局
    * SDCycleScrollVIew  无限循环轮播图
    * SDWebImage         加载图片

* 3.初步搭建界面
 * 1.初始化项目
  
```
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
//    navigation Push规则
    [[JLRoutes globalRoutes] addRoute:@"/NaviPush/:controller" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        NSLog(@"parameters==%@",parameters);
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [[self currentViewController] pushViewController:v animated:YES];
        return YES;
    }];
}

```
  * 2.路由跳转

```
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
```
```

- (void)urlClick{
    
    // 发送请求
    RACSignal *signal = [[[WZXHomeViewModel alloc]init].requestCommand execute:@{@"code":@"Home"}];
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        NSString *customURL = @"WZXArchitecture://NaviPush/TwoViewController?name=home&userId=99999&age=18&adbc=29";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:customURL] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];        
    }];
}


```





  * 3.自定义Category
   * WZXNetworking       网络请求框架
   * UIView+Extension    控件frame的拓展 
   * MBProgressHUD+WZX   HUD网络提示
   * UIImage+WZXGImage   绘制圆角图片 
   * NSString+WZXString  字符串的加密和验证等
   * NSArray+WZX         防止数组Crash
   * NSDictionary+WZX    防止字典的部分操作Crash
   * UIColor+WZX         颜色十六进制转换UIColor

* 4.全局宏定义

```
//获取系统对象
#define KApplication        [UIApplication sharedApplication]
#define KAppWindow          [UIApplication sharedApplication].delegate.window
#define KAppDelegate        [AppDelegate shareAppDelegate]
#define KRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define KUserDefaults       [NSUserDefaults standardUserDefaults]
#define KNotificationCenter [NSNotificationCenter defaultCenter]

//获取当前语言
#define KCURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define KIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define KIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 屏幕高度
#define KAPPH [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define KAPPW [[UIScreen mainScreen] bounds].size.width

// 设置view的圆角边框
#define KLRViewBorderRadius(View, Radius, Width, Color)\\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//获取temp
#define KPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define KPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define KPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// RGB颜色
#define KColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// Label黑色
#define LableBlack [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]

// Label灰色
#define LableGray [UIColor colorWithRed: 120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0]

// 随机色
#define KRandomColor KColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//rgb颜色(十六进制)
#define KUIColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 


//字符串是否为空
#define KString_Is_Empty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define KArray_Is_Empty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define KDict_Is_Empty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define KObject_Is_Empty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//将对象转换成弱引用类型，有block时使用
#define WeakObj(obj) __block __weak typeof(obj) weak_##obj = obj
#define StrongObj(type) __strong typeof(type) type = weak##type;


//DEBUG模式下,打印日志(包括函数名、行号)
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define NLog(...)
#endif

/*距离顶部64*/
#define Top 64

//iOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)

//获取一段时间间隔
#define KStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define KEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//打印当前方法名
#define KITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// 网络地址
#define KHttpUrl @"http://wojia.dhcloud.cn/openapi/"
```

#### 最后，真的很希望各位大神指出不足的地方，能让大家共同进步！

#### 如果在使用过程中遇到BUG，希望你能Issues我，谢谢。 如果有更好的优化方法，希望你能Issues我，谢谢。



