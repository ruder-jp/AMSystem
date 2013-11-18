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
#import "Work.h"

#define DB_FILE_NAME @"working.db"


#define SQL_CREATE @"CREATE TABLE IF NOT EXISTS working (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT,startTime TEXT ,endTime TEXT,startRest TEXT,endRest TEXT);"
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
        [db executeUpdate:SQL_CREATE];
        [db close];
    }
    return self;
}

-(Work*)insertStart:(Work*)data
{
    FMDatabase* db = [self getConnection];
    [db open];
    
    [db setShouldCacheStatements:YES];
    if([db executeUpdate:SQL_INSERT,data.day,data.startTime,data.endTime,data.startRest,data.endRest]){
        //        data. = [db lastInsertRowId];
        
        data.dayId = [db lastInsertRowId];
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
        Work* work = [[Work alloc]init];
        work.dayId = [results intForColumnIndex:0];
        work.day = [results stringForColumnIndex:1];
        work.startTime = [results stringForColumnIndex:2];
        work.endTime = [results stringForColumnIndex:3];
        work.startRest = [results stringForColumnIndex:4];
        work.endRest = [results stringForColumnIndex:5];
    
        [datas addObject:work];
        
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
- (BOOL)update:(Work *)work
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE, work.startTime, work.endTime, work.startRest, work.endRest, [NSNumber numberWithInteger:work.dayId]];
	
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