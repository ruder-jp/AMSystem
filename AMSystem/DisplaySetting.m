//
//  DisplaySetting.m
//  AMSystem
//
//  Created by わたる on 13/10/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "DisplaySetting.h"
#import "TimeModel.h"
#import "RestModel.h"
#import "Time.h"
#import "Rest.h"


@interface DisplaySetting ()
@property (nonatomic, retain) TimeModel*            timeModel; //! 勤務時間設定を管理するオブジェクト
@property (nonatomic, retain) RestModel*            restModel; //! 休憩時間設定を管理するオブジェクト


@property (nonatomic, retain) Time*
time;     //! 編集対象となる勤務時間

@property (nonatomic, retain) Rest*
rest;     //! 編集対象となる休憩時間

@end

@implementation DisplaySetting

@synthesize time,rest;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize startRest = _startRest;
@synthesize endRest = _endRest;


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
    
    picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.frame = CGRectMake(0, self.view.frame.size.height, 320, 216);
    [picker addTarget:self
               action:@selector(datePicker_ValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    //picker.showsSelectionIndicator = YES;
    //picker.delegate = self;
    //picker.dataSource = self;
    [self.view addSubview:picker];
    
    //    toolbar = [[UIToolƒbar alloc] init];
    //    toolbar.frame = CGRectMake(0, 500, 320, 216);
    //    [self.view addSubview:toolbar];
    
    
    
    
    _startTime.delegate = self;
    _endTime.delegate = self;
    _startRest.delegate = self;
    _endRest.delegate = self;
    
    
    
    
}

/**
 * View が破棄される時に発生します。
 */
- (void)viewDidUnload
{
    
	self.timeModel = nil;
    self.restModel = nil;
    
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
    
    self.timeModel = [[TimeModel alloc] init];
    self.restModel = [[RestModel alloc] init];
    
    Time* timeObject = [self.timeModel setting];
    Rest* restObject = [self.restModel setting];
    NSLog(@"%@",restObject.start);
    
    self.startTime.text = timeObject.start;
    self.endTime.text = timeObject.end;
    self.startRest.text = restObject.start;
    self.endRest.text = restObject.end;
    
    
}

- (void)showPicker {
	//ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, self.view.frame.size.height - picker.frame.size.height, 320, 216);

	[UIView commitAnimations];
}

- (void)hidePicker {
	//ピッカーを下に隠すアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, self.view.frame.size.height, 320, 216);
	[UIView commitAnimations];
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



//デートピッカーの値が変更されたときの処理
//※最終的にはDoneをタップしたときこの処理を行いたい
- (IBAction)changeDatePicker:(id)sender {
    
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    //指定した日付形式で日付を表示する
    _whichText.text = [df stringFromDate:_myDatePicker.date];
    
    
}



//完了ボタンの処理
- (IBAction)confirmButton:(id)sender {
    [self hidePicker];
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"保存しますか？";
    [alert addButtonWithTitle:@"キャンセル"];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    
}





- (IBAction)backButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}






//完了ボタンを押して表示させるアラートビューの詳細
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //キャンセルボタンがタップされたときの処理
            break;
        case 1:
            //OKボタンがタップされたときの処理
            //NSString*  insert = @"INSERT INTO kinmu (day,start,end) VALUES (?,?,?)";
            
            //[_timeModel noteJudgment];
            
            
        {
            
            Time* newTime = [[Time alloc] init];
            Rest* newRest = [[Rest alloc] init];
            //newTime.start = self.startTime.text;
            newTime.start = self.startTime.text;
            newTime.end   = self.endTime.text;
            newRest.start = self.startRest.text;
            newRest.end   = self.endRest.text;
            if([_timeModel noteJudgment]){
                [_timeModel insert:newTime];
            }else{
                [_timeModel update:newTime];
            }
            if([_restModel noteJudgment]){
                [_restModel insert:newRest];
            }else{
                [_restModel update:newRest];
            }
            
            
        }
            break;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"てきすとおおお");
    //テキストフィールドの編集を始めるときに、ピッカーを呼び出す。
    _whichText = textField;
    
    //テキストフィールドに設定している時間をデートピッカーの初期時間に設定する
    NSDate *convertDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    //nullは許されてない
    convertDate = [dateFormatter dateFromString:_whichText.text];
    if(convertDate != nil){
        picker.date = convertDate;
    }
    [self showPicker];
    
    //キーボードは表示させない
    return NO;
}


/**
 * 日付ピッカーの値が変更されたとき
 */
- (void)datePicker_ValueChanged:(id)sender
{
    //UIDatePicker *datePicker = sender;
    
    
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    
    //指定した日付形式で日付を表示する
    _whichText.text = [df stringFromDate:picker.date];
    
    
}
- (IBAction)hidePickerRecognized:(id)sender {
    [self hidePicker];
}

@end