//
//  daoWorks.h
//  AMSystem
//
//  Created by ブロス on 13/11/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Work;

@interface WorkModel : NSObject

-(Work*)insertStart:(Work*)data;
-(NSArray*)datas;
-(BOOL)update:(Work*)book;


@end
