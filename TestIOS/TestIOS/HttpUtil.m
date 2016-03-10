//
//  HttpUtil.m
//  TestIOS
//
//  Created by 歐陽 on 16/3/2.
//  Copyright © 2016年 歐陽. All rights reserved.
//

/**
 *  IOS无法访问http的问题参考资料：
 *  http://xinpure.com/nsurlsessionnsurlconnection-http-load-failed-kcfstreamerrordomainssl-9802/
 *  https://segmentfault.com/a/1190000002933776
 */

#import "HttpUtil.h"

@implementation HttpUtil

+ (void)asynHttp:(NSString*)urlStr param:(NSString*)params completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* error))completionHandler{
    NSLog(@"urlStr=%@ params=%@", urlStr, params);
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:urlStr];
    //第二步，创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    //设置要发送的正文内容（适用于Post请求）
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器（使用NSOperationQueue的方式）
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

+ (void)test{
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

+ (void)testJson{
    
    NSString *jsonStr = @"[{\"id\":1,\"username\":\"asd\",\"e-mail\":\"asd\",\"password\":\"asd\"}]";
    NSLog(@"jsonStr=%@", jsonStr);
    //NSString 转 NSData
    NSData* jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsonData=%@", jsonData);
    //NSData 转 NSString，参考：http://fei263.blog.163.com/blog/static/9279372420115125731356/
    NSString *str = [[NSString alloc]initWithData:jsonData  encoding:NSUTF8StringEncoding];
    NSLog(@"str=%@", str);
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中，其中NSDictionary类似于JsonObject，NSArray类似于JsonArray
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    //    NSDictionary *jsonDic = [jsonDictionary objectForKey:@"weatherinfo"];
    for(int i=0;i<[jsonArray count];i++){
        NSDictionary *jsonDic = [jsonArray objectAtIndex:i];
        NSString *idStr = [jsonDic objectForKey:@"id"];
        NSString *usernameStr = [jsonDic objectForKey:@"username"];
        NSString *passwordStr = [jsonDic objectForKey:@"password"];
        NSString *emailStr = [jsonDic objectForKey:@"e-mail"];
        NSLog(@"idStr=%@ usernameStr=%@ passwordStr=%@ emailStr=%@", idStr, usernameStr, passwordStr, emailStr);
    }
}

@end
