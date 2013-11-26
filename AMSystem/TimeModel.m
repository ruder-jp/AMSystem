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

#define TIMES_SQL_CREATE @"CREATE TABLE IF NOT EXISTS times (id INTEGER PRIMARY KEY AUTOINCREMENT, start INTEGER,end INTEGER);"

#define SQL_INSERT_INIT_TIMES @"INSERT INTO times (start,end) VALUES (9:00,18:00);"

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
 * 書籍を更新します。
 */
- (BOOL)update:(Time *)time
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE_TIMES, time.start, time.end, [NSNumber numberWithInteger:time.time_id]];
	
	[db close];
	
	return isSucceeded;
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