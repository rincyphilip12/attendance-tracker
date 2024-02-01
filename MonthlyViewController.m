//
//  MothlyViewController.m
//  TabController(MFRP)
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import "MonthlyViewController.h"

@interface MonthlyViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *monthPicker;
@property (strong, nonatomic) IBOutlet UILabel *numOfWorkingDays;
@property (strong, nonatomic) IBOutlet UILabel *numOfDaysWorked;
@property (strong, nonatomic) IBOutlet UILabel *numOfPublicHoliday;
@property (strong, nonatomic) IBOutlet UILabel *numOfLeaves;
@property (strong, nonatomic) IBOutlet UILabel *avgWorkingHours;
@property (strong, nonatomic) IBOutlet UILabel *status;


@end

@implementation MonthlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray=[@[@"?",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"] mutableCopy];
    
    self.monthPicker.dataSource=self;
    self.monthPicker.delegate=self;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
        return [self.dataArray count];
    

}
//to fetch the data from array to pickerview
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSLog(@"Row is %lu  and component is  %ld",row,component);
    
    NSString *rowTitle;
        rowTitle=[self.dataArray objectAtIndex:row];return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *dataInput = @{@"emp_id":@"357761",@"month":[self.dataArray objectAtIndex:row]};
    
    NSError *errorjs;
    NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:dataInput options:NSJSONWritingPrettyPrinted error:&errorjs];
    
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
            NSLog(@"---------------");
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            
            self.jsonData = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:kNilOptions
                             error:&error];
            NSLog(@"%@",self.jsonData);
            //self.resultArray=self.jsonData;
            self.resultArray=[self.jsonData objectForKey:@"results"];
            NSLog(@"Results array:-%@",self.resultArray);
            NSLog(@"%@",self.resultArray[0]);
            self.numOfWorkingDays.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_working_days"]];
            self.numOfDaysWorked.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_working_days_worked"]];
            self.numOfPublicHoliday.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_public_holiday"]];
            self.numOfLeaves.text=[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"no_of_leaves"]];
            self.status.text=@"On-Board";
        self.avgWorkingHours.text=@"8";
 
        } }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
