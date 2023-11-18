//
//  DNENetworkManager.m
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import "DNENetworkManager.h"
#import "DNENetworkEnginer.h"

@implementation DNENetworkManager

/// 更新网络配置
/// @param configuration 配置实例
+ (void)updateConfiguration:(DNENetworkConfiguration *)configuration {
    [[DNENetworkEnginer sharedInstance] updateConfig:configuration];
}

+ (DNENetworkConfiguration *)currentConfiguration {
    return [DNENetworkEnginer sharedInstance].config;
}

/// 发送Get或Post 类型的网络请求
/// @param api API实例
/// @param parameters 参数
/// @param handler 请求持有者
/// @param successBlock 成功回调
/// @param errorBlock 失败回调
+ (void)sendRequest:(id<DNENetworkAPIProtocol>)api
     withParameters:(NSDictionary<NSString *,id> *)parameters
            handler:(id)handler
    success:(DNENetworkSuccessBlock)successBlock
      error:(DNENetworkErrorBlock)errorBlock {
    
    DNENetworkRequest *request = [DNENetworkManager createRequest:api
                                                   withParameters:parameters
                                                          handler:handler
                                                  success:successBlock
                                                    error:errorBlock];
    [DNENetworkManager sendRequest:request];
    
}

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
       error:(DNENetworkDownloadErrorBlock)errorBlock {
    
    DNENetworkDownloadRequest *request = [[DNENetworkDownloadRequest alloc] initWithURL:url
                                                                               savePath:path
                                                                               savename:fileName
                                                                    progress:progressBlock
                                                                     success:successBlock
                                                                       error:errorBlock
                                                                             andHandler:handler];

    [[DNENetworkEnginer sharedInstance] sendNetworkRequest:request];
    
}


/// 创建请求实例
/// @param api 接口实例
/// @param parameters 参数
/// @param successBlock 成功回调
/// @param errorBlock 失败回调
+ (DNENetworkRequest *)createRequest:(id<DNENetworkAPIProtocol>)api
                      withParameters:(NSDictionary<NSString *,id> *)parameters
                             handler:(id)handler
                     success:(DNENetworkSuccessBlock)successBlock
                       error:(DNENetworkErrorBlock)errorBlock {
    DNENetworkRequest *request = [[DNENetworkRequest alloc] initWithAPI:api
                                                           andParameter:parameters
                                                    progress:NULL
                                                     success:successBlock
                                                       error:errorBlock
                                                             andHandler:handler];
    return request;
}

/// 发送网络请求
/// @param request 请求实例
+ (void)sendRequest:(DNENetworkRequest *)request {
    [[DNENetworkEnginer sharedInstance] sendNetworkRequest:request];
}


@end
