//
//  WeeklyViewController.m
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import "WeeklyViewController.h"

@interface WeeklyViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *monthPickerView;

@property (strong, nonatomic) IBOutlet UIPickerView *weekPicker;
@property (strong, nonatomic) IBOutlet UILabel *numOfWorkingDays;
@property (strong, nonatomic) IBOutlet UILabel *numOfDaysWorked;
@property (strong, nonatomic) IBOutlet UILabel *numOfPublicHolidays;
@property (strong, nonatomic) IBOutlet UILabel *numOfLeaves;

@property (strong, nonatomic) IBOutlet UILabel *avgWorkingHours;
@property (strong, nonatomic) IBOutlet UILabel *status;

@end

@implementation WeeklyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.monthArray=[@[@"?",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"] mutableCopy];
    self.weekArray=[@[@"?",@"week1",@"week2",@"week3",@"week4"]mutableCopy];
    
    self.monthPickerView.dataSource=self;
    self.monthPickerView.delegate=self;
    self.weekPicker.dataSource=self;
    self.weekPicker.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView==self.monthPickerView)
    return 1;
    else
        return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==self.monthPickerView)
    {
    return [self.monthArray count];
        
    }
    else if (pickerView==self.weekPicker)
    {
        return [self.weekArray count];
    }
    return 1;
    
    
}
//to fetch the data from array to pickerview
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSLog(@"Row is %lu  and component is  %ld",row,component);
    if(pickerView==self.monthPickerView)
    {
    NSString *rowTitle;
    rowTitle=[self.monthArray objectAtIndex:row];
        return rowTitle;
    }
    else if (pickerView==self.weekPicker)
    {
        NSString *rowTitle;
        rowTitle=[self.weekArray objectAtIndex:row];
        return rowTitle;
    }
    return @"";
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   if(pickerView==self.monthPickerView)
   {
       
       self.month=[self.monthArray objectAtIndex:row];
   }
    else if (pickerView==self.weekPicker)
    {
        self.week=[self.weekArray objectAtIndex:row];
    }
    
    
    if([self.month isEqualToString:@"?"] || self.month == nil)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Select Month First" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
    else if (self.month != nil && self.week !=nil)
    {
        NSDictionary *dataInput = @{@"emp_id":@"357761",@"month":self.month,@"week":self.week};
        
        
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
               // NSLog(@"Results array:-%@",self.resultArray);
               
                self.numOfWorkingDays.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_working_days"]];
                self.numOfDaysWorked.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_working_days_worked"]];
                self.numOfPublicHolidays.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_public_holiday"]];
                self.numOfLeaves.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_leaves"]];
                self.status.text=@"On-Board";
                self.avgWorkingHours.text=@"8";
                
            } }];

    }
}


@end
