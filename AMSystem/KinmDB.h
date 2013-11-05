//
//  KinmDB.h
//  AMSystem
//
//  Created by ブロス on 13/10/31.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Data;


@interface KinmDB : NSObject

-(Data*)insert:(Data*)data;
-(NSArray*)datas;
-(BOOL)update:(Data*)book;


@end
