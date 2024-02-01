//
//  LeaveConfirmationController.m
//  LeaveFormAT
//
//  Created by apple on 3/5/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "LeaveConfirmationController.h"


@interface LeaveConfirmationController ()
@property (strong, nonatomic) IBOutlet UILabel *leaveTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
- (IBAction)applyLeave:(id)sender;
- (IBAction)cancelLeave:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation LeaveConfirmationController



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load called");

 
    
    self.leaveTypeLabel.text=[self.dictToPass valueForKey:@"leave_type"];
    self.fromLabel.text=[self.dictToPass valueForKey:@"from_date"];
    self.toLabel.text=[self.dictToPass valueForKey:@"to_date"];
    self.descLabel.text=[self.dictToPass valueForKey:@"description"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)applyLeave:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [formatter dateFromString:self.fromLabel.text];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newDate = [formatter stringFromDate:date];
    NSLog(@"date is :-%@",newDate);
   
    NSDictionary *d = @{@"emp_id":@"358162",@"leave_date":newDate,@"leave_type":self.leaveTypeLabel.text};
    
    NSLog(@"%@",d);
    
    NSError *errorjs;
    NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:&errorjs];
    NSLog(@"input error %@",errorjs);
    NSURL *url=[NSURL URLWithString:@"http://10.251.71.46:8088/MFRPServices/apply_leave_detail"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:jsonInputData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError)
     {
         NSLog(@"error-%@",connectionError);
         if(!connectionError)
         {
             if ([(NSHTTPURLResponse *) response statusCode] == 200)
             {
                 NSLog(@"---------------");
                 
                 NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"Response ==> %@", responseData);
                 
                 NSError *error = nil;
                 
                 self.jsonData = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
                 
                 NSLog(@"%@",self.jsonData);
                 
                 
                 self.resultArray=[self.jsonData objectForKey:@"results"];
                 if([[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"message"]] isEqualToString:@"Leave saved in the Database"])
                     
                     
                 {
                     NSLog(@"Inside success");
                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Leave Applied" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                     [alert show];
                 }
                 
                 else  if([[NSString stringWithFormat:@"%@",[self.resultArray[0] valueForKey:@"message"]] isEqualToString:@"Leave not saved in the Database"])
                 {
                     NSLog(@"Inside failure");
                     
                     
                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Unable to apply leave" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                     [alert show];
                     
                 }
             }
             
         }
         
     }];

}

- (IBAction)cancelLeave:(id)sender {
}
@end
