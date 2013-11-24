//
//  TopViewController.m
//  AMSystem
//
//  Created by ブロス on 13/11/16.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "TopViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#define START 0
#define END 1
#define ERROR 2



@interface TopViewController ()


@end

@implementation TopViewController

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
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(driveClock:)
                                   userInfo:nil
                                    repeats:YES];
    [self.topButton setTitle:@"始業"forState:UIControlStateNormal];
}

//初期化処理


//現在時刻と日時を表示
-(void)driveClock:(NSTimer *)timer
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *timesOutputFomatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *daysOutputFomatter = [[NSDateFormatter alloc]init];
    [timesOutputFomatter setDateFormat:@"HH:mm:ss"];
    [daysOutputFomatter setDateFormat:@"MM月dd日"];
    NSString *strNow =[timesOutputFomatter stringFromDate:todayDate];
    NSString *daysStr = [daysOutputFomatter stringFromDate:todayDate];
    _timeLavel.text = strNow;
    _dayLavel.text = daysStr;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)pushButton:(id)sender {
    UIAlertView *alert;
    if(self.view.tag == START){
        //アラートビューの作成と設定
        alert =[[UIAlertView alloc]
                             initWithTitle:@"始業確認"
                             message:@"始業してもよろしいですか？"
                             delegate:self
                             cancelButtonTitle:@"キャンセル"otherButtonTitles:nil];
        [alert addButtonWithTitle:@"OK"];
    }else if(self.view.tag == END){
        alert =[[UIAlertView alloc]
                             initWithTitle:@"就業確認"
                             message:@"就業してもよろしいですか？"
                             delegate:self
                             cancelButtonTitle:@"キャンセル"otherButtonTitles:nil];
        [alert addButtonWithTitle:@"OK"];
    }else{
        alert =[[UIAlertView alloc]
                             initWithTitle:@"エラー"
                             message:@"これ以上入りません"
                             delegate:self
                             cancelButtonTitle:@"戻ります"otherButtonTitles:nil];
    }
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex){
        case 0:
            NSLog(@"%@",@"1番目");
            break;
        case 1:
            NSLog(@"%@",@"2番目");
            //データベース利用
            if(self.view.tag == START){
                
                [self.topButton setTitle:@"終業"forState:UIControlStateNormal];
                self.view.tag = END;
            }else if(self.view.tag == END){
                [self.topButton setTitle:@"始業"forState:UIControlStateNormal];
                
                self.view.tag = ERROR;
            }else{
                NSLog(@"%@",@"もう入りません");
            }
            break;
    }
}
@end
