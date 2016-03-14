//
//  RegistViewController.m
//  Learn2
//
//  Created by 歐陽 on 16/3/13.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "RegistViewController.h"

@implementation RegistViewController

- (IBAction)registBtn:(id)sender {
    NSString *usernameText = _usernameView.text;
    NSString *passwordText = _passwordView.text;
    NSString *confirmpwdText = _confirmpwdView.text;
    NSString *nicknameText = _nicknameView.text;
    //设置关闭软键盘
    [self.view endEditing:YES];
    NSString *msg;
    if ([usernameText isEqualToString:@""] || usernameText == NULL) {
        msg = @"用户名不能为空";
    } else if([passwordText isEqualToString:@""] || passwordText == NULL){
        msg = @"用户名不能为空";
    } else if(![passwordText isEqualToString:confirmpwdText]){
        msg = @"两次密码输入不相同";
    } else if([nicknameText isEqualToString:@""] || nicknameText == NULL){
        msg = @"昵称不能为空";
    }
    
    if (msg.length !=0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    NSLog(@"点击了注册按钮，username=%@，password=%@", usernameText, passwordText);
    
    //访问Http连接
    NSString *urlStr = @"http://www.xbrjblkj.com:8124/BlmemServer2.04/appUserAction!userRegist.ac";
    NSString *params = [NSString stringWithFormat:@"store_id=1&username=%@&password=%@&nicknameText=%@", usernameText, passwordText, nicknameText];
    NSLog(@"params%@", params);
    void (^callbackHandler)(NSData *, NSError *) = ^(NSData *data, NSError *error) {
        NSLog(@"调用回调函数");
        if ([data length] > 0 && error == nil) {
            //输出返回值
            NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"receiveStr=%@", receiveStr);
            if([receiveStr isEqualToString:@"true"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:receiveStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
        }else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    };
    [HttpUtil asynHttp:urlStr param:params callbackHandler:callbackHandler];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:true completion: (nil)];
}

@end
