//
//  DNETestNetworkHanderl.h
//  DNENetwork_Example
//
//  Created by 吴迪 on 2021/3/27.
//  Copyright © 2021 master_dean@163.com. All rights reserved.
//

#import <DNENetwork/DNENetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNETestNetworkHanderl : DNENetworkHandler

+ (void)sendTestRequestWithHandler:(id)handler;

@end

NS_ASSUME_NONNULL_END
