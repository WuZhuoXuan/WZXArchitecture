//
//  WZXAccountViewController.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/25.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "WZXAccountViewController.h"
#import "WZXAccountViewModel.h"

@interface WZXAccountViewController ()

@end

@implementation WZXAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn setTitle:@"点击按钮网络请求，请求完路由跳转页面" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    clickBtn.sd_layout
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .topSpaceToView(self.view, 100)
    .heightIs(50);
    
    
    
}


- (void)click{
    
    // 发送请求
    RACSignal *signal = [[[WZXAccountViewModel alloc]init].requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        NSString *customURL = @"WZXArchitecture://NaviPush/TwoViewController?userId=88888&age=18";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
