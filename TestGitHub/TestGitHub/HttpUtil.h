//
//  HttpUtil.h
//  TestGitHub
//
//  Created by 歐陽 on 16/3/6.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject

+ (void)httpTest;
+ (void)httpPost:(NSString*)urlStr;
+ (void)httpPost:(NSString*)urlStr completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;

+ (void)delegateAsynHttp;
+ (void)asynHttp;

@end
