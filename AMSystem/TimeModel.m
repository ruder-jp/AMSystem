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
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS times (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL,end REAL);"];
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
 * 勤務設定時間を更新する
 */
- (BOOL)update:(Time *)time
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:@"UPDATE times SET start = ?, end = ?,WHERE id = ?;", time.start, time.end, [NSNumber numberWithInteger:time.time_id]];
	
	[db close];
	
	return isSucceeded;
}

//勤務設定時間を参照する
- (Time*)setting
{
    FMDatabase* db = [self getConnection];
	[db open];
    
    FMResultSet*    results = [db executeQuery:@"SELECT id, strftime('%H:%M',start) , strftime('%H:%M',end) FROM times;"];
    
    //NSMutableArray* times = [[NSMutableArray alloc] initWithCapacity:0];
    
    [results next];
    Time* time = [[Time alloc] init];
    time.time_id = [results intForColumnIndex:0];
    time.start = [results stringForColumnIndex:1];
    time.end = [results stringForColumnIndex:2];
    //[times addObject:time];
    
    
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
	
	return [dir stringByAppendingPathComponent:@"works.db"];
}

@end