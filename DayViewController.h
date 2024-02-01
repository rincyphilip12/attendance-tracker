//
//  DayViewController.h
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic)NSMutableArray *monthArray;
@property(nonatomic)NSMutableArray *dayArray;
@property(nonatomic)NSString *month;
@property(nonatomic)NSString *day;
@property(nonatomic)NSDictionary *jsonData;
@property(nonatomic)NSMutableArray *resultArray;
@end
