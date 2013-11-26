//
//  RestModel.m
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "RestModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Rest.h"

#define DB_FILE_NAME @"works.db"

#define RESTS_SQL_CREATE @"CREATE TABLE IF NOT EXISTS rests (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL,end REAL);"

#define SQL_INSERT_INIT_RESTS @"INSERT INTO rests (start,end) VALUES (12:00,13:00);"

#define SQL_UPDATE_RESTS @"UPDATE rests SET start = ?, end = ?,WHERE id = ?;"


@interface RestModel()
@property (nonatomic,copy)NSString* dbPath;

-(FMDatabase*)getConnection;
@end

@implementation RestModel

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
    [db executeUpdate:RESTS_SQL_CREATE];
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
		self.dbPath =  [RestModel getDbFilePath];
	}
	
	return [FMDatabase databaseWithPath:self.dbPath];
}

/**
 * 書籍を更新します。
 */
- (BOOL)update:(Rest *)rest
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE_RESTS, rest.start, rest.end, [NSNumber numberWithInteger:rest.rest_id]];
	
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
