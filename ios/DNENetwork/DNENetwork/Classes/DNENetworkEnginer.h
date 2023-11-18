//
//  DNENetworkEnginer.h
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "DNENetworkDownloadRequest.h"
#import "DNENetworkConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DNENetworkStatus) {
    DNENetworkStatusUnknown             = -1,
    DNENetworkStatusNotReachable        = 0,
    DNENetworkStatusWWAN                = 1,
    DNENetworkStatusWiFi                = 2,
};

@interface DNENetworkEnginer : AFHTTPSessionManager

@property (nonatomic, readonly, assign) DNENetworkStatus reachableStatus;

@property (nonatomic, readonly, copy) NSString *reachableStatusString;

@property (nonatomic, readonly) DNENetworkConfiguration *config;

+ (instancetype)sharedInstance;

/// 更新网络配置
/// @param config 配置实例
- (void)updateConfig:(DNENetworkConfiguration *)config;

/// 发送网络请求
/// @param request 请求实例
- (void)sendNetworkRequest:(DNENetworkRequest *)request;

/// 取消所有请求
- (void)cancelAllRequest;

@end

NS_ASSUME_NONNULL_END
