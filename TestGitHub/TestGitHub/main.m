//
//  main.m
//  TestGitHub
//
//  Created by 歐陽 on 16/3/5.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpUtil.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        void testString();
        testString();
        
//        void testHttp();
//        testHttp();
        
    }
    return 0;
}

void testHttp(){
    //        [HttpUtil httpTest];
    NSString *urlStr = @"http://www.xbrjblkj.com:8124/BlmemServer2.04/appUserAction!userLogin.ac?username=abc&password=asd";
    [HttpUtil httpPost:urlStr];
    
    //定义字符串
    NSString* str = @"";
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
    [HttpUtil httpPost:str completionHandler:completionHandler];
}

void testString(){
    //这种方式创建的字符串不需要释放，因为它是指向一个常量
    NSString *str1 = @"test String";
    //其它的方式都需要释放内存
    NSString *str2 = [[NSString alloc]initWithString:@"a obj-c String"];
    NSString *str3 = [[NSString alloc]initWithUTF8String:"a C string"];
    NSString *str4 = [[NSString alloc]initWithFormat:@"a=%i，b=%.2f", 12, 3.45f];
    NSString *usernameText = @"asd";
    NSString *passwordText = @"asd";
    NSString *str5 = [[NSString alloc]initWithFormat:@"username=%@&password=%@", usernameText, passwordText];
    NSString *str6 = [NSString stringWithFormat:@"username=%@&password=%@", usernameText, passwordText];
    NSLog(@"str6=%@", str6);
}