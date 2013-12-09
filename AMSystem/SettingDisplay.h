//
//  SettingDisplay.h
//  AMSystem
//

//  Created by わたる on 13/12/08.

//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingDisplay : UITableViewController <UITextFieldDelegate,UIGestureRecognizerDelegate> {
    UIDatePicker *picker;
    UITextField *passTextFld;
}

//どのテキストがタップしたか検出する変数
@property (weak, nonatomic) UITextField *whichText;

- (IBAction)hidePickerRecognized:(id)sender;

- (IBAction)confirmButton:(id)sender;

@end
