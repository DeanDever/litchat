//
//  DNEViewController.m
//  DNENetwork
//
//  Created by master_dean@163.com on 03/24/2021.
//  Copyright (c) 2021 master_dean@163.com. All rights reserved.
//

#import "DNEViewController.h"
#import <DNENetwork/DNENetwork.h>
#import "DNETestNetworkHanderl.h"

@interface DNEViewController ()

@end

@implementation DNEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    DNENetworkConfig *configuration = [[DNENetworkConfig alloc] init];
    configuration.consoleLog = NO;
    
#ifdef DEBUG
    configuration.serverString = @"http://api.gzshujiu.com";
#else
    configuration.serverString = @"https://api.zaky.mobi";
#endif
    
    NSDictionary *headers = @{
        @"udid": @"123123",
    };
    
    [configuration setHeaders:headers];
    //  设置header中网络状态的key
    configuration.networkStatusHeaderName = @"net";
    //  设置动态header
    [configuration observeDynamicHeadersBlock:^(id<DNENetworkAPIProtocol> api, NSDictionary<NSString *,id> *parameters) {

    
        return @{
            @"userid": @"751"
        };
    }];
    //  统一错误回调
    configuration.errorCallback = ^BOOL(id<DNENetworkAPIProtocol> _Nonnull api, NSError * _Nonnull error) {
        NSLog(@"Network Error:\nAPI:%@\nError:%@",api.APIString,error.localizedDescription);
        
        return true;
    };
    
    [DNENetworkManager updateConfiguration:configuration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [DNETestNetworkHanderl sendTestRequestWithHandler:self];
}
@end
