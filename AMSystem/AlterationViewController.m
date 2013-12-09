//
//  AlterationViewController.m
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "AlterationViewController.h"
#import "KinmuViewController.h"

@interface AlterationViewController ()

@end

@implementation AlterationViewController

@synthesize delegate, date;

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
    NSString * i = self.date[1];
    
    NSLog(@"%@",i);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
