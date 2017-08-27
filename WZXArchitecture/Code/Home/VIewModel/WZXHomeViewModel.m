//
//  WZXHomeViewModel.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/25.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "WZXHomeViewModel.h"

@implementation WZXHomeViewModel

- (instancetype)init
{
    if(self = [super init])
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"传参=%@",input[@"code"]);
        // 创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            // 网络请求
            [MBProgressHUD showMessage:@"加载中.."];
            [WZXNetworking getWithUrl:[NSString stringWithFormat:@"%@index.ashx",KHttpUrl] success:^(id response) {
                
                [MBProgressHUD hideHUD];
                [subscriber sendNext:@"123"];
                
                
                
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"网络连接失败"];
                [subscriber sendNext:@"123"];
            }];
            
            return nil;
        }];
        
        
        
        
        return signal;
    }];
}



@end
