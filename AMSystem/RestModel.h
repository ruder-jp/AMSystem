//
//  RestModel.h
//  AMSystem
//
//  Created by ブロス on 13/11/21.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rest;

@interface RestModel : NSObject

- (BOOL)update:(Rest *)rest;

- (Rest*)setting;
@end
