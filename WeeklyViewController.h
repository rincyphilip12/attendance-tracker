//
//  WeeklyViewController.h
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic)NSMutableArray *monthArray;
@property(nonatomic)NSMutableArray *weekArray;
@property(nonatomic,strong)NSString *month;
@property(nonatomic,strong)NSString *week;
@property(nonatomic)NSDictionary *jsonData;
@property(nonatomic)NSMutableArray *resultArray;
@end
