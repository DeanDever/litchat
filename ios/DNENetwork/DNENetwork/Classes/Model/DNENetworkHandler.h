//
//  DNENetworkHandler.h
//  zaky
//
//  Created by 吴迪 on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DNENetworkHandlerErrorBlock)(NSError *error);

@interface DNENetworkHandler : NSObject

/// 发送网络请求
/// @param api api实例
/// @param parameters 参数
/// @param handler 请求持有人
/// @param successBlock 成功回调
/// @param errorBlock 失败回调
+ (void)sendRequest:(id<DNENetworkAPIProtocol>)api
         parameters:(NSDictionary<NSString *, id> *)parameters
            handler:(nullable id)handler
    success:(nullable DNENetworkSuccessBlock)successBlock
      error:(nullable DNENetworkErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
