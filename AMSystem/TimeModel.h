//
//  TimeModel.h
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Time;

@interface TimeModel : NSObject

- (BOOL)update:(Time *)time;

- (Time*)setting;

@end
