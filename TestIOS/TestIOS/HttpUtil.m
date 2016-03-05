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

+ (NSString *) httpPost{
    //第一步，创建URL
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.119:8080/CailanziTest/testAction!myTest.ac"];
    //第二步，创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *receivedStr = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"receivedStr=%@",receivedStr);
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中，其中NSDictionary类似于JsonObject，NSArray类似于JsonArray
    NSError *error;
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    NSString *idStr = [weatherInfo objectForKey:@"id"];
    NSString *usernameStr = [weatherInfo objectForKey:@"username"];
    NSString *passwordStr = [weatherInfo objectForKey:@"password"];
    NSString *emailStr = [weatherInfo objectForKey:@"e-mail"];
    
    return receivedStr;
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

@end
