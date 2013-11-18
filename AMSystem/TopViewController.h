//
//  TopViewController.h
//  AMSystem
//
//  Created by ブロス on 13/11/16.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewController : UIViewController

{
    @private
    BOOL isRevealed;
    UIViewController *contentController;
}


//就業時間の表示
@property (weak, nonatomic) IBOutlet UILabel *startLavel;

@property (weak, nonatomic) IBOutlet UILabel *endLavel;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

//始業、就業用のボタン
- (IBAction)pushButton:(id)sender;


//時計（現在時刻の表示）
@property (weak, nonatomic) IBOutlet UILabel *dayLavel;

@property (weak, nonatomic) IBOutlet UILabel *timeLavel;



@end
