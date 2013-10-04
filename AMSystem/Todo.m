//
//  Todo.m
//  AMSystem
//
//  Created by ブロス on 13/09/12.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "Todo.h"

@implementation Todo

+(Todo *)todoWithTask:(NSString *)task due:(NSDate *)due
{
    Todo *todo = [[Todo alloc]init];
    
    todo.task = task;
    todo.due = due;
    
    return todo;
}

+(Todo *)todoWithTask:(NSString *)task dueDateAfter:(int)days
{
    return [Todo todoWithTask:task due:[NSDate dateWithTimeIntervalSinceNow:(days * 60 * 60 *24)]];
}

-(NSString *)dueString
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat stringFromDate:_due];
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<Todo due:%@task:%@>",_due,_task];
}


@end
