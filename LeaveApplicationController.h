//
//  ViewController.h
//  LeaveFormAT
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveApplicationController : UIViewController

@property(nonatomic,strong)NSDictionary *jsonData;
@property(nonatomic,strong)NSMutableDictionary *leaveData;
@property(nonatomic,strong)NSString *leaveTypeData;
//@property(nonatomic,strong)NSString *applyleave;
@end

