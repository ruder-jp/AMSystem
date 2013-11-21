//
//  daoWorks.m
//  AMSystem
//
//  Created by ブロス on 13/11/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "daoWorks.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Works.h"

#define DB_FILE_NAME @"works.db"


#define FORIGN_KEY_OPEN @"PRAGMA foreign_keys=ON;"
#define WORKS_SQL_CREATE @"CREATE TABLE IF NOT EXISTS works (id INTEGER PRIMARY KEY AUTOINCREMENT, date DATE,start INTEGER ,end INTEGER,time_id INTEGER　 REFERENCES times(id),rest_id INTEGER REFERENCES rests(id));"
#define TIMES_SQL_CREATE @"CREATE TABLE IF NOT EXISTS times (id INTEGER PRIMARY KEY AUTOINCREMENT, start INTEGER,end INTEGER);"
#define RESTS_SQL_CREATE @"CREATE TABLE IF NOT EXISTS rests (id INTEGER PRIMARY KEY AUTOINCREMENT, start INTEGER,end INTEGER);"
#define SQL_INSERT @"INSERT INTO working (day,startTime,endTime,startRest,endRest) VALUES (?,?,?,?,?);"
#define SQL_UPDATE @"UPDATE working SET startTime = ?, endTime = ?, startRest = ?, endRest = ? WHERE id = ?;"
#define SQL_SELECT @"SELECT id, day ,startTime , endTime , startRest , endRest FROM working;"




@interface daoWorks()
@property (nonatomic,copy)NSString* dbPath;

-(FMDatabase*)getConnection;


@end

@implementation daoWorks

@synthesize dbPath;

-(id)init
{
    self =[super init];
    if(self)
    {
        FMDatabase* db = [self getConnection];
        [db open];
        [db executeUpdate:WORKS_SQL_CREATE];
        [db executeUpdate:TIMES_SQL_CREATE];
        [db executeUpdate:RESTS_SQL_CREATE];
        [db close];
    }
    return self;
}

-(Works*)insertStart:(Works*)data
{
    FMDatabase* db = [self getConnection];
    [db open];
    
    [db setShouldCacheStatements:YES];
    if([db executeUpdate:SQL_INSERT,data.date,data.start,data.end,data.time_id,data.rest_id]){
        //        data. = [db lastInsertRowId];
        
        data.day_id = [db lastInsertRowId];
        NSLog(@"insert 成功");
        
    }else
    {
        data = nil;
    }
    [db close];
    
    return data;
}

-(NSArray*)datas
{
    FMDatabase* db = [self getConnection];
    [db open];
    
    FMResultSet* results = [db executeQuery:SQL_SELECT];


    NSMutableArray* datas = [[NSMutableArray alloc] initWithCapacity:0];

    while([results next]){
        Works* works = [[Works alloc]init];
        
        works.day_id = [results intForColumnIndex:0];
        works.date = [results dateForColumnIndex:1];
        works.start = [results intForColumnIndex:2];
        works.end = [results intForColumnIndex:3];
        works.time_id = [results intForColumnIndex:4];
        works.rest_id = [results intForColumnIndex:5];
    
        [datas addObject:works];
        
        NSLog(@"%@",datas);
        
//        NSLog(@"%i",[results intForColumnIndex:0]);
//        NSLog(@"%@",[results stringForColumnIndex:1]);
//        NSLog(@"%@",[results stringForColumnIndex:2]);
//        NSLog(@"%@",[results stringForColumnIndex:3]);
//        NSLog(@"%@",[results stringForColumnIndex:4]);
//        
//        NSLog(@"%@",[results stringForColumnIndex:5]);
        
    }
    NSLog(@"%@",@"select成功？");
    
    
    [db close];
    return datas;
}

/**
 * 書籍を更新します。
 */
- (BOOL)update:(Works *)works
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE, works.start, works.end, works.time_id, works.rest_id, [NSNumber numberWithInteger:works.day_id]];
	
	[db close];
	
	return isSucceeded;
}

#pragma mark - Private methods

/**
 * データベースを取得します。
 *
 * @return データベース。
 */
- (FMDatabase *)getConnection
{
	if( self.dbPath == nil )
	{
		self.dbPath =  [daoWorks getDbFilePath];
	}
	
	return [FMDatabase databaseWithPath:self.dbPath];
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