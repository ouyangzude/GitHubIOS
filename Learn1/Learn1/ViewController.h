//
//  ViewController.h
//  MedicationClockIOS
//
//  Created by 歐陽 on 16/3/11.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "LoadingAlertController.h"
#import "HttpUtil.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

- (IBAction)loginBtn:(id)sender;
- (IBAction)registBtn:(id)sender;

@end

