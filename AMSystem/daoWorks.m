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

#define SQL_SELECT @"SELECT id, day ,startTime , endTime FROM working;"

#define SQL_MAX_SELECT @"select MAX(id) as MAX_KEY_VALUE,startTime,endTime from working;"

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
    if([db executeUpdate:SQL_INSERT,data.day,data.startTime,data.endTime]){
        //        data. = [db lastInsertRowId];
        data.dayId = [db lastInsertRowId];
        
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
    
    NSMutableArray* data = [[NSMutableArray alloc] initWithCapacity:0];
    
    while([results next]){
        Work * work = [[Work alloc]init];
        work.day = [results stringForColumnIndex:1];
        work.startTime = [results stringForColumnIndex:2];
        work.endTime = [results stringForColumnIndex:3];
        work.startRest = [results stringForColumnIndex:4];
        work.endRest = [results stringForColumnIndex:5];
        
        //        [datas addObject:data];
    }
    
    
}


@end