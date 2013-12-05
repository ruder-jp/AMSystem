//
//  SettingDisplay.h
//  AMSystem
//
//  Created by わたる on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingDisplay : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) NSMutableArray *dataSource;

@property(nonatomic, strong) NSString *idstartTimeCell;
@property(nonatomic, strong) NSString *idendTimeCell;
@property(nonatomic, strong) NSString *idstartRestCell;
@property(nonatomic, strong) NSString *idendRestCell;

@end
