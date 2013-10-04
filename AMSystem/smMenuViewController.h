//
//  smMenuViewController.h
//  AMSystem
//
//  Created by ブロス on 13/09/12.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SmMenuViewController : UIViewController
{
@private
    BOOL isRevealed;
    UIViewController *contentController;
}

-(void)toggleMenuController;

@end
