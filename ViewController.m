//
//  ViewController.m
//  Swipe
//
//  Created by apple on 3/9/15.
//  Copyright (c) 2015 Cognizant. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *swipeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.swipeLabel setUserInteractionEnabled:YES];
    swipeUpGestureRecognizer.delegate=self;
    swipeUpGestureRecognizer.numberOfTouchesRequired=1;
    [self.swipeLabel addGestureRecognizer:swipeUpGestureRecognizer];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleSwipeUpFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"swiped");
    [self performSegueWithIdentifier:@"next" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
