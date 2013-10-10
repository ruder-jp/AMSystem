//
//  ViewController.h
//  AMSystem
//
//  Created by Maeda Ryoto on 13/07/01.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smMenuViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface ViewController : UIViewController
{
    @private
    BOOL isRevealed;
    UIViewController *contentController;

}

-(void)toggleMenuController;


//就業時間の表示
@property (weak, nonatomic) IBOutlet UILabel *startTime;

@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UIButton *topButton;

- (IBAction)bushButton:(id)sender;


//時計の表示

@property (weak, nonatomic) IBOutlet UILabel *dayLavel;
@property (weak, nonatomic) IBOutlet UILabel *timeLavel;
//サイドメニュー



//勤務表



@end
