//
//  DNEDownloadAPI.m
//  zaky
//
//  Created by 吴迪 on 2021/2/5.
//

#import "DNEDownloadAPI.h"

@implementation DNEDownloadAPI

/// 接口API字符串
- (NSString *)APIString {
    return @"";
}

/// 请求类型
- (DNENetworkMethod)method {
    return DNENetworkMethodDownload;
}

/// 参数序列化方式
- (DNENetworkSerializerType)serializerType {
    return DNENetworkSerializerTypeJSON;
}

@end
