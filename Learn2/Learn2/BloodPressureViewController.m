//
//  BloodPressureViewController.m
//  Learn2
//
//  Created by 歐陽 on 16/3/16.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "BloodPressureViewController.h"

@interface BloodPressureViewController ()

@end

@implementation BloodPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //新建一个按钮控件对象
    UIButton *headbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的位置和体积大小的属性
    headbtn.frame=CGRectMake(100, 100, 100, 100);
    //也可以在新建对象的时候直接添加位置和体积大小的属性
//    UIButton *headbtn=[[UIButton alloc] initWithFrame:CGRectMake(0 ,20, 100, 20)];
    //设置按钮普通状态的属性
    [headbtn setBackgroundImage:[UIImage imageNamed:@"i"] forState:UIControlStateNormal];
    [headbtn setTitle:@"普通" forState:UIControlStateNormal];
    [headbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置按钮按下状态的属性
    [headbtn setBackgroundImage:[UIImage imageNamed:@"a"] forState:UIControlStateHighlighted];
    [headbtn setTitle:@"按下" forState:UIControlStateHighlighted];
    [headbtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    //把按钮对象添加到视图中显示出来
    [self.view addSubview:headbtn];
    
    //也可以在新建对象的时候直接添加位置和体积大小的属性
    UIButton *backbtn=[[UIButton alloc] initWithFrame:CGRectMake(0 ,20, 100, 20)];
    //设置按钮字体大小
    backbtn.titleLabel.font    = [UIFont systemFontOfSize: 15];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //设置按钮点击事件
    [backbtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    //添加按钮到视图
    [self.view addSubview:backbtn];
    
    //添加一个文本框控件对象
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    label.text = @"测试代码写界面";
    [self.view addSubview:label];
}
//点击按钮的回调函数
-(void)backClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:true completion: (nil)];
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

@end
