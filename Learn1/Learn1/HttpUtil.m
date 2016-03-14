//
//  HttpUtil.m
//  MedicationClockIOS
//
//  Created by 歐陽 on 16/3/11.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil

+ (void)asynHttp:(NSString*)urlStr param:(NSString*)params callbackHandler:(void (^)(int httpState, NSString* result))callbackHandler{
    NSLog(@"urlStr=%@ params=%@", urlStr, params);
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:urlStr];
    //第二步，创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    //设置要发送的正文内容（适用于Post请求）
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //创建回调函数
    void (^completionHandler)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            //输出返回值
            NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"receiveStr=%@", receiveStr);
            callbackHandler(1, receiveStr);
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
            callbackHandler(0, @"");
        }else if (error != nil){
            NSLog(@"Error happened = %@",error);
            callbackHandler(-1, [NSString stringWithFormat:@"error=%@", error]);
        }
    };
    //连接服务器（使用NSOperationQueue的方式）
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:completionHandler];
}

+ (void)httpPost:(NSString*)urlStr{
    //创建Url
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建http访问请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置访问的函数
    [request setHTTPMethod:@"POST"];
    //创建session
    NSURLSession *session = [NSURLSession sharedSession];
    //定义块
    void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"调用回调函数");
        if ([data length] > 0 && error == nil) {
            //输出返回值
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"str = %@", str);
            
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
        }else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    };
    //调用task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
    //为测试子线程执行完整，这里让主线程休眠3毫秒
    [NSThread sleepForTimeInterval:3];
}

+ (void)httpPost:(NSString*)urlStr completionHandler:(void (^)(NSData* data, NSURLResponse* response, NSError* error))completionHandler{
    //创建Url
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建http访问请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置访问的函数
    [request setHTTPMethod:@"POST"];
    //创建session
    NSURLSession *session = [NSURLSession sharedSession];
    //调用task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
    //为测试子线程执行完整，这里让主线程休眠3毫秒
    [NSThread sleepForTimeInterval:3];
}

@end
