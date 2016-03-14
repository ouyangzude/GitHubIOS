//
//  ViewController.m
//  TestIOS
//
//  Created by 歐陽 on 16/3/2.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)backBtn:(id)sender{
    //关闭当前页面
    [self dismissViewControllerAnimated:true completion: (nil)];
}

- (IBAction)loginBtn:(id)sender{
    
    NSString *usernameText = _usernameView.text;
    NSString *passwordText = _passwordView.text;
//    NSString *usernameText = @"abc";
//    NSString *passwordText = @"asd";
    
    //设置文本框关闭软键盘
    //    [_usernameView resignFirstResponder];
    //    [_passwordView resignFirstResponder];
    //如果文本框都在self.view里面，也可以用下面这种方法关闭软键盘
    [self.view endEditing:YES];
    
    NSString *msg;
    if ([usernameText isEqualToString:@""] || usernameText == NULL) {
        msg = @"用户名不能为空";
    } else if([passwordText isEqualToString:@""] || passwordText == NULL){
        msg = @"用户名不能为空";
    }
    
    if (msg.length !=0) {
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
    NSLog(@"点击了登录按钮，username=%@，password=%@", usernameText, passwordText);
    
    //访问Http连接
    NSString *urlStr = @"http://www.xbrjblkj.com:8124/BlmemServer2.04/appUserAction!userLogin.ac";
    NSString *params = [NSString stringWithFormat:@"store_id=1&username=%@&password=%@", usernameText, passwordText];
    NSLog(@"params%@", params);
    
//    void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"调用回调函数");
//        if ([data length] > 0 && error == nil) {
//            //输出返回值
//            NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            _testView.text = receiveStr;
//            NSLog(@"receiveStr=%@", receiveStr);
//            
//        }else if ([data length] == 0 && error == nil){
//            NSLog(@"Nothing was downloaded.");
//        }else if (error != nil){
//            NSLog(@"Error happened = %@",error);
//        }
//    };
//    [HttpUtil httpPost:urlStr completionHandler:completionHandler];
    
    void (^completionHandler)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse *response, NSData *data, NSError *error) {
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
                
                
                //在storyboard中直接创建对象会显示黑屏
                //    MainViewController* mainView=[[MainViewController alloc]init];
                //只能通过storyboard对象并使用storyboardID获取界面对象
                MainViewController *mainView=[self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
                //如果把storyboard改成xib，则用这种方法获取界面对象
//                MainViewController *mainViewController= [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
                //过时函数，在IOS6.0的时候就废弃了
                //    [self presentModalViewController:mainView animated:YES];
                //在新版本中这么调用跳转页面的函数
                [self presentViewController:mainView animated:YES completion:nil];
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
    LoadingAlert *loadingAlert = [LoadingAlert alertControllerWithTitle:@"提示" message:@"载入中" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:loadingAlert animated:YES completion:nil];
    [HttpUtil asynHttp:urlStr param:params completionHandler:completionHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
