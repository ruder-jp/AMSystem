//
//  TestInsertViewController.m
//  AMSystem
//
//  Created by ブロス on 13/11/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "TestInsertViewController.h"
#import "daoWorks.h"



@interface TestInsertViewController ()
//@property (nonatomic,retain)KinmDB* dbKinmu;



@end

@implementation TestInsertViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertButton:(id)sender {
    
    NSLog(@"insert");
}

- (IBAction)selectButton:(id)sender {
    NSLog(@"select");
}
@end
