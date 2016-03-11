//
//  HttpUtil.h
//  MedicationClockIOS
//
//  Created by 歐陽 on 16/3/11.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject

+ (void)httpPost:(NSString*)urlStr;
+ (void)httpPost:(NSString*)urlStr completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;
+ (void)asynHttp:(NSString*)urlStr param:(NSString*)params completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* error))completionHandler;

@end
