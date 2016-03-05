//
//  RegistViewController.m
//  TestIOS
//
//  Created by 歐陽 on 16/3/2.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    NSLog(@"点击了返回按钮");
    //过时函数，在IOS6.0的时候就废弃了
    //    [self dismissModalViewControllerAnimated:YES];
    //取代函数
    [self dismissViewControllerAnimated:true completion: (nil)];
}

- (IBAction)registBtn:(id)sender {
    NSString *usernameText = _usernameView.text;
    NSString *passwordText = _passwordView.text;
    NSLog(@"点击了注册按钮，username=%@，password=%@", usernameText, passwordText);
    
    //设置关闭软键盘
    [self.view endEditing:YES];
}

@end
