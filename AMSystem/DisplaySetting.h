//
//  DisplaySetting.h
//  AMSystem
//
//  Created by わたる on 13/10/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DisplaySetting : UIViewController <UITextFieldDelegate>
{
    UIDatePicker *picker;
    
    //UIToolbar *toolbar;
}

//テキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *startRest;
@property (weak, nonatomic) IBOutlet UITextField *endRest;

//どのテキストがタップしたか検出する変数
@property (weak, nonatomic) UITextField *whichText;

//テキストフィールドをタップしたとき
- (IBAction)textFieldClicked:(UITextField *)sender;



//ツールバー
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donePicker;
- (IBAction)datePickerDone:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelPicker;

//デートピッカー
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;

//デートピッカーの値が変更されたとき
- (IBAction)changeDatePicker:(id)sender;

//- (IBAction)hidePickerRecognized:(id)sender;

//完了ボタンをタップしたときダイアログを表示する
- (IBAction)confirmButton:(id)sender;


- (IBAction)backButton:(id)sender;


@end
