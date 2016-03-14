//
//  ViewController.h
//  Learn2
//
//  Created by 歐陽 on 16/3/12.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "RegistViewController.h"
#import "HttpUtil.h"
#import "LoadingViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

- (IBAction)loginBtn:(id)sender;
- (IBAction)registBtn:(id)sender;

@end

