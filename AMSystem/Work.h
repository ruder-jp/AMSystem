//
//  Works.h
//  AMSystem
//
//  Created by ブロス on 13/11/19.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Work : NSObject

@property (nonatomic,assign) NSInteger day_id;
@property (nonatomic,assign) NSString* date;
@property (nonatomic,assign) NSString* start;
@property (nonatomic,assign) NSString* end;
@property (nonatomic,assign) NSInteger time_id;
@property (nonatomic,assign) NSInteger rest_id;

@end
