//
//  ViewController.m
//  Learn2
//
//  Created by 歐陽 on 16/3/12.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtn:(id)sender {
    //读取文本框
    NSString *usernameText = _usernameView.text;
    NSString *passwordText = _passwordView.text;
    //设置文本框关闭软键盘
    //    [_usernameView resignFirstResponder];
    //    [_passwordView resignFirstResponder];
    //如果文本框都在self.view里面，也可以用下面这种方法关闭软键盘
    [self.view endEditing:YES];
    //设置对话框文本
    NSString *msg;
    if ([usernameText isEqualToString:@""] || usernameText == NULL) {
        msg = @"用户名不能为空";
    } else if([passwordText isEqualToString:@""] || passwordText == NULL){
        msg = @"用户名不能为空";
    }
    //如果对话框文本不为空
    if (msg.length !=0) {
        //显示对话框
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        //从IOS9.0起推荐使用这种方法
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        //        // Create the actions.
        //        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //            NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
        //        }];
        //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //            NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        //        }];
        //
        //        // Add the actions.
        //        [alertController addAction:cancelAction];
        //        [alertController addAction:confirmAction];
        //
        //        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //访问Http连接
    NSString *urlStr = @"http://www.xbrjblkj.com:8124/BlmemServer2.04/appUserAction!userLogin.ac";
    NSString *params = [NSString stringWithFormat:@"store_id=1&username=%@&password=%@", usernameText, passwordText];
    NSLog(@"params%@", params);
    
    //打开载入中对话框
    LoadingViewController *loadingAlert = [LoadingViewController alertControllerWithTitle:@"提示" message:@"载入中" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:loadingAlert animated:YES completion:nil];
    
    void (^callbackHandler)(NSData *, NSError *) = ^(NSData *data, NSError *error) {
        NSLog(@"调用回调函数");
        if ([data length] > 0 && error == nil) {
            //输出返回值
            NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"receiveStr=%@", receiveStr);
            //解析json格式数据
            NSError *error;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if(error == nil){       //如果json解析正确
                NSString *user_id = [jsonDictionary objectForKey:@"user_id"];
                NSString *username = [jsonDictionary objectForKey:@"username"];
                NSString *nickname = [jsonDictionary objectForKey:@"nickname"];
                NSString *member_card_id = [jsonDictionary objectForKey:@"member_card_id"];
                NSString *login_id = [jsonDictionary objectForKey:@"login_id"];
                NSString *last_login_time = [jsonDictionary objectForKey:@"last_login_time"];
                NSString *head_img_mark = [jsonDictionary objectForKey:@"head_img_mark"];
                
                //实现页面跳转
                //页面跳转传值的相关知识：http://www.cnblogs.com/heri/archive/2013/03/18/2965815.html
                //通过委托类传递对象到下一页面
                
                //实现页面跳转
                MainViewController *mainViewController= [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:mainViewController animated:YES completion:nil];
            }else{
                //否则显示错误信息
                NSLog(@"error=%@", error);
                //弹出对话框 从IOS9.0起这种方法就过时了
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:receiveStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                //弹出对话框 从IOS9.0起推荐使用这种方法
                //                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:receiveStr preferredStyle:UIAlertControllerStyleAlert];
                //                // Create the actions.
                //                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //                    NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
                //                }];
                //                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                //                    NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
                //                }];
                //
                //                // Add the actions.
                //                [alertController addAction:cancelAction];
                //                [alertController addAction:confirmAction];
                //
                //                [ViewController.self presentViewController:alertController animated:YES completion:nil];
            }
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
        }else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
    };
//    [HttpUtil httpPost:urlStr completionHandler:completionHandler];
    [HttpUtil asynHttp:urlStr param:params callbackHandler:callbackHandler];
}

- (IBAction)registBtn:(id)sender {
    //实现页面跳转
    RegistViewController *registViewController= [[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:registViewController animated:YES completion:nil];
}

@end
