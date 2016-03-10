//
//  ViewController.h
//  TestIOS
//
//  Created by 歐陽 on 16/3/2.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "HttpUtil.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

- (IBAction)backBtn:(id)sender;
- (IBAction)loginBtn:(id)sender;

@end

