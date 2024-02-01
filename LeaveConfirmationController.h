//
//  LeaveConfirmationController.h
//  LeaveFormAT
//
//  Created by apple on 3/5/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaveApplicationController.h"

@interface LeaveConfirmationController : UIViewController
@property(nonatomic,strong)NSMutableDictionary *dictToPass;
@property(nonatomic)NSDictionary *jsonData;
@property(nonatomic)NSArray *resultArray;


@end
