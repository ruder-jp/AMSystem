//
//  TestInsertViewController.m
//  AMSystem
//
//  Created by ブロス on 13/11/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "TestInsertViewController.h"
#import "WorkModel.h"
#import "Work.h"


@interface TestInsertViewController ()
{
    NSInteger outputDay;
    NSInteger outputTime;
    
}

//@property (nonatomic,retain)KinmDB* dbKinmu;
@property(nonatomic,retain)WorkModel* daoWorks;
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
    
    
//    outputDay =[outputDay intForC now;
//    outputTime = [time intFromDate:now];
    
    
    self.daoWorks = [[WorkModel alloc]init];
    self.work = [[Work alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertButton:(id)sender {
    
    Work * testWork = [[Work alloc]init];
    testWork.date = nil;
    testWork.start = outputDay;
    testWork.end = outputTime;
    testWork.time_id = nil;
    testWork.rest_id = nil;
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
