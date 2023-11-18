//
//  DNETestNetworkHanderl.m
//  DNENetwork_Example
//
//  Created by 吴迪 on 2021/3/27.
//  Copyright © 2021 master_dean@163.com. All rights reserved.
//

#import "DNETestNetworkHanderl.h"
#import "DNETestAPI.h"

@implementation DNETestNetworkHanderl

+ (void)sendTestRequestWithHandler:(id)handler {
    
    id<DNENetworkAPIProtocol> api = [[DNETestAPI alloc] init];
    
    NSDictionary *param = @{};
    
    [self sendRequest:api parameters:param
              handler:handler
      successCallback:^(id<DNENetworkAPIProtocol>  _Nonnull api, NSDictionary<NSString *,id> * _Nonnull response) {
        
        NSLog(@"success");
        
    } errorCallback:^(id<DNENetworkAPIProtocol>  _Nonnull api, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}
@end
