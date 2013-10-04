//
//  TodoTableViewCell.m
//  AMSystem
//
//  Created by ブロス on 13/09/11.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "ViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"


@implementation TodoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
