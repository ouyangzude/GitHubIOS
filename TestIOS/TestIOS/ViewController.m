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
    NSLog(@"点击了登录按钮，username=%@，password=%@", usernameText, passwordText);
    
    //设置文本框关闭软键盘
    //    [_usernameView resignFirstResponder];
    //    [_passwordView resignFirstResponder];
    //如果文本框都在self.view里面，也可以用下面这种方法关闭软键盘
    [self.view endEditing:YES];
    
    //访问Http连接
    NSString *receiveStr = [HttpUtil httpPost];
    _testView.text = receiveStr;
    NSLog(@"receiveStr=%@", receiveStr);
    
    //页面跳转传值的相关知识：http://www.cnblogs.com/heri/archive/2013/03/18/2965815.html
    //通过委托类传递对象到下一页面
    
    
    //在storyboard中直接创建对象会显示黑屏
//    MainViewController* mainView=[[MainViewController alloc]init];
    //只能通过storyboard对象并使用storyboardID获取界面对象
    MainViewController *mainView=[self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    //过时函数，在IOS6.0的时候就废弃了
//    [self presentModalViewController:mainView animated:YES];
    //在新版本中这么调用跳转页面的函数
    [self presentViewController:mainView animated:YES completion:nil];
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
