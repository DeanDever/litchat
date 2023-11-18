//
//  DNENetworkEnginer.m
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import "DNENetworkEnginer.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface DNENetworkEnginer ()

@property (nonatomic, strong) NSMutableDictionary<NSString*, DNENetworkRequest *> *requestDic;

@property (nonatomic, strong) AFHTTPRequestSerializer *httpSerializer;

@property (nonatomic, strong) AFJSONRequestSerializer *jsonSerializer;

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end
@implementation DNENetworkEnginer

+ (instancetype)sharedInstance {
    
    static DNENetworkEnginer *objc = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc = [[DNENetworkEnginer alloc] init];
    });
    
    return objc;
}

/*
   硬性设置：
   1.因为与缓存互通 服务器返回的数据格式 必须是二进制
   2.开启菊花
*/
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.networkQueue = dispatch_queue_create("com.zaky.digit9.network", DISPATCH_QUEUE_SERIAL);
        
        self.operationQueue.maxConcurrentOperationCount = 5;
        
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSArray *responseContentTypes = @[@"text/html",
                                          @"application/json",
                                          @"text/json",
                                          @"text/plain",
                                          @"text/javascript",
                                          @"text/xml",
                                          @"image/*",
                                          @"multipart/form-data",
                                          @"application/octet-stream",
                                          @"application/zip"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:responseContentTypes];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
         _requestDic =[[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/// 更新网络配置
/// @param config 配置实例
- (void)updateConfig:(DNENetworkConfiguration *)config {
    _config = [config mutableCopy];
}

/// 发送网络请求
/// @param request 请求实例
- (void)sendNetworkRequest:(DNENetworkRequest *)request {
    dispatch_sync(self.networkQueue, ^{
        
        //  已存在该请求，上次请求还未返回结果则此次请求不再发起
        if (_requestDic[request.identifier] != NULL) {
            return;
        }
        
        [self requestSerializerConfig:request];
        [self headersAndTimeConfig:request];
        

        NSURLSessionTask * task = NULL;
        switch ([request.api method]) {
            case DNENetworkMethodGet:
                task = [self getDataWithRequest:request];
                break;
                
            case DNENetworkMethodPost:
                task = [self postDataWithRequest:request];
                break;

            case DNENetworkMethodUpload:
                break;
                
            case DNENetworkMethodDownload:
                task = [self downloadDataWithRequest:(DNENetworkDownloadRequest *)request];
                break;
        }

        if (self.config.consoleLog) {
            NSString *method = @"";
            switch ([request.api method]) {
                case DNENetworkMethodGet:
                    method = @"GET";
                    break;
                case DNENetworkMethodPost:
                    method = @"POST";
                    break;
                case DNENetworkMethodUpload:
                    method = @"UPLOAD";
                    break;
                case DNENetworkMethodDownload:
                    method = @"DOWNLOAD";
                    break;
            }
            
//            NSLog(@"\n============================\n▶️URL:%@\n▶️Headers:%@\n▶️Method:%@\n▶️Body:%@\n============================",request.api.APIString,self.requestSerializer.HTTPRequestHeaders,method,request.parameters);
        }
        
        [request setTask:task];
    });
}

- (NSString *)requestUrl:(DNENetworkRequest *)request {
    if ([request.api respondsToSelector:@selector(baseUrlString)]) {
        return [NSString stringWithFormat:@"%@%@",[request.api baseUrlString], request.api.APIString];
    } else {
        return [NSString stringWithFormat:@"%@%@",_config.serverString, request.api.APIString];
    }
}

/// 发送GET请求
/// @param request 请求实例
- (NSURLSessionTask *)getDataWithRequest:(DNENetworkRequest *)request {
    NSString *url = [self requestUrl:request];
    @weakify(self)
    return [self GET:url parameters:request.parameters headers:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [self processSuccessRequest:request withResponse:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self)
        [self processErrorRequest:request withError:error];
    }];
}

/// 发送PSOT请求
/// @param request 请求实例
- (NSURLSessionTask *)postDataWithRequest:(DNENetworkRequest *)request {
    NSString *url = [self requestUrl:request];
    @weakify(self)
    return [self POST:url parameters:request.parameters headers:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [self processSuccessRequest:request withResponse:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self)
        [self processErrorRequest:request withError:error];
    }];
}

/// 上传数据
/// @param request 请求实例
- (void)uploadDataWithRequest:(DNENetworkRequest *)request {
    
}

