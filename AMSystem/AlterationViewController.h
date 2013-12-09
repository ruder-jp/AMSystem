//
//  AlterationViewController.h
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Work;

@protocol EditWorkDelegate
@end

@interface AlterationViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *startRest;
@property (weak, nonatomic) IBOutlet UITextField *endRest;

@property (nonatomic, assign) id<EditWorkDelegate> delegate; //! 書籍の追加、または編集画面が完了したことを通知するデリゲート
@property (nonatomic, retain) Work*                work;     //! 編集対象となる書籍

//@property (nonatomic, assign) id<AlterationViewDelegate> delegate; //! 書籍の追加、または編集画面が完了したことを通知するデリゲート

//@property (nonatomic, retain) NSArray*  date;
//

@end
