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
#import "WorkModel.h"
#import "Work.h"

#define START 0
#define END 1
#define ERROR 2

@interface TopViewController ()
{
    NSString* insertTime;
    NSString* insertDay;
}

@property(nonatomic,retain)WorkModel* worksModel;
@property(nonatomic,retain)Work* work;
@end

@implementation TopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

-(void)viewDidAppear:(BOOL)animated
{
    self.worksModel = [[WorkModel alloc]init];
    self.work = [[Work alloc]init];
    [self passDate];
    
    NSArray* array = [self.worksModel monthDate];
    int count = [array count];
    for(int i=0;i < count;i++){
        Work* tmp = array[i];
        
        BOOL dateTest = [tmp.date isEqualToString:insertDay];
        if(dateTest == YES)
        {
            if(tmp.start != nil && tmp.end == nil)
            {
                _startLavel.text = tmp.start;
                _endLavel.text = nil;
                self.view.tag = END;
            }else{
                _startLavel.text = tmp.start;
                _endLavel.text = tmp.end;
                self.view.tag = ERROR;
            }
            
        }else{
            _startLavel.text = nil;
            _endLavel.text = nil;
            self.view.tag = START;
        }
    }
    [super viewDidAppear:animated];
}

-(void)passDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *insertDayFomatter = [[NSDateFormatter alloc]init];
    [insertDayFomatter setDateFormat:@"yyyy-MM-dd"];
    insertDay = [insertDayFomatter stringFromDate:todayDate];
}

//現在時刻と日時を表示
-(void)driveClock:(NSTimer *)timer
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *insertDayFomatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *insertTimeFomatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *timesOutputFomatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *daysOutputFomatter = [[NSDateFormatter alloc]init];
    [insertDayFomatter setDateFormat:@"yyyy-MM-dd"];
    [insertTimeFomatter setDateFormat:@"HH:mm"];
    [timesOutputFomatter setDateFormat:@"HH:mm:ss"];
    [daysOutputFomatter setDateFormat:@"MM月dd日"];
    insertDay = [insertDayFomatter stringFromDate:todayDate];
    insertTime = [insertTimeFomatter stringFromDate:todayDate];
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
                             initWithTitle:@"終業確認"
                             message:@"終業してもよろしいですか？"
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
            break;
        case 1:
            //データベース利用
            if(self.view.tag == START){
                [self insert];
                _startLavel.text = insertTime;
                [self.topButton setTitle:@"終業"forState:UIControlStateNormal];
                self.view.tag = END;
            }else if(self.view.tag == END){
                [self update];
                _endLavel.text = insertTime;
                [self.topButton setTitle:@"始業"forState:UIControlStateNormal];
                self.view.tag = ERROR;
            }
            break;
    }
}

-(void)insert
{
    Work* useWork =[[Work alloc]init];
    useWork.date = insertDay;
    useWork.start = insertTime;
    useWork.end = nil;
    useWork.time_id = 0;
    useWork.rest_id = 0;
    [self.worksModel insertStart:useWork];
}

-(void)update
{
    Work* update = [[Work alloc]init];
    update.end = insertTime;
    [self.worksModel updateEnd:update];
}
@end
