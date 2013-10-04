//
//  Todo.h
//  AMSystem
//
//  Created by ブロス on 13/09/12.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (strong,nonatomic)NSString *task;
@property (strong,nonatomic)NSData *due;

+(Todo *)todoWithTask:(NSString *)task
                  due:(NSDate *)due;
+(Todo *)todoWithTask:(NSString *)task
         dueDateAfter:(int)day;

-(NSString *)dueString;
-(NSString *)description;

@end
