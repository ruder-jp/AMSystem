//
//  MenuViewController.m
//  AMSystem
//
//  Created by ブロス on 13/12/04.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

-(id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        
//        _rows = [NSMutableArray arrayWithCapacity:10];
//        
//        MenuRow *menuRow;
//        
//        menuRow = [[MenuRow alloc] init];
//        menuRow.viewControllerClass = [TestViewController class];
//        [_rows addObject:menuRow];
        
    }
    return self;

}

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


- (IBAction)backButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
