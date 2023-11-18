//
//  DNENetworkConfiguration.m
//  zaky
//
//  Created by 吴迪 on 2020/12/15.
//

#import "DNENetworkConfiguration.h"

@interface DNENetworkConfiguration ()
@property (nonatomic, copy) DNENetworkDynamicHeadersBlock dynamicHeaderBlock;
@end
@implementation DNENetworkConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkStatusHeaderName = @"net";
        self.timeoutInterval = 10;
        self.retryCount = 3;
        self.consoleLog = YES;
    }
    return self;
}


/// 注册监听动态请求头参数回调
/// @param block 回调block
- (void)observeDynamicHeadersBlock:(DNENetworkDynamicHeadersBlock)block {
    self.dynamicHeaderBlock = block;
}


/// 获取动态头
/// @param request 请求实例
/// @param parameters 参数
-(NSDictionary<NSString *,NSString *> *)dynamicHeaders:(nonnull DNENetworkRequest *)request
                                         andParameters:(nonnull NSDictionary<NSString *,id> *)parameters {
    return self.dynamicHeaderBlock(request.api, parameters);
}

- (id)mutableCopy {
    return self;
}

@end
