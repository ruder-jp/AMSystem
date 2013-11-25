//
//  WorkModel.m
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "WorkModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "Work.h"

#define DB_FILE_NAME @"works.db"


#define FORIGN_KEY_OPEN @"PRAGMA foreign_keys=ON;"
#define WORKS_SQL_CREATE @"CREATE TABLE IF NOT EXISTS works (id INTEGER PRIMARY KEY AUTOINCREMENT, date REAL,start REAL ,end REAL,time_id INTEGER REFERENCES times(id),rest_id INTEGER REFERENCES rests(id));"
#define TIMES_SQL_CREATE @"CREATE TABLE IF NOT EXISTS times (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL,end REAL);"
#define RESTS_SQL_CREATE @"CREATE TABLE IF NOT EXISTS rests (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL,end REAL);"
#define SQL_INSERT @"INSERT INTO works (date,start,end,time_id,rest_id) VALUES (julianday(\"?\"),julianday(\"?\"),?,?,?);"
//#define SQL_START @"INSERT INTO works(date,start,end,time_id,rest_id) VALUES(?,?,?,?,?);"
#define SQL_END @"UPDATE  works SET  end = ? WHERE id = ?;"
#define SQL_UPDATE @"UPDATE works SET start = ?, end = ?, rest_id = ?, time_id = ? WHERE id = ?;"
#define SQL_SELECT @"SELECT id, datetime(date) ,datetime(start) , datetime(end) , rest_id , time_id FROM works;"


#define SQL_INSERT_INIT_TIMES @"INSERT INTO times (start,end) VALUES (9:00,18:00);"

#define SQL_INSERT_INIT_RESTS @"INSERT INTO rests (start,end) VALUES (12:00,13:00);"


@interface WorkModel()
@property (nonatomic,copy)NSString* dbPath;

-(FMDatabase*)getConnection;
@end

@implementation WorkModel

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
    [db executeUpdate:WORKS_SQL_CREATE];
    [db executeUpdate:TIMES_SQL_CREATE];
    [db executeUpdate:RESTS_SQL_CREATE];
    [db close];
}

-(Work*)insertStart:(Work*)data
{
    
    FMDatabase* db = [self getConnection];
    [db open];
    [db setShouldCacheStatements:YES];
    NSString* sql =[[NSString alloc]initWithFormat:@"INSERT INTO works (date,start,end,time_id,rest_id) VALUES (julianday('%@'),julianday('%@'),%@,%i,%i);",data.date,data.start,data.end,data.time_id,data.rest_id];
    if([db executeUpdate:sql]){
        data.day_id = [db lastInsertRowId];
    }else
    {
        data = nil;
    }
    [db close];
    return data;
}

- (BOOL)updateEnd:(Work *)work
{
	FMDatabase* db = [self getConnection];
    //field count
    [db open];
    NSUInteger count = [db intForQuery:@"SELECT count(id)from works"];
    NSString* sql =[[NSString alloc]initWithFormat:@"UPDATE  works SET  end = julianday('%@') WHERE id = %@;",work.end,[NSNumber numberWithInteger:count]];
    NSLog(@"%@",sql);
    BOOL isSucceeded = [db executeUpdate:sql];
	[db close];
    NSLog(@"%@",@"update");
	
	return isSucceeded;
}


-(NSArray*)datas
{
    FMDatabase* db = [self getConnection];
    [db open];
    
    FMResultSet* results = [db executeQuery:SQL_SELECT];
    NSMutableArray* datas = [[NSMutableArray alloc] initWithCapacity:0];
    
    while([results next]){
        Work* work = [[Work alloc]init];
        
        work.day_id = [results intForColumnIndex:0];
        work.date = [results stringForColumnIndex:1];
        work.start = [results stringForColumnIndex:2];
        work.end = [results stringForColumnIndex:3];
        work.time_id = [results intForColumnIndex:4];
        work.rest_id = [results intForColumnIndex:5];
        
        [datas addObject:work];
        
        NSLog(@"%@",datas);
        
        NSLog(@"%i",[results intForColumnIndex:0]);
        NSLog(@"%@",[results stringForColumnIndex:1]);
        NSLog(@"%@",[results stringForColumnIndex:2]);
        NSLog(@"%@",[results stringForColumnIndex:3]);
        NSLog(@"%i",[results intForColumnIndex:4]);
        NSLog(@"%i",[results intForColumnIndex:5]);

    NSLog(@"%@",@"select成功");
    }
    
    
    
    [db close];
    return datas;
}


- (BOOL)update:(Work *)work
{
	FMDatabase* db = [self getConnection];
	[db open];
	
	BOOL isSucceeded = [db executeUpdate:SQL_UPDATE, work.start, work.end, work.time_id, work.rest_id, [NSNumber numberWithInteger:work.day_id]];
	
	[db close];
	
	return isSucceeded;
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
		self.dbPath =  [WorkModel getDbFilePath];
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
