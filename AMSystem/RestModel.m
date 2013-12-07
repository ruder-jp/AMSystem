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
        //[self createSql];
    }
    return self;
}

-(void)createSql
{
    FMDatabase* db = [self getConnection];
    [db open];
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS rests (id INTEGER PRIMARY KEY AUTOINCREMENT, start REAL,end REAL);"];
    [db close];
}

-(void)initRests
{
    FMDatabase* db = [self getConnection];
    [db open];
    [db executeUpdate:@"INSERT INTO rests (start,end) VALUES (julianday('12:00:00'), julianday('13:00:00'));"];
    
    
    [db close];
}

- (BOOL)noteJudgment
{
    FMDatabase* db = [self getConnection];
    
	[db open];
    
    FMResultSet* results = [db executeQuery:@"SELECT id FROM times;"];
    [results next];
    Rest* rest = [[Rest alloc] init];
    rest.rest_id = [results intForColumnIndex:0];
    if(rest.rest_id == nil){
        return YES;
    }
    [db close];
    return NO;
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

-(Rest* )insert:(Rest *)rest
{
    FMDatabase* db = [self getConnection];
    
    NSString* sql =[[NSString alloc]initWithFormat:@"INSERT INTO rests (start,end) VALUES (julianday('%@'),julianday('%@'))",rest.start,rest.end];
    
    [db open];
    
    [db setShouldCacheStatements:YES];
	if([db executeUpdate:sql]){
		rest.rest_id = [db lastInsertRowId];
	}
	else
	{
		rest = nil;
	}
    
    [db close];
    return rest;
}

/**
 * 休憩設定時間を更新する
 */
- (BOOL)update:(Rest *)rest
{
	FMDatabase* db = [self getConnection];
	[db open];
    
    NSString *sql = [[NSString alloc]initWithFormat:@"UPDATE rests SET start = julianday('%@'), end = julianday('%@')WHERE id = %@;", rest.start, rest.end,[NSNumber numberWithInteger:rest.rest_id]];
    
	BOOL isSucceeded = [db executeUpdate:sql];
	
//	BOOL isSucceeded = [db executeUpdate:@"UPDATE rests SET start = ?, end = ?,WHERE id = ?;", rest.start, rest.end, [NSNumber numberWithInteger:rest.rest_id]];
	
	[db close];
	
	return isSucceeded;
}

//休憩設定時間を参照する
- (Rest*)setting
{
    FMDatabase* db = [self getConnection];
	[db open];
    
    FMResultSet*    results = [db executeQuery:@"SELECT id, strftime('%H:%M',start) , strftime('%H:%M',end) FROM rests;"];
    
    //NSMutableArray* times = [[NSMutableArray alloc] initWithCapacity:0];
    
    [results next];
    Rest* rest = [[Rest alloc] init];
    rest.rest_id = [results intForColumnIndex:0];
    rest.start = [results stringForColumnIndex:1];
    rest.end = [results stringForColumnIndex:2];
    //[rests addObject:rest];
    
    
    [db close];
    
    //NSLog(results.endTime);
    return rest;
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