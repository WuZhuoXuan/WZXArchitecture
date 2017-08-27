//
//  LoginVC.m
//  YangGuangZaoCan
//
//  Created by small路飞nj on 16/4/28.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import "LoginVC.h"
#import "Utils.h"

@interface LoginVC ()

@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *password;

@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登陆";
    
    
    // 设置背景图片
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bg];
    
    bg.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    
    // 设置logo

    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logo];
    
    logo.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,100)
    .heightIs(60)
    .widthIs(80);
    
    
    /**
     *  用户名
     */
    UIImageView *UsernameImage  = [[UIImageView alloc]init];
    UsernameImage.image = [UIImage imageNamed:@"yongh"];
    [self.view addSubview:UsernameImage];
    
    
    self.userName = [[UITextField alloc]init];
    self.userName.placeholder = @"用户名";
    [self.userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.userName.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.userName];
    
    
    
    UsernameImage.sd_layout
    .leftSpaceToView(self.view,40)
    .widthIs(23)
    .topSpaceToView(logo,70)
    .heightIs(30);
    
    self.userName.sd_layout
    .leftSpaceToView(UsernameImage,10)
    .rightSpaceToView(self.view,40)
    .topEqualToView(UsernameImage)
    .heightIs(30);
    
    
    UIView *UserView = [[UIView alloc]init];
    UserView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:UserView];
    
    
    UserView.sd_layout
    .leftEqualToView(UsernameImage)
    .rightEqualToView(self.userName)
    .topSpaceToView(UsernameImage,3)
    .heightIs(1);
    
    
    
    /**
     *  密码
     */
    
    UIImageView *passwodeImage = [[UIImageView alloc]init];
    passwodeImage.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:passwodeImage];
    
    
    self.password = [[UITextField alloc]init];
    self.password.placeholder = @"密码";
    [self.password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.password.textColor = [UIColor whiteColor];
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
    
    passwodeImage.sd_layout
    .leftEqualToView(UsernameImage)
    .widthIs(23)
    .topSpaceToView(UserView,20)
    .heightIs(30);
    
    
    self.password.sd_layout
    .leftEqualToView(self.userName)
    .rightEqualToView(self.userName)
    .topEqualToView(passwodeImage)
    .heightIs(30);
    
    
    
    UIView *xianview2 = [[UIView alloc]init];
    xianview2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xianview2];
    
    
    xianview2.sd_layout
    .leftEqualToView(UserView)
    .rightEqualToView(UserView)
    .topSpaceToView(passwodeImage,3)
    .heightIs(1);
    
    
    

    
    
    // 登陆按钮
    UIButton *login = [[UIButton alloc]init];
    [login setTitle:@"登陆" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [login setBackgroundImage:[UIImage imageNamed:@"denglu"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    login.sd_layout
    .leftSpaceToView(self.view,35)
    .rightSpaceToView(self.view,35)
    .topSpaceToView(xianview2,50)
    .heightIs(40);
    
    
    
    
    
    
    

    // 注册按钮
    UIButton *regist = [[UIButton alloc]init];

    [regist setTitle:@"注册" forState:UIControlStateNormal];
    [regist setTitleColor:[UIColor colorWithRed:0.6941 green:0.6745 blue:0.6745 alpha:1.0] forState:UIControlStateNormal];
 
    [regist setBackgroundImage:[UIImage imageNamed:@"zhuce"] forState:UIControlStateNormal];
    [regist addTarget:self action:@selector(pressRegist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
    
    regist.sd_layout
    .leftEqualToView(login)
    .rightEqualToView(login)
    .topSpaceToView(login,10)
    .heightIs(40);
    
    
    
   
    // 自动登陆按钮
    UIButton *autoLogin = [[UIButton alloc]init];

    [autoLogin setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
    [autoLogin setImage:[UIImage imageNamed:@"quan2"] forState:UIControlStateSelected];
    [autoLogin setTitle:@"自动登录" forState:UIControlStateNormal];
    [autoLogin setTitle:@"自动登录" forState:UIControlStateSelected];
    [autoLogin setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0f] forState:UIControlStateNormal];
    [autoLogin setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0f] forState:UIControlStateSelected];
    [autoLogin addTarget:self action:@selector(pressAutoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoLogin];
    
    autoLogin.sd_layout
    .topSpaceToView(regist, 20)
    .leftEqualToView(regist)
    .heightIs(20)
    .widthIs(90);
    
    
    
    
    // 忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0f] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(pressForget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    forgetBtn.sd_layout
    .topSpaceToView(regist, 20)
    .rightEqualToView(regist)
    .widthIs(80)
    .heightIs(20);
    
    NSFileManager *mgr=[[NSFileManager alloc]init];
    
    if ([mgr fileExistsAtPath:[KPathDocument stringByAppendingPathComponent:@"UserName.plist"]])
    {
        NSDictionary *NameDict = [NSDictionary dictionaryWithContentsOfFile:[KPathDocument stringByAppendingPathComponent:@"UserName.plist"]];
        if([NameDict[@"select"] boolValue] == YES)
        {
            self.userName.text = NameDict[@"username"];
            self.password.text = NameDict[@"password"];
            
            self.select = YES;
            autoLogin.selected = YES;
            
        }else
        {
            self.userName.text = NameDict[@"username"];
            self.password.text = NameDict[@"password"];
            self.select = NO;
            autoLogin.selected = NO;
        }
        
        
        
    }

    
}



// 点击忘记密码按钮
- (void)pressForget
{

}

// 点击自动登陆按钮
- (void)pressAutoLogin:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    _select = !_select;
   
}


// 点击注册
- (void)pressRegist
{
    
}

// 点击登陆
- (void)pressLogin
{
 
    [self requestWithURL];
}

// 网络请求
- (void)requestWithURL
{
    [MBProgressHUD showMessage: @"登陆中"];
    NSDictionary *dic = @{
                          @"username": self.userName.text,
                          @"password": [Utils md5sssLiu:self.password.text]                          };
    
    __weak typeof(self) weakSelf = self;
    [WZXNetworking postWithUrl:[NSString stringWithFormat:@"%@user_login.ashx", KHttpUrl]  params:dic success:^(id response) {
         [MBProgressHUD hideHUD];
        if ([response[@"code"] intValue] == 0) {
           
            UserInfo *userinfo = [UserInfo mj_objectWithKeyValues:response];
            
            NSDictionary *dict = @{@"password":weakSelf.password.text,@"select":@(weakSelf.select),@"username":_userName.text,@"user_id":response[@"user_id"]};
            NSString *filename = [KPathDocument stringByAppendingPathComponent:@"UserName.plist"];
            [dict writeToFile:filename atomically:YES];
        
            
        }else
        {
            [MBProgressHUD showError:response[@"msg"]];
            NSFileManager *manager=[NSFileManager defaultManager];
            //文件路径
            NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"UserName.plist"];
            if ([manager removeItemAtPath:filepath error:nil]) {
                NSLog(@"文件删除成功");
            }
            
        }
    } fail:^(NSError *error) {
         [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
