//
//  AlterationViewController.m
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "AlterationViewController.h"

#import "TimeModel.h"
#import "RestModel.h"
#import "Time.h"
#import "Rest.h"
#import "WorkModel.h"
#import "Work.h"
#import "KinmuViewController.h"


@interface AlterationViewController ()

@property (nonatomic, retain) RestModel*            restModel; //! 休憩時間設定を管理するオブジェクト
@property (nonatomic, retain) Time*                time;     //! 編集対象となる書籍
@property (nonatomic, retain) WorkModel* worksmodel;
@property (nonatomic, retain) Work*      works;


@end

@implementation AlterationViewController

@synthesize delegate,date;

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
    
    self.worksmodel = [[WorkModel alloc]init];
    self.works = [[Work alloc]init];
    
    
    picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.frame = CGRectMake(0, self.view.frame.size.height, 320, 216);
    [picker addTarget:self
               action:@selector(datePicker_ValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:picker];
    
    
    _startTime.delegate = self;
    _endTime.delegate = self;
    _startRest.delegate = self;
    _endRest.delegate = self;
	// Do any additional setup after loading the view.
    NSLog(@"%@",date[0]);
    
    //_authorTextField.text     = self.book.author;
    NSArray* dateArray = [self.worksmodel datas:date[0]];
    int count = [dateArray count];
    for(int i = 0; i < count;i++)
    {
        Work* tmp = dateArray[i];
        _startTime.text = tmp.start;
        _endTime.text = tmp.end;
    }
    if( self.work )
	{
		_startTime.text      = self.work.start;
		_endTime.text     = self.work.end;
	}

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.restModel = [[RestModel alloc] init];
    
    Rest* restObject = [self.restModel setting];
    NSLog(@"%@",restObject.start);
    _startRest.text = restObject.start;
    _endRest.text = restObject.end;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 完了ボタンが押された時に発生します。
 *
 * @param sender 送信者データ。
 */
- (void)done:(id)sender
{
	Work* newWork = [[Work alloc] init];
	newWork.day_id    = self.work.day_id;
	newWork.start     = _startTime.text;
	newWork.end    = _endTime.text;
	//newWork.copyright = _copyrightDatePicker.date;
    
	if( self.work )
	{
    
//		[self.delegate editWorkDidFinish:self.work newWork:newWork];
	}
	else
	{
//		[self.delegate addWorkDidFinish:newWork];
	}
}

- (void)checkDone
{
	self.navigationItem.rightBarButtonItem.enabled = ( _startTime.text.length > 0 && _endTime.text.length > 0 );
}

- (void)showPicker {
	//ピッカーが下から出るアニメーション
    NSLog(@"しょうぴっかー");
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

- (IBAction)hidePickerRecognized:(id)sender {
    [self hidePicker];
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
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    
    //指定した日付形式で日付を表示する
    _whichText.text = [df stringFromDate:picker.date];
    
    
}
@end
