//
//  DNENetworkManager.h
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "DNENetworkRequest.h"
#import "DNENetworkConfiguration.h"
#import "DNENetworkAPIProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNENetworkManager : NSObject

/// 更新网络配置
/// @param configuration 配置实例
+ (void)updateConfiguration:(DNENetworkConfiguration *) configuration;

+ (DNENetworkConfiguration *)currentConfiguration;

/// 发送Get或Post 类型的网络请求
/// @param api API实例
/// @param parameters 参数
/// @param handler 请求持有者
/// @param successBlock 成功回调
/// @param errorBlock 失败回调
+ (void)sendRequest:(id<DNENetworkAPIProtocol>)api
     withParameters:(NSDictionary<NSString *, id> *)parameters
            handler:(id)handler
    success:(DNENetworkSuccessBlock)successBlock
    error:(DNENetworkErrorBlock)errorBlock;

/// 下载文件
/// @param url 下载地址
/// @param path 保存路径
/// @param fileName 保存文件名
/// @param handler 请求发送者
/// @param progressBlock 进度回调
/// @param successBlock 成功回调
/// @param errorBlock 失败回调
+ (void)downloadData:(NSString *)url
       saveDirection:(NSString *)path
        saveFileName:(NSString *)fileName
             handler:(id)handler
    progressCallback:(DNENetworkProgressBlock)progressBlock
     success:(DNENetworkDownloadSuccessBlock)successBlock
       error:(DNENetworkDownloadErrorBlock)errorBlock;


@end

NS_ASSUME_NONNULL_END
