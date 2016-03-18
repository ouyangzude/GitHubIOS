//
//  MainViewController.h
//  Learn2
//
//  Created by 歐陽 on 16/3/12.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BloodPressureViewController.h"
#import "BloodSugarViewController.h"

@interface MainViewController : UIViewController

- (IBAction)backBtn:(id)sender;
- (IBAction)bloodPressureBtn:(id)sender;
- (IBAction)bloodSugarBtn:(id)sender;
- (IBAction)medicationAlarmBtn:(id)sender;

@end
