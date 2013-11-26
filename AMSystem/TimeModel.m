//
//  TimeModel.m
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "TimeModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Time.h"

#define DB_FILE_NAME @"works.db"

#define TIMES_SQL_CREATE @"CREATE TABLE IF NOT EXISTS times (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL DEFAULT 10,end REAL DEFAULT 10);"

#define SQL_INSERT_INIT_TIMES @"INSERT INTO times (start,end) VALUES (julianday(¥"?¥"),julianday(¥"?¥"));"

#define SQL_UPDATE_TIMES @"UPDATE times SET start = ?, end = ?,WHERE id = ?;"

@interface TimeModel()
@property (nonatomic,copy)NSString* dbPath;

-(FMDatabase*)getConnection;
@end

@implementation TimeModel

@synthesize dbPath;

-(id)init
{
    if(self = [super init])
    {
        [self createSql];
        [self initTimes];
    }
    return self;
}

-(void)createSql
{
    FMDatabase* db = [self getConnection];
    [db open];
    [db executeUpdate:TIMES_SQL_CREATE];
    [db close];
}


-(void)initTimes
{
    FMDatabase* db = [self getConnection];
    [db open];
    [db executeUpdate:@"INSERT INTO times (start,end) VALUES (julianday('09:00:00'), julianday('18:00:00'));"];
    [db close];
}




/**
 * データベースを取得します。
 *
 * @return データベース。
 */
- (FMDatabase *)getConnection
{
	if( self.dbPath == nil )
	{
		self.dbPath =  [TimeModel getDbFilePath];
	}
	
	return [FMDatabase databaseWithPath:self.dbPath];
}

/**
 * 勤務設定を更新します。
 */
- (BOOL)update:(Time *)time
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE_TIMES, time.start, time.end, [NSNumber numberWithInteger:time.time_id]];
	
	[db close];
	
	return isSucceeded;
}

//時間設定を参照する
- (Time*)setting
{
    FMDatabase* db = [self getConnection];
	[db open];
    
    FMResultSet*    results = [db executeQuery:SQL_SELECT];
    //FMResultSet*    results = [db executeQuery:SQL_SELECT_SETTING_DISPLAY];
    
    NSMutableArray* times = [[NSMutableArray alloc] initWithCapacity:0];
    
    [results next];
    Time* time = [[Time alloc] init];
    time.time_id = [results intForColumnIndex:0];
    time.start = [results realForColumnIndex:1];
    time.end = [results realForColumnIndex:2];
    //[works addObject:work];
    
    
    [db close];
    
    //NSLog(results.endTime);
    return time;
}

/**
 * データベース ファイルのパスを取得します。
 */
+ (NSString*)getDbFilePath
{
	NSArray*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
	NSString* dir   = [paths objectAtIndex:0];
	
	return [dir stringByAppendingPathComponent:DB_FILE_NAME];
}

@end