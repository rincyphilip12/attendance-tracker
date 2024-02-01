//
//  DayViewController.m
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import "DayViewController.h"

@interface DayViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *monthPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *dayPicker;
@property (strong, nonatomic) IBOutlet UILabel *numOfWorkingHours;
@property (strong, nonatomic) IBOutlet UILabel *numOfHoursWorked;
@property (strong, nonatomic) IBOutlet UILabel *entryTime;
@property (strong, nonatomic) IBOutlet UILabel *exitTime;
@property (strong, nonatomic) IBOutlet UILabel *leaveType;
@property (strong, nonatomic) IBOutlet UILabel *status;

@end

@implementation DayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.monthArray=[@[@"?",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"] mutableCopy];
    self.dayArray=[@[@"1",@"2",@"3"]mutableCopy];
    self.monthPicker.dataSource=self;
    self.monthPicker.delegate=self;
    self.dayPicker.dataSource=self;
    self.dayPicker.delegate=self;

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView==self.monthPicker)
        return 1;
    else
        return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==self.monthPicker)
    {
        return [self.monthArray count];
        
    }
    else if (pickerView==self.dayPicker && self.dayArray != nil)
    {
        return [self.dayArray count];
    }
    return 1;
    
    
}
//to fetch the data from array to pickerview
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSLog(@"Row is %lu  and component is  %ld",row,component);
    if(pickerView==self.monthPicker)
    {
        NSString *rowTitle;
        rowTitle=[self.monthArray objectAtIndex:row];
               return rowTitle;
    }
    else if (pickerView==self.dayPicker)
    {
        NSString *rowTitle;
        rowTitle=[self.dayArray objectAtIndex:row];
        return rowTitle;
    }
    return @"";
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==self.monthPicker)
    {
        
        self.month=[self.monthArray objectAtIndex:row];
        self.dayArray=[self getDayArrayWithMonth:self.month];
        [self.dayPicker reloadAllComponents];
    }
    else if (pickerView==self.dayPicker)
    {
        self.day=[self.dayArray objectAtIndex:row];
    }
    
    
    if([self.month isEqualToString:@"?"] || self.month == nil)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Select Month First" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    else if (self.month != nil && self.day !=nil)
    {
        NSDictionary *dataInput = @{@"emp_id":@"357761",@"month":self.month,@"day":self.day};
        
        
        NSError *errorjs;
        NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:dataInput options:NSJSONWritingPrettyPrinted error:&errorjs];
        NSLog(@"Data input-%@",dataInput);
        
        NSURL *url=[NSURL URLWithString:@"http://10.251.71.46:8088/MFRPServices/get_attendance_leave_detail"];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:jsonInputData];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError) {
            
            if ([(NSHTTPURLResponse *) response statusCode] == 200)
            {
                //                NSLog(@"---------------");
                //                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                //                //NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                
                self.jsonData = [NSJSONSerialization
                                 JSONObjectWithData:urlData
                                 options:kNilOptions
                                 error:&error];
                NSLog(@"%@",self.jsonData);
                self.resultArray=[self.jsonData objectForKey:@"results"];
if([[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_leaves"]] isEqualToString:@"0"])
{
    self.numOfWorkingHours.text=@"8";
    self.numOfHoursWorked.text=@"8";
    self.entryTime.text=@"9:00 AM";
    self.exitTime.text=@"6:00 PM";
    self.leaveType.text=@"No Leave";
    self.status.text=@"Good";
    
}
                else if ([[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_leaves"]] isEqualToString:@"1"])
                {
                    self.numOfWorkingHours.text=@"8";
                    self.numOfHoursWorked.text=@"0";
                    self.entryTime.text=@"-";
                    self.exitTime.text=@"-";
                    self.leaveType.text=@"Personal Leave";
                    self.status.text=@"Poor";
                }
    
            } }];
    
    }
}
-(NSMutableArray *)getDayArrayWithMonth:(NSString *)month
{
    NSMutableArray *day;
    if([month isEqualToString:@"January"] || [month isEqualToString:@"March"] || [month isEqualToString:@"May"]|| [month isEqualToString:@"July"] || [month isEqualToString:@"August"] || [month isEqualToString:@"October"] || [month isEqualToString:@"December"])
    {
        day=[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]mutableCopy];
    }
    else if ([month isEqualToString:@"April"] || [month isEqualToString:@"June"] || [month isEqualToString:@"September"] || [month isEqualToString:@"November"])
    {
        day=[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"]mutableCopy];
    }
    else if ([month isEqualToString:@"February"])
    {
        day=[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28"]mutableCopy];
    }
    return day;
}

@end
