//
//  Data.m
//  AMSystem
//
//  Created by ブロス on 13/09/25.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "Data.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

#define DB_FILE_NAME @"app.db"

#define SQL_CREATE @"CREATE TABLE IF NOT EXISTS books (id INTEGER PRIMARY KEY AUTOINCREMENT, author TEXT, title TEXT, copyright INTEGER);"
#define SQL_INSERT @"INSERT INTO books (author, title, copyright) VALUES (?, ?, ?);"
#define SQL_UPDATE @"UPDATE books SET author = ?, title = ?, copyright = ? WHERE id = ?;"
#define SQL_SELECT @"SELECT id, author, title, copyright FROM books GROUP BY author, title;"
#define SQL_DELETE @"DELETE FROM books WHERE id = ?;"

@interface Data()
@property (nonatomic, copy) NSString* dbPath; //! データベース　ファイルへのパス

- (FMDatabase*)getConnection;
+ (NSString*)getDbFilePath;
@end


@implementation Data

@synthesize dbPath;


@end
