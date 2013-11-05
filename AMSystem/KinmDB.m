//
//  KinmDB.m
//  AMSystem
//
//  Created by ブロス on 13/10/31.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//



#import "KinmDB.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Data.h"

#define DB_FILE_NAME @"working.db"


#define SQL_CREATE @"CREATE TABLE IF NOT EXISTS working (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT,startTime TEXT ,endTime TEXT,startRest TEXT,endRest TEXT);"
#define SQL_INSERT @"INSERT INTO working (day,startTime,endTime) VALUES (?,?,?);"

#define SQL_SELECT @"SELECT id, day ,startTime , endTime FROM working;"

#define SQL_MAX_SELECT @"select MAX(id) as MAX_KEY_VALUE,startTime,endTime from working;"

@interface KinmDB()
@property (nonatomic,copy)NSString* dbPath;

-(FMDatabase*)getConnection;


@end

@implementation KinmDB

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

-(Data*)insertStart:(Data*)data
{
    
    FMDatabase* db = [self getConnection];
    [db open];
    
    [db setShouldCacheStatements:YES];
    if([db executeUpdate:SQL_INSERT,data.day,data.startTime,data.endTime]){
//        data. = [db lastInsertRowId];
        
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
        Data * data = [[Data alloc]init];
        data.day = [results stringForColumnIndex:1];
        data.startTime = [results stringForColumnIndex:2];
        data.endTime = [results stringForColumnIndex:3];
        data.startTime = [results stringForColumnIndex:4];
        data.endRiset = [results stringForColumnIndex:5];
        
//        [datas addObject:data];
    }
    
    
}


@end

