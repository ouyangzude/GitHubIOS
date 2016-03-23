//
//  LoginViewController.h
//  MedicationClock
//
//  Created by 歐陽 on 16/3/23.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "base.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

- (IBAction)loginBtn:(id)sender;
- (IBAction)registBtn:(id)sender;

@end
