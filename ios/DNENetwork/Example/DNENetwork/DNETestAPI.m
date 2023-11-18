//
//  DNETestAPI.m
//  DNENetwork_Example
//
//  Created by 吴迪 on 2021/3/27.
//  Copyright © 2021 master_dean@163.com. All rights reserved.
//

#import "DNETestAPI.h"

@implementation DNETestAPI
- (NSString *)baseUrlString {
//#ifdef DEBUG
//    return @"http://api.gzshujiu.com";
//#else
    return @"https://api.zaky.mobi";
//#endif
}

- (NSString *)APIString {
    return @"/admin/systemVersionConfig/listAll";
}

- (DNENetworkMethod)method {
    return DNENetworkMethodGet;
}

- (DNENetworkSerializerType)serializerType {
    return DNENetworkSerializerTypeHTTP;
}

@end
