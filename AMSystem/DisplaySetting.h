//
//  DisplaySetting.h
//  AMSystem
//
//  Created by わたる on 13/10/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplaySetting : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *startTime;

@property (weak, nonatomic) IBOutlet UITextField *endTime;


@property (weak, nonatomic) IBOutlet UITextField *startRest;
@property (weak, nonatomic) IBOutlet UITextField *endRest;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *donePicker;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelPicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;

- (IBAction)datePickerDone:(UIBarButtonItem *)sender;

//テキストフィールドをタップしたとき
- (IBAction)textFieldClicked:(UITextField *)sender;

//完了ボタンをタップしたときダイアログを表示する
- (IBAction)confirmButton:(id)sender;

- (IBAction)changeDatePicker:(id)sender;



@end
