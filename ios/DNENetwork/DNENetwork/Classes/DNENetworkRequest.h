//
//  DNENetworkRequest.h
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "DNENetworkAPIProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DNENetworkSuccessBlock)(id<DNENetworkAPIProtocol> api, NSDictionary<NSString *, id> *response);
typedef void(^DNENetworkErrorBlock)(id<DNENetworkAPIProtocol> api, NSError *error);
typedef void(^DNENetworkProgressBlock)(double currentDataLength, double totalDataLength);
typedef void(^DNENetworkDownloadSuccessBlock)(void);
typedef void(^DNENetworkDownloadErrorBlock)(NSError *error);

@interface DNENetworkRequest : NSObject

/// 借口信息
@property (nonatomic, readonly, strong) id<DNENetworkAPIProtocol> api;

/// 参数
@property (nonatomic, copy) NSDictionary<NSString*, id> *parameters;

/// 唯一标识符
@property (nonatomic, copy) NSString* identifier;

/// 任务标示
@property (nonatomic, copy, nullable) NSString *taskIdentifier;

///  成功回调
@property (nonatomic, copy, nullable) DNENetworkSuccessBlock successBlock;

/// 失败回调
@property (nonatomic, copy, nullable) DNENetworkErrorBlock errorBlock;

/// 进度回调
@property (nonatomic, copy, nullable) DNENetworkProgressBlock progressCallback;

/// 下载任务实例
@property (nonatomic, strong, nullable) NSURLSessionTask *task;

/// 请求持有者
@property (nonatomic, weak) id handler;

/// 请求发送时间
@property (nonatomic, readonly, assign) NSTimeInterval requestSendTime;

- (instancetype)initWithAPI:(id<DNENetworkAPIProtocol>)api
               andParameter:(NSDictionary<NSString *, id> *)parameter
        progress:(nullable DNENetworkProgressBlock)progressBlock
         success:(nullable DNENetworkSuccessBlock)successBlock
           error:(nullable DNENetworkErrorBlock)errorBlock
                 andHandler:(id)handler;

@end

NS_ASSUME_NONNULL_END
