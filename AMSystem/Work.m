//
//  Works.m
//  AMSystem
//
//  Created by ブロス on 13/11/19.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "Work.h"



@implementation Work

@synthesize day_id,date,start,end,time_id,rest_id;

-(id)init
{
    if(self = [super init]){
        self.day_id = 0;
        self.date  = nil;
        self.start = nil;
        self.end = nil;
        self.time_id = 0;
        self.rest_id = 0;
    }
    return self;
}


@end
