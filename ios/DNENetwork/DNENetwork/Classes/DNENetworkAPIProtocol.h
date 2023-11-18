//
//  DNENetworkAPIProtocol.h
//  zaky
//
//  Created by 吴迪 on 2020/12/14.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DNENetworkMethod) {
    DNENetworkMethodGet,
    DNENetworkMethodPost,
    DNENetworkMethodUpload,
    DNENetworkMethodDownload
};

typedef NS_ENUM(NSUInteger, DNENetworkSerializerType) {
    DNENetworkSerializerTypeHTTP,
    DNENetworkSerializerTypeJSON,
};

@protocol DNENetworkAPIProtocol <NSObject>

/// 接口API字符串
- (NSString *)APIString;

/// 请求类型
- (DNENetworkMethod)method;

/// 参数序列化方式
- (DNENetworkSerializerType)serializerType;

@optional

- (NSString *)baseUrlString;

@end
