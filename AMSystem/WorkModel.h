//
//  WorkModel.h
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Work;

@interface WorkModel : NSObject

-(Work*)insertStart:(Work*)data;
-(NSArray*)datas;
-(NSArray*)tests;
-(BOOL)update:(Work*)work;
-(BOOL)updateEnd:(Work *)work;

@end
