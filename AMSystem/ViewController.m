//
//  ViewController.m
//  AMSystem
//
//  Created by Maeda Ryoto on 13/07/01.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(driveClock:)
                                   userInfo:nil
                                    repeats:YES];
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    [day setDateFormat:@"MM月dd日"];
    
    NSString *dayStr = [day stringFromDate:now];;
    self.dayLavel.text = dayStr;
}

- (void)driveClock:(NSTimer *)timer
{
    NSDate *today = [NSDate date];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    int hour = [todayComponents hour];
    int min = [todayComponents minute];
    int sec = [todayComponents second];
    
    self.timeLavel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec]; //時間を表示
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
