//
//  DNENetworkDownloadRequest.m
//  zaky
//
//  Created by 吴迪 on 2020/12/15.
//

#import "DNENetworkDownloadRequest.h"
#import "DNEDownloadAPI.h"

@implementation DNENetworkDownloadRequest

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithURL:(NSString *)url
                   savePath:(NSString *)path
                   savename:(NSString *)name
        progress:(nullable DNENetworkProgressBlock)progressBlock
         success:(nullable DNENetworkDownloadSuccessBlock)successBlock
           error:(nullable DNENetworkDownloadErrorBlock)errorBlock
                 andHandler:(id)handler {
    
    DNEDownloadAPI *api = [[DNEDownloadAPI alloc] init];
    self = [super initWithAPI:api andParameter:@{} progress:progressBlock success:NULL error:NULL andHandler:handler];
    if (self) {
        _url = url;
        _savePath = path;
        _saveFileName = name;
        _downloaderrorBlock = errorBlock;
        _downloadsuccessBlock = successBlock;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelDownload) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)cancelDownload {
    NSURLSessionDownloadTask *task = (NSURLSessionDownloadTask *)(self.task);
    if (task) {
        @weakify(self)
        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            @strongify(self)
            [[NSUserDefaults standardUserDefaults] setObject:resumeData forKey:[self cacheKey]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
}

- (nullable NSData *)resumeData {
    return [[NSUserDefaults standardUserDefaults] dataForKey:[self cacheKey]];
}

- (NSString *)cacheKey {
    return [NSString stringWithFormat:@"%@-%@",self.url, self.saveFileName];
}

- (NSString *)identifier {
    return [NSString stringWithFormat:@"download%lu%lu%@%@%@",(unsigned long)[self.api method], (unsigned long)[self.api serializerType], [self.url md5String], [self.savePath md5String], [self.saveFileName md5String]];
}

@end
