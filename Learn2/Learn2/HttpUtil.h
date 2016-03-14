//
//  HttpUtil.h
//  Learn2
//
//  Created by 歐陽 on 16/3/12.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject

+ (void)asynHttp:(NSString*)urlStr param:(NSString*)params callbackHandler:(void (^)(NSData *data, NSError *error))callbackHandler;

+ (void)httpPost:(NSString*)urlStr param:(NSString*)params callbackHandler:(void (^)(NSData *data, NSError *error))callbackHandler;

@end
