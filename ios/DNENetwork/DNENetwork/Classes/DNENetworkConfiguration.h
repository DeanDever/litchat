//
//  DNENetworkConfiguration.h
//  zaky
//
//  Created by 吴迪 on 2020/12/15.
//

#import <Foundation/Foundation.h>
#import "DNENetworkAPIProtocol.h"

@class DNENetworkRequest;

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *, NSString *>* _Nonnull (^DNENetworkDynamicHeadersBlock)(id<DNENetworkAPIProtocol>, NSDictionary<NSString *, id> *);

typedef BOOL(^DNENetworkErrorPugyInCallback)(DNENetworkRequest *request, NSError *error);

typedef void(^DNENetworkSuccessPlugInCallback)(DNENetworkRequest *request, NSDictionary *response);

@interface DNENetworkConfiguration : NSObject
/// 服务器根路径
@property (nonatomic, copy, nullable) NSString *serverString;
/// 固定请求头
@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSString *> *headers;
/// 请求头中网络状态的key名称
@property (nonatomic, copy) NSString *networkStatusHeaderName;
/// 超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/// 重试次数
@property (nonatomic, assign) NSUInteger retryCount;
/// 是否打印日志
@property (nonatomic, assign) BOOL consoleLog;
/// 网络错误回调
@property (nonatomic, copy) DNENetworkErrorPugyInCallback errorBlock;
/// 网络成功回调
@property (nonatomic, copy) DNENetworkSuccessPlugInCallback successBlock;

/// 监听获取动态添加的请求头回调
/// @param block 返回动态添加请求头参数
- (void)observeDynamicHeadersBlock:(DNENetworkDynamicHeadersBlock)block;

/// 获取动态请求头
/// @param request 网络请求
/// @param parameters 参数
- (nullable NSDictionary<NSString *, NSString *> *)dynamicHeaders:(DNENetworkRequest *)request
                                                    andParameters:(NSDictionary<NSString *, id> *)parameters;

@end

NS_ASSUME_NONNULL_END
