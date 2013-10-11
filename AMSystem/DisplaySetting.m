//
//  DisplaySetting.m
//  AMSystem
//
//  Created by わたる on 13/10/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "DisplaySetting.h"

@interface DisplaySetting ()

@end

@implementation DisplaySetting

int i1 = 0;

UITextField *whichText;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect datePickerFrame = self.myDatePicker.frame;
    CGRect toolBarFrame = self.toolBar.frame;
    toolBarFrame.origin.y = self.view.frame.size.height;
    datePickerFrame.origin.y = self.view.frame.size.height + self.toolBar.frame.size.height;
    self.myDatePicker.frame = datePickerFrame;
    self.toolBar.frame = toolBarFrame;
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

- (IBAction)textFieldClicked:(UITextField *)sender {
    
    whichText = sender;
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
    //NSLog(@"datePicker表示");

    

}



- (IBAction)confirmButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"保存しますか？";
    [alert addButtonWithTitle:@"キャンセル"];
    [alert addButtonWithTitle:@"OK"];
    [alert show];

}


-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            NSLog(@"1番目！");
            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
            //NSString*  insert = @"INSERT INTO kinmu (day,start,end) VALUES (?,?,?)";
            
            break;
    }

}

- (IBAction)changeDatePicker:(id)sender {
    
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    //指定した日付形式で日付を表示する
    whichText.text = [df stringFromDate:self.myDatePicker.date];


}
@end
