//
//  SettingDisplay.h
//  AMSystem
//
//  Created by わたる on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingDisplay : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    UIDatePicker *picker;
}

@property(nonatomic, retain) NSMutableArray *dataSource;

@property(nonatomic, strong) NSString *idstartTimeCell;
@property(nonatomic, strong) NSString *idendTimeCell;
@property(nonatomic, strong) NSString *idstartRestCell;
@property(nonatomic, strong) NSString *idendRestCell;

//テキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *startRest;
@property (weak, nonatomic) IBOutlet UITextField *endRest;


//どのテキストがタップしたか検出する変数
@property (weak, nonatomic) UITextField *whichText;

@end