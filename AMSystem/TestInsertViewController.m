//
//  TestInsertViewController.m
//  AMSystem
//
//  Created by ブロス on 13/11/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "TestInsertViewController.h"
#import "daoWorks.h"
#import "Work.h"


@interface TestInsertViewController ()
{
    NSString *outputDay;
    NSString *outputTime;
    
}

//@property (nonatomic,retain)KinmDB* dbKinmu;
@property(nonatomic,retain)daoWorks* daoWorks;
@property(nonatomic,retain)Work* work;
@end

@implementation TestInsertViewController

@synthesize work;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    
    NSDate *now = [NSDate date];
    [day setDateFormat:@"yyyy/MM/dd"];
    [time setDateFormat:@"HH:mm"];
    
    //String型に変換
    outputDay = [day stringFromDate:now];
    outputTime = [time stringFromDate:now];
    
    
    self.daoWorks = [[daoWorks alloc]init];
    self.work = [[Work alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertButton:(id)sender {
    
    Work * testWork = [[Work alloc]init];
    testWork.dayId = nil;
    testWork.startTime = outputDay;
    testWork.endTime = outputTime;
    testWork.startRest = nil;
    testWork.endRest = nil;
    [self.daoWorks insertStart:testWork];
    
    
    NSLog(@"insert");
}

- (IBAction)selectButton:(id)sender {
    
    NSLog(@"select");
    [self.daoWorks datas];
    
//    NSMutableArray* testArray = [self.datas = ]
    
    
    //    NSLog(@"%@",[self.daoWorks datas]);
}

-(void)catchSelect:(Work*)days
{

      
    
}


- (IBAction)testBackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
