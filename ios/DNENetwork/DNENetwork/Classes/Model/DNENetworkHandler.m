//
//  DNENetworkHandler.m
//  zaky
//
//  Created by 吴迪 on 2021/1/8.
//

#import "DNENetworkHandler.h"

@implementation DNENetworkHandler

+ (void)sendRequest:(id<DNENetworkAPIProtocol>)api
         parameters:(NSDictionary<NSString *,id> *)parameters
            handler:(nullable id)handler
    success:(DNENetworkSuccessBlock)successBlock
      error:(DNENetworkErrorBlock)errorBlock {
    
    [DNENetworkManager sendRequest:api
                    withParameters:parameters
                           handler:handler
                   success:successBlock
                     error:errorBlock];
    
}

@end
