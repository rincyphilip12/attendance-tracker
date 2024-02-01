//
//  MothlyViewController.h
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthlyViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic)NSMutableArray *dataArray;
@property(nonatomic)NSMutableDictionary *jsonData;
@property(nonatomic,strong)NSMutableArray *resultArray;

@end
