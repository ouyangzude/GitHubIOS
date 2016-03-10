//
//  HttpUtil.m
//  TestGitHub
//
//  Created by 歐陽 on 16/3/6.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil

+ (void)httpTest{
    //创建Url
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    //创建http访问请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置访问的函数
    [request setHTTPMethod:@"POST"];
    //创建session
    NSURLSession *session = [NSURLSession sharedSession];
    //调用task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response : %@", response);
    }];
    [task resume];
    //为测试子线程执行完整，这里让主线程休眠3毫秒
    [NSThread sleepForTimeInterval:3];
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

+ (void)delegateAsynHttp{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.119:8080/CailanziTest/testAction!myTest.ac"];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    //（1）使用delegate的方式:
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection == nil) {
        NSLog(@"连接失败");
    }else{
        
    }
}

+ (void)asynHttp{
    //第一步，创建url
    //    NSURL *url = [NSURL URLWithString:@"http://192.168.1.119:8080/CailanziTest/testAction!myTest.ac"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器（使用NSOperationQueue的方式）
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               // ...
                               NSLog(@"Test");
                           }];
}

@end