/// 下载数据
/// @param request 请求实例
- (NSURLSessionTask *)downloadDataWithRequest:(DNENetworkDownloadRequest *)request {
    
    NSURL *url = [NSURL URLWithString:request.url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURL *downloadFileSavePath = [NSURL fileURLWithPath:[NSString pathWithComponents:@[request.savePath, request.saveFileName]]
                                             isDirectory:NO];
    
    NSData *resumeData = [request resumeData];
    
    NSURLSessionDownloadTask *downloadTask;
    
    @weakify(self)
    if (resumeData) {
        downloadTask = [self downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
            request.progressCallback(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return downloadFileSavePath;
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            @strongify(self)
            [self processDownloadRequestError:request error:error];
        }];
    } else {
        downloadTask = [self downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
            request.progressCallback(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return downloadFileSavePath;
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            @strongify(self)
            [self processDownloadRequestError:request error:error];
        }];
    }
    
    
    [downloadTask resume];
    return downloadTask;

}

- (void)processDownloadRequestError:(DNENetworkDownloadRequest *)request error:(NSError *)error {
    if (error) {
        request.downloaderrorBlock(error);
    } else {
        request.downloadsuccessBlock();
    }
 
    [self removeTask:request];
}
/// 处理成功的请求响应
/// @param request 请求实例
/// @param responseData 服务器的响应实例
- (void)processSuccessRequest:(DNENetworkRequest *)request withResponse:(id _Nonnull)responseData {
    
    if ([responseData isMemberOfClass:NSDictionary.class] && request.handler) {
        
        //  插件回调
        if (self.config.successBlock) {
            self.config.successBlock(request, responseData);
        }
        
        request.successBlock(request.api, (NSDictionary *)responseData);
    } else if(request.handler) {
        NSDictionary<NSString *, id> *respinseDic =  [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        if (!respinseDic) {
            NSString *msg = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            if (msg.length == 0) {
                msg = @"response nil";
            }
            NSError *error = [NSError errorWithDomain:@"com.shujiu.zaky.network"
                                                 code:-1
                                             userInfo:@{NSLocalizedDescriptionKey: msg}];
            [self processErrorRequest:request withError:error];
            return;
        }
        
        NSNumber *status = respinseDic[@"success"];
        if ([status boolValue]) {
            //  插件回调
            if (self.config.successBlock) {
                self.config.successBlock(request, respinseDic);
            }
            
            request.successBlock(request.api, respinseDic);
        } else {
            //  业务错误
            NSNumber *errorCode = respinseDic[@"status"];
            NSString *message = respinseDic[@"message"];
            if ([errorCode integerValue] == 7000) {
                NSDictionary *dic = respinseDic[@"content"];
                message = [dic yy_modelToJSONString];
            }
            if (message.length == 0) {
                message = @"Unknown Error";
            }
            NSError *error = [NSError errorWithDomain:@"com.shujiu.zaky.network"
                                                 code:[errorCode integerValue]
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
            [self processErrorRequest:request withError:error];
        }
    }
    
    //  移除任务
    [self removeTask:request];
}

/// 处理请求失败的信息
/// @param request 请求实例
/// @param error 错误信息
- (void)processErrorRequest:(DNENetworkRequest *)request withError:(NSError *)error {
    
    BOOL needCallback = true;
    //  失败结果插件
    if (self.config.errorBlock) {
        needCallback = self.config.errorBlock(request, error);
    }
    
    //  插件回调和失败结果返回
    if (request.handler) {
        if ((!self.config.errorBlock || needCallback) ) {
            request.errorBlock(request.api, error);
        } else {
            request.errorBlock(request.api, [NSError errorWithDomain:@"com.digit.error" code:-1 userInfo:@{NSLocalizedDescriptionKey: @""}]);
        }
    }
    
    //  移除任务
    [self removeTask:request];
}

/// 从请求存储的Dictionary中移除该请求
/// @param request 请求实例
- (void)removeTask:(DNENetworkRequest *)request{
    if ([self.requestDic objectForKey:request.identifier] != NULL) {
        [self.requestDic removeObjectForKey: request.identifier];
    }
}

//请求参数的格式
- (void)requestSerializerConfig:(DNENetworkRequest *)request{
    self.requestSerializer = [request.api serializerType] == DNENetworkSerializerTypeHTTP ? self.httpSerializer : self.jsonSerializer;
}

//请求头设置
- (void)headersAndTimeConfig:(DNENetworkRequest *)request{
    //  设置通用固定请求头
    if (self.config.headers.allKeys.count > 0) {
        [self.config.headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [self.requestSerializer setValue:value
                          forHTTPHeaderField:field];
        }];
    }
    
    //  设置动态请求头
    NSDictionary *headers = [self.config dynamicHeaders:request andParameters:request.parameters];
    if (headers.allKeys.count > 0) {
        [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [self.requestSerializer setValue:value
                          forHTTPHeaderField:field];
        }];
    }
    
    //  设置网络状态
    [self.requestSerializer setValue:self.reachableStatusString
                  forHTTPHeaderField:self.config.networkStatusHeaderName];
    
}

/// 取消所有请求
- (void)cancelAllRequest{
    if (self.tasks.count>0) {
        [self.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
    [self.requestDic removeAllObjects];
}

#pragma mark - Setter & Getter

- (NSMutableDictionary<NSString *,DNENetworkRequest *> *)requestDic {
    if (_requestDic == nil) {
        _requestDic = [[NSMutableDictionary alloc] init];
    }
    return  _requestDic;
}

- (DNENetworkStatus)reachableStatus {
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            return DNENetworkStatusNotReachable;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return DNENetworkStatusWWAN;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return DNENetworkStatusWiFi;
            break;
        default:
            return DNENetworkStatusUnknown;
            break;
    }
}

- (NSString *)reachableStatusString {
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            return @"UNRECHABLE";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"CELLULAR";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"WIFI";
            break;
        default:
            return @"UNKNOW";
            break;
    }
}

- (AFJSONRequestSerializer *)jsonSerializer {
    if (!_jsonSerializer) {
        _jsonSerializer = [AFJSONRequestSerializer serializer];
        [_jsonSerializer willChangeValueForKey:@"timeoutInterval"];
        _jsonSerializer.timeoutInterval = 5;
        [_jsonSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _jsonSerializer;
}

- (AFHTTPRequestSerializer *)httpSerializer{
    if (!_httpSerializer) {
        _httpSerializer = [AFHTTPRequestSerializer serializer];
        [_httpSerializer willChangeValueForKey:@"timeoutInterval"];
        _httpSerializer.timeoutInterval = 5;
        [_httpSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _httpSerializer;
}


@end
