//
//  AlterationViewController.h
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KinmuViewController.h"

@class KinmuViewController;

@class Work;

@protocol EditWorkDelegate
@end

@interface AlterationViewController : UIViewController<UITextFieldDelegate>
{
    UIDatePicker *picker;
}

@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *startRest;
@property (weak, nonatomic) IBOutlet UITextField *endRest;

//どのテキストがタップしたか検出する変数
@property (weak, nonatomic) UITextField *whichText;

@property (nonatomic, assign) id<EditWorkDelegate> delegate; //! 書籍の追加、または編集画面が完了したことを通知するデリゲート
- (IBAction)hidePickerRecognized:(id)sender;

@property (nonatomic, retain) NSArray*  date;
@property (nonatomic, retain)Work* work;

- (IBAction)hidePickerRecognized:(id)sender;
@end
