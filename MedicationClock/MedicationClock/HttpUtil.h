//
//  HttpUtil.h
//  MedicationClock
//
//  Created by 歐陽 on 16/3/23.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject

+ (void)asynHttp:(NSString*)urlStr param:(NSString*)params callbackHandler:(void (^)(NSData *data, NSError *error))callbackHandler;

+ (void)httpPost:(NSString*)urlStr param:(NSString*)params callbackHandler:(void (^)(NSData *data, NSError *error))callbackHandler;

@end
