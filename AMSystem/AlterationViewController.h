//
//  AlterationViewController.h
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KinmuDelegate

@end

@interface AlterationViewController : UIViewController

@property (nonatomic, assign) id<KinmuDelegate> delegate; 
@property (nonatomic, retain) NSArray*  date;


@end
