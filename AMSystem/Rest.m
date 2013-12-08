//
//  Rests.m
//  AMSystem
//
//  Created by ブロス on 13/11/19.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "Rest.h"

@implementation Rest

@synthesize rest_id,start,end;

-(id)init
{
    if(self = [super init]){
        self.rest_id = 1;
        self.start = nil;
        self.end = nil;
    }
    return self;
}

@end
