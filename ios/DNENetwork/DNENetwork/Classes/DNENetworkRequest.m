//
//  DNENetworkRequest.m
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import "DNENetworkRequest.h"

@implementation DNENetworkRequest

- (instancetype)initWithAPI:(id<DNENetworkAPIProtocol>)api
               andParameter:(NSDictionary<NSString *,id> *)parameter
        progress:(DNENetworkProgressBlock)progressBlock
         success:(DNENetworkSuccessBlock)successBlock
           error:(DNENetworkErrorBlock)errorBlock
                 andHandler:(nonnull id)handler {
    self = [super init];
    if (self) {
        _api = api;
        [self setParameters:parameter];
        _progressCallback = progressBlock;
        _successBlock = successBlock;
        _errorBlock = errorBlock;
        
        if (parameter.allKeys.count > 0) {
            self.identifier = [NSString stringWithFormat:@"%@%lu%lu%lu",[self.api APIString], (unsigned long)[self.api method], (unsigned long)[self.api serializerType], (unsigned long)[self.parameters hash]];
        } else {
            self.identifier = [NSString stringWithFormat:@"%@%lu%lu",[self.api APIString], (unsigned long)[self.api method], (unsigned long)[self.api serializerType]];
        }
       
        [self setHandler:handler];
    }
    return self;
}

#pragma mark - Setter & Getter

- (void)setTask:(NSURLSessionTask *)task {
    _task = task;
    _requestSendTime = [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970;
}
@end
