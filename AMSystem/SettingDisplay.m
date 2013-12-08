//
//  SettingDisplay.m
//  AMSystem
//
//  Created by わたる on 13/12/08.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "SettingDisplay.h"
#import "TimeModel.h"
#import "RestModel.h"
#import "Time.h"
#import "Rest.h"

#define TAG_START_TIME 1
#define TAG_END_TIME 2
#define TAG_START_REST 3
#define TAG_END_REST 4

@interface SettingDisplay ()

@property (nonatomic, retain) TimeModel*            timeModel; //! 勤務時間設定を管理するオブジェクト
@property (nonatomic, retain) RestModel*            restModel; //! 休憩時間設定を管理するオブジェクト


@property (nonatomic, retain) Time*
time;     //! 編集対象となる勤務時間

@property (nonatomic, retain) Rest*
rest;     //! 編集対象となる休憩時間

@end

@implementation SettingDisplay{
    //Section用データ
    NSArray *groupNames;
    //Row用データ
    NSArray * groups;
    //テキストタグ用データ
    NSArray *texttags;
    NSInteger *texttag;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    groupNames = @[@"就業時間帯", @"休憩時間帯"];
    groups = @[
               @[@"始業", @"終業"],
               @[@"開始", @"終了"]
               ];
    texttags = @[@"TAG_START_TIME",@"TAG_END_TIME",@"TAG_START_REST",@"TAG_END_REST"];
    
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.timeModel = [[TimeModel alloc] init];
    self.restModel = [[RestModel alloc] init];
    
    Time* timeObject = [self.timeModel setting];
    Rest* restObject = [self.restModel setting];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










- (void)showPicker {
	//ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, self.view.frame.size.height - picker.frame.size.height, 320, 216);
    
	[UIView commitAnimations];
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //テキストフィールドの編集を始めるときに、ピッカーを呼び出す。
    _whichText = textField;
    //_whichText.tag = textField.tag;
    
    //テキストフィールドに設定している時間をデートピッカーの初期時間に設定する
    NSDate *convertDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    //nullは許されてない
//    convertDate = [dateFormatter dateFromString:_whichText.text];
//    if(convertDate != nil){
//        picker.date = convertDate;
//    }
    [self showPicker];
    
    
    
    //キーボードは表示させない
    return NO;
}

- (void)hidePicker {
	//ピッカーを下に隠すアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, self.view.frame.size.height, 320, 216);
	[UIView commitAnimations];
}

- (IBAction)hidePickerRecognized:(id)sender{
    [self hidePicker];
}

/**
 * 日付ピッカーの値が変更されたとき
 */
- (void)datePicker_ValueChanged:(id)sender
{
    //UIDatePicker *datePicker = sender;
    NSLog(@"おまえ変わったよな");
    
    //時間をテキストフィールドに表示する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    
    //指定した日付形式で日付を表示する
    _whichText.text = [df stringFromDate:picker.date];
    
}




/*
--------------------------------------------------------------
ここからテーブルビュー処理
*/

#pragma mark - Table view data source

// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [groupNames count];
}

//セクションのタイトルを設定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

//　テーブルセルの高さを設定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

// tableのリスト件数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groups[section] count];
}

// テーブルの列にデータセット
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *nameLabel;
    UITextField *passTextFld;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIFont *textFont = [UIFont systemFontOfSize:17.0];
        
        // ラベル
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 130, 50)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [nameLabel setFont:textFont];
        [cell.contentView addSubview:nameLabel];
        
        // テキスト
        passTextFld = [[UITextField alloc] initWithFrame:CGRectMake(130, 20, 140, 50)];
        passTextFld.delegate = self;
        [passTextFld setFont:textFont];
        passTextFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
        passTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        NSArray *members = groups[indexPath.section];
        nameLabel.text = members[indexPath.row];
        passTextFld.tag = texttags[indexPath.row];
        //        switch (indexPath.row){
        //            case 0:
        //                [nameLabel setText:@"始業"];
        //                passTextFld.text = @"ほんだけいすけ";
        //                //passTextFld.returnKeyType = UIReturnKeyNext;
        //                //passTextFld.secureTextEntry = NO;
        //                passTextFld.tag = TAG_USER_ID;
        //                break;
        //            case 1:
        //                [nameLabel setText:@"終業"];
        //                passTextFld.placeholder = @"かがわしんじ";
        //                passTextFld.tag = TAG_PASSWORD;
        //                break;
        //            case 2:
        //                [nameLabel setText:@"開始"];
        //                passTextFld.placeholder = @"てらい";
        //                passTextFld.tag = TAG_PASSWORD;
        //                break;
        //            case 3:
        //                [nameLabel setText:@"終了"];
        //                passTextFld.placeholder = @"けんいち";
        //                passTextFld.tag = TAG_PASSWORD;
        //                break;
        //
        //        }
        //        if (indexPath.row == 0)
        //        {
        //            [nameLabel setText:@"始業"];
        //            passTextFld.text = @"ほんだけいすけ";
        //            //passTextFld.returnKeyType = UIReturnKeyNext;
        //            //passTextFld.secureTextEntry = NO;
        //            passTextFld.tag = TAG_USER_ID;
        //        }
        //        else
        //        {
        //            [nameLabel setText:@"終業"];
        //            passTextFld.placeholder = @"かがわしんじ";
        //            passTextFld.tag = TAG_PASSWORD;
        //        }
        [cell.contentView addSubview:passTextFld];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView: (UITableView *)tv viewForHeaderInSection:(NSInteger)section
{
    //再利用できるヘッダーがないか探す
    UITableViewHeaderFooterView *view = [tv dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!view) {
        //再利用できるヘッダーがなければオブジェクト生成
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
    }
    //ヘッダーに文字を表示するための設定
    view.textLabel.text = groupNames[section];
    return view;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
