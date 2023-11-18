//
//  DNENetworkDownloadRequest.h
//  zaky
//
//  Created by 吴迪 on 2020/12/15.
//

#import "DNENetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNENetworkDownloadRequest : DNENetworkRequest

/// 下载链接
@property (nonatomic, readonly) NSString *url;

/// 存储路径
@property (nonatomic, readonly) NSString *savePath;

/// 存储文件名
@property (nonatomic, readonly) NSString *saveFileName;

///  成功回调
@property (nonatomic, copy, nullable) DNENetworkDownloadSuccessBlock downloadsuccessBlock;

/// 失败回调
@property (nonatomic, copy, nullable) DNENetworkDownloadErrorBlock downloaderrorBlock;

- (instancetype)initWithURL:(NSString *)url
                   savePath:(NSString *)path
                   savename:(NSString *)name
        progress:(nullable DNENetworkProgressBlock)progressBlock
         success:(nullable DNENetworkDownloadSuccessBlock)successBlock
           error:(nullable DNENetworkDownloadErrorBlock)errorBlock
                 andHandler:(id)handler;

- (nullable NSData *)resumeData;

@end

NS_ASSUME_NONNULL_END
