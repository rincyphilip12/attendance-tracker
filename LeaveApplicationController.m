//
//  ViewController.m
//  LeaveFormAT
//
//  Created by apple on 3/4/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "LeaveApplicationController.h"
#import "LeaveConfirmationController.h"

@interface LeaveApplicationController ()
@property(nonatomic)int tag;


@property (strong, nonatomic) IBOutlet UISegmentedControl *leaveType;
@property (strong, nonatomic) IBOutlet UIButton *fromdate;
@property (strong, nonatomic) IBOutlet UIButton *todate;


@property (strong, nonatomic) IBOutlet UILabel *totalleaves;
@property (strong, nonatomic) IBOutlet UILabel *leavesRemaining;
@property (strong, nonatomic) IBOutlet UILabel *approver;
@property (strong, nonatomic) IBOutlet UILabel *leavesTaken;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UITextField *descriptionField;

- (IBAction)fromdate:(id)sender;
- (IBAction)todate:(id)sender;




@property (strong, nonatomic) IBOutlet UIView *datepickerview;

@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)done:(id)sender;




//- (IBAction)Apply:(id)sender;
//
@end

@implementation LeaveApplicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datepickerview setFrame:CGRectMake(self.view.frame.size.width,self.datepickerview.frame.size.height/2 - self.datepickerview.frame.size.height/2, self.datepickerview.frame.size.width,self.datepickerview.frame.size.height)];
    
    self.totalleaves.text = @"20";
     self.leavesRemaining.text = @"10";
     self.leavesTaken.text = @"10";
     self.approver.text = @"Approved";
    self.status.text = @"onboard";
    self.datepickerview.hidden=YES;
    
    [self.leaveType addTarget:self action:@selector(getLeaveType:) forControlEvents:UIControlEventAllEvents];
    
    // Do any additional setup after loading the view, typically from a nib.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{

    [self.datepickerview setFrame:CGRectMake(self.view.frame.size.width,self.datepickerview.frame.size.height/2 - self.datepickerview.frame.size.height/2, self.datepickerview.frame.size.width,self.datepickerview.frame.size.height)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MM-yyyy"];
    //[df setDateStyle:NSDateFormatterMediumStyle];
    //[df setTimeStyle:NSDateFormatterMediumStyle];
    
    NSString *datestring =[df stringFromDate:self.datepicker.date];
    
    if(self.tag==1)
    {
    self.fromdate.titleLabel.text = datestring;
        self.datepickerview.hidden=YES;
    }
    else if (self.tag==2)
    {
        self.todate.titleLabel.text=datestring;
        self.datepickerview.hidden=YES;

    }

}

- (IBAction)Apply:(id)sender
{
        if ([self.descriptionField.text isEqualToString:@""])
    {
        UIAlertView *view =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Description can not be left blank" delegate:self cancelButtonTitle:@"ok"otherButtonTitles:nil, nil];
        [view show];
    }
  else
  {
      self.leaveData=[self createDictionaryToPass];
      [self performSegueWithIdentifier:@"confirmLeave" sender:nil];
      
  }
    
}

-(NSMutableDictionary *)createDictionaryToPass
{
    NSMutableDictionary *dict=[@{@"leave_type":self.leaveTypeData,
                         @"from_date":self.fromdate.titleLabel.text,
                         @"to_date":self.todate.titleLabel.text,
                         @"total_no_of_leaves":self.totalleaves.text,
                         @"no_of_leaves_remaining":self.leavesRemaining.text,
                         @"description":self.descriptionField.text,
                         @"approver":self.approver.text,
                         @"no_of_leaves_taken":self.leavesTaken.text,
                         @"status":self.status.text
                         }mutableCopy];
   
    return dict;
}

-(void)getLeaveType:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex==0)
    {
        self.leaveTypeData=@"Sick";
    }
    else if (sender.selectedSegmentIndex==1)
    {
        self.leaveTypeData=@"Personal";
    }
    else if (sender.selectedSegmentIndex==2)
    {
        self.leaveTypeData=@"Vacation";
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LeaveConfirmationController *controller =(LeaveConfirmationController *)segue.destinationViewController;
    controller.dictToPass=self.leaveData;
   

   
}

    

    

- (IBAction)fromdate:(id)sender
{
    self.tag=1;
    self.datepickerview.hidden=NO;
    self.datepickerview.backgroundColor=[UIColor whiteColor];
    [UIView animateWithDuration:1 animations:^{
        self.datepickerview.center = self.view.center;
        self.view.backgroundColor = [UIColor blackColor];
        
    }];
}

- (IBAction)todate:(id)sender
{
    self.tag=2;
    self.datepickerview.hidden=NO;
    self.datepickerview.backgroundColor=[UIColor whiteColor];
    [UIView animateWithDuration:1 animations:^{
        self.datepickerview.center = self.view.center;
        self.view.backgroundColor = [UIColor blackColor];
        
    }];
}
@end
