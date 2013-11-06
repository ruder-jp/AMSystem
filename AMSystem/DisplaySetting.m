//
//  DisplaySetting.m
//  AMSystem
//
//  Created by わたる on 13/10/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "DisplaySetting.h"
#import "daoWorks.h"
#import "Work.h"

@interface DisplaySetting ()
@property (nonatomic, retain) daoWorks*            daoWorks; //! 勤務設定を管理するオブジェクト


@property (nonatomic, retain) Work*
work;     //! 編集対象となる書籍

@end

@implementation DisplaySetting

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
	// Do any additional setup after loading the view.
    
    self.daoWorks = [[daoWorks alloc] init];
	self.work    = [[Work alloc] init];

}

/**
 * View が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    
	self.daoWorks = nil;
	self.work    = nil;
    
	[super viewDidUnload];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
//    CGRect datePickerFrame = self.myDatePicker.frame;
//    CGRect toolBarFrame = self.toolBar.frame;
//    toolBarFrame.origin.y = self.view.frame.size.height;
//    datePickerFrame.origin.y = self.view.frame.size.height + self.toolBar.frame.size.height;
//    self.myDatePicker.frame = datePickerFrame;
//    self.toolBar.frame = toolBarFrame;
    
    
}


- (IBAction)datePickerDone:(UIBarButtonItem *)sender {
    //ツールバーを引っ込める
    CGRect toolBarFrame = self.toolBar.frame;
    toolBarFrame.origin.y = self.view.frame.size.height;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         _toolBar.frame = toolBarFrame;
                     }];

    //DatePickerを引っ込める
    CGRect datePickerFrame = self.myDatePicker.frame;
    datePickerFrame.origin.y = self.view.frame.size.height + self.toolBar.frame.size.height;
    
    
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         _myDatePicker.frame = datePickerFrame;
                     }];

}

//テキストフィールドをタップしたときの処理
- (IBAction)textFieldClicked:(UITextField *)sender {
    
    //どのテキストフィールドがタップしたのか検出する
    _whichText = sender;
    
    //テキストフィールドをタップしたときキーボードを非表示にする
    [sender resignFirstResponder];
    
    //ツールバーをにょわっと表示させる
    CGRect toolBarFrame = self.toolBar.frame;
    toolBarFrame.origin.y = self.view.frame.size.height - _toolBar.frame.size.height;
    
    //myDatePickerをにょわっと表示させる
    CGRect datePickerFrame = self.myDatePicker.frame;
    datePickerFrame.origin.y
    = self.view.frame.size.height - _myDatePicker.frame.size.height;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         _toolBar.frame = datePickerFrame;
                     }];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         _myDatePicker.frame = datePickerFrame;
                     }];
}

//デートピッカーの値が変更されたときの処理
//※最終的にはDoneをタップしたときこの処理を行いたい
- (IBAction)changeDatePicker:(id)sender {
    
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    //指定した日付形式で日付を表示する
    _whichText.text = [df stringFromDate:self.myDatePicker.date];
    
    
}


//完了ボタンの処理
- (IBAction)confirmButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"保存しますか？";
    [alert addButtonWithTitle:@"キャンセル"];
    [alert addButtonWithTitle:@"OK"];
    [alert show];

}



//完了ボタンを押して表示させるアラートビューの詳細
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //キャンセルボタンがタップされたときの処理
            NSLog(@"キャンセル！");
            break;
        case 1:
            //OKボタンがタップされたときの処理
            //NSString*  insert = @"INSERT INTO kinmu (day,start,end) VALUES (?,?,?)";
        {
            Work* newWork = [[Work alloc] init];
            newWork.dayId     = 0;
            newWork.startTime = self.startTime.text;
            newWork.endTime   = self.endTime.text;
            newWork.startRest = self.startRest.text;
            newWork.endRest   = self.endRest.text;
            [self.daoWorks update:newWork];
        }
            break;
    }

}


@end
