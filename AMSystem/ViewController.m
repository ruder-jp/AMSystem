//
//  ViewController.m
//  AMSystem
//
//  Created by Maeda Ryoto on 13/07/01.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#define DBFILE     @"working.db"


@interface ViewController ()
-(void)display;

//@property (nonatomic, copy) NSString* dbPath; //! データベース　ファイルへのパス
//
//- (FMDatabase*)getConnection;
//+ (NSString*)getDbFilePath;
@end




@implementation ViewController



int i = 0;



- (FMDatabase*)_getDB:(NSString*)dbName {
	NSArray*  pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docdir = [pathArray objectAtIndex:0];
	NSString* dbpath = [docdir stringByAppendingPathComponent:dbName];
	FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    if (![db open]) {
        @throw [NSException exceptionWithName:@"DBOpenException" reason:@"couldn't open specified db file" userInfo:nil];
    }
    
    return db;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(driveClock:)
                                   userInfo:nil
                                    repeats:YES];
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    [day setDateFormat:@"MM月dd日"];
    
    NSString *dayStr = [day stringFromDate:now];;
    self.dayLavel.text = dayStr;
    
    
    FMDatabase* db = [self _getDB:DBFILE];
    NSString*   sql = @"CREATE TABLE IF NOT EXISTS working (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT,startTime TEXT ,endTime TEXT,startRest TEXT,endRest TEXT);";
    
    [db open];
    [db executeUpdate:sql];
    [db close];
    
    
    
    
    //ボタンの操作
    UIButton *button =
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.topButton setTitle:@"始業"
                    forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(pushButton:)
     forControlEvents:UIControlEventTouchUpInside];
    
}





- (void)driveClock:(NSTimer *)timer
{
    NSDate *today = [NSDate date];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    int hour = [todayComponents hour];
    int min = [todayComponents minute];
    int sec = [todayComponents second];
    
    self.timeLavel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec]; //時間を表示
}













- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)bushButton:(id)sender {
    
    if(i == 0){
        //アラートビューの生成と設定
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"始業確認"
                              message:@"始業してもよろしいですか？"
                              delegate:self
                              cancelButtonTitle:@"キャンセル" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        
    }else if(i == 1){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"終業確認"
                              message:@"終業してもよろしいですか？"
                              delegate:self
                              cancelButtonTitle:@"キャンセル" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"エラー"
                              message:@"これ以上入りません"
                              delegate:self
                              cancelButtonTitle:@"戻ります" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
}



-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //1番目のボタン（cancelButtonTitle）が押されたときのアクション
            NSLog(@"1番目");
            
            break;
            
        case 1:
            //2番目のボタンが押されたときのアクション
            NSLog(@"2番目");
            if(i <= 1){
                FMDatabase* db = [self _getDB:DBFILE];
                
                NSString*   insert = @"INSERT INTO working (day,startTime,endTime) VALUES (?,?,?)";
                
                NSString*   insert2 = @"INSERT INTO working (endTime) VALUES (?)";
                
                NSString*   select = @"SELECT id, day ,startTime , endTime FROM working;";
                
                NSString*   maxSelect = @"select MAX(id) as MAX_KEY_VALUE,startTime,endTime from working;";
                
                [db open];
                
                
                FMResultSet*    results = [db executeQuery:select];
                
                FMResultSet*    results2 = [db executeQuery:maxSelect];
                
                
                
                
                
                if(i == 0){
                    
                    
                    
                    //日付の取得
                    NSDateFormatter *day = [[NSDateFormatter alloc] init];
                    NSDateFormatter *time = [[NSDateFormatter alloc] init];
                    
                    NSDate *now = [NSDate date];
                    [day setDateFormat:@"yyyy/MM/dd"];
                    [time setDateFormat:@"HH:mm"];
                    
                    //String型に変換
                    NSString *outputDay = [day stringFromDate:now];
                    NSString *outputTime = [time stringFromDate:now];
                    
                    //DBに登録
                    [db executeUpdate:insert,outputDay,outputTime,NULL];
                    
                    UIButton *button =
                    [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    
                    [self.topButton setTitle:@"終業"
                                    forState:UIControlStateNormal];
                    
                    [button addTarget:self
                               action:@selector(pushButton:)
                     forControlEvents:UIControlEventTouchUpInside];
                    i += 1;
                    
                    //DB取得
                    while( [results2 next] )
                    {
                        self.startTime.text = [results2 stringForColumn:@"startTime"];
                    }
                    
                    
                }else{
                    //日付の取得
                    NSDateFormatter *day = [[NSDateFormatter alloc] init];
                    NSDateFormatter *time = [[NSDateFormatter alloc] init];
                    
                    NSDate *now = [NSDate date];
                    [day setDateFormat:@"yyyy/MM/dd"];
                    [time setDateFormat:@"HH:mm"];
                    
                    //String型に変換
                    NSString *outputDay = [day stringFromDate:now];
                    NSString *outputTime = [time stringFromDate:now];
                    
                    self.endTime.text = outputTime;
                    //        NSLog(@"%@ %@",outputDay ,outputTime);
                    
                    //DBに登録
                    [db executeUpdate:insert,outputDay,NULL,outputTime];
                    
                    //NSLog(@"%@",[results2 stringForColumn:@"start"]);
                    
                    
                    UIButton *button =
                    [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    
                    [self.topButton setTitle:@"始業"
                                    forState:UIControlStateNormal];
                    
                    [button addTarget:self
                               action:@selector(pushButton:)
                     forControlEvents:UIControlEventTouchUpInside];
                    i += 1;
                    
                    //DB取得
                    while( [results2 next] )
                    {
                        
                        self.endTime.text = [results2 stringForColumn:@"endTime"];
                    }
                    
                    
                    
                }
                [db close];
            }else{
                NSLog(@"%@",@"はいらないよ");
            }
            break;
            
    }
    
}




//- (IBAction)sideMenu:(id)sender {
//    [self toggleMenuController];
//}
//
//
//
//-(void)toggleMenuController
//{
//    isRevealed = !isRevealed;
//    
//    UIView *targetView = contentController.view;
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        CGFloat originX = isRevealed ? 0 : 260;
//        CGRect frame = targetView.frame;
//        frame.origin.x = originX;
//        targetView.frame = frame;
//    } completion:^(BOOL finished){
//        //NSLog(@"%@", finished ? @"YES" : @"NO");
//    }];
//}
@end