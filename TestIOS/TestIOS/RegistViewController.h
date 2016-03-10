//
//  RegistViewController.h
//  TestIOS
//
//  Created by 歐陽 on 16/3/2.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUtil.h"

@interface RegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *confirmpwdView;
@property (weak, nonatomic) IBOutlet UITextField *nicknameView;

- (IBAction)backBtn:(id)sender;
- (IBAction)registBtn:(id)sender;

@end
