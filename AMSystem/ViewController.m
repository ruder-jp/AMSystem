//
//  ViewController.m
//  AMSystem
//
//  Created by Maeda Ryoto on 13/07/01.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "ViewController.h"
#import "smMenuViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#define DBFILE     @"kinmu3.db"


@interface ViewController ()
-(void)display;
-(void)toggleBoldface;

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
    
    
    
    
   
    
    

    //こっからDB
//        NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//        NSString*   dir   = [paths objectAtIndex:0];
//        FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"app.db"]];
//    
//        [db open];
//        [db close];
    
//    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//    NSString*   dir   = [paths objectAtIndex:0];
//    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"app.db"]];
//    
//    [db open];
//    [db close];
//    
//
    FMDatabase* db = [self _getDB:DBFILE];
    NSString*   sql = @"CREATE TABLE IF NOT EXISTS kinmu (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT,start TEXT ,end TEXT);";

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
    
    
    
    if(i <= 1){
        FMDatabase* db = [self _getDB:DBFILE];
        
        NSString*   insert = @"INSERT INTO kinmu (day,start,end) VALUES (?,?,?)";
        
        NSString*   insert2 = @"INSERT INTO kinmu (end) VALUES (?)";
        
        NSString*   select = @"SELECT id, day ,start , end FROM kinmu;";
        
        NSString*   maxSelect = @"select MAX(id) as MAX_KEY_VALUE,start,end from kinmu;";
        
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
            
            [self.topButton setTitle:@"始業"
                            forState:UIControlStateNormal];
            
            [button addTarget:self
                       action:@selector(pushButton:)
             forControlEvents:UIControlEventTouchUpInside];
            i += 1;
            
            //DB取得
            while( [results2 next] )
            {
                self.startTime.text = [results2 stringForColumn:@"start"];
                //                    NSLog(@"%d %@ %@ %@", [results intForColumn:@"id"],[results stringForColumn:@"day"],[results stringForColumn:@"start"],[results stringForColumn:@"end"]);
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
            
            [self.topButton setTitle:@"終業"
                            forState:UIControlStateNormal];
            
            [button addTarget:self
                       action:@selector(pushButton:)
             forControlEvents:UIControlEventTouchUpInside];
            i += 1;
            
            //DB取得
            while( [results2 next] )
            {
                
                self.endTime.text = [results2 stringForColumn:@"end"];
                //                    NSLog(@"%d %@ %@ %@", [results2 intForColumn:@"MAX_KEY_VALUE"],[results2 stringForColumn:@"day"],[results2 stringForColumn:@"start"],[results2 stringForColumn:@"end"]);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //        NSDate *now = [NSDate date];
            //        [formatter setDateFormat:@"HH:mm"];
            //
            //        //        [db executeUpdate:insert,now];
            //        //        [db executeUpdate:insert,[formatter stringFromDate:now]];
            //        [db executeUpdate:insert,[formatter stringFromDate:now],NULL,@"2222"];
            //
            //        self.endTime.text = [formatter stringFromDate:now];
            //
            //
            //        UIButton *button =
            //        [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //        
            //        [self.topButton setTitle:@"終業"
            //                        forState:UIControlStateNormal];
            //        
            //        [button addTarget:self
            //                   action:@selector(pushButton:)
            //         forControlEvents:UIControlEventTouchUpInside];
            //        i += 1;
            //        while( [results next] )
            //        {
            //            NSLog(@"%d %d %d %d", [results intForColumn:@"id"],[results intForColumn:@"day"],[results intForColumn:@"start"],[results intForColumn:@"end"]);
            //        }
        }
    [db close];
    }else{
        NSLog(@"%@",@"はいらないよ");
    }

    

}
@end
