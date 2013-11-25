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
    NSString* outputDay;
    NSString* outputTime;
}

//@property (nonatomic,retain)KinmDB* dbKinmu;
@property(nonatomic,retain)WorkModel* worksModel;
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
    [day setDateFormat:@"yyyy-MM-dd"];
    [time setDateFormat:@"HH:mm"];
    outputTime = [time stringFromDate:now];
    outputDay = [day stringFromDate:now];
    self.worksModel = [[WorkModel alloc]init];
    self.work = [[Work alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)insertButton:(id)sender {
    
    Work * testWork = [[Work alloc]init];
    testWork.date = outputDay;
    testWork.start = outputTime;
    testWork.end = nil;
    testWork.time_id = 0;
    testWork.rest_id = 0;
    [self.worksModel insertStart:testWork];
    
    
    NSLog(@"insert");
}

- (IBAction)selectButton:(id)sender {
    
    NSLog(@"select");
    [self.worksModel datas];
    
}

- (IBAction)updateButton:(id)sender {
    Work* update = [[Work alloc]init];
    update.end = outputTime;
    [self.worksModel updateEnd:update];
}


-(void)catchSelect:(Work*)days
{

      
    
}


- (IBAction)testBackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
