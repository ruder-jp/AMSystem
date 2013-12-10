//
//  AlterationViewController.m
//  AMSystem
//
//  Created by ブロス on 13/12/05.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "AlterationViewController.h"

#import "TimeModel.h"
#import "RestModel.h"
#import "Time.h"
#import "Rest.h"
#import "WorkModel.h"
#import "Work.h"


@interface AlterationViewController ()

@property (nonatomic, retain) Time*  time;
@property (nonatomic, retain) WorkModel* worksModel;
@property (nonatomic, retain) Work* works;



@end

@implementation AlterationViewController

@synthesize delegate,date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.worksModel = [[WorkModel alloc]init];
    self.works = [[Work alloc]init];
    
    _startTime.delegate = self;
    _endTime.delegate = self;
	// Do any additional setup after loading the view.
    
    //_authorTextField.text     = self.book.author;
    NSArray* dateArray = [self.worksModel datas:date[0]];
    NSArray* timeArray = [self.worksModel datas:date[0]];
    
    int count = [dateArray count];
    for(int i = 0; i < count;i++)
    {
        Work* tmp = dateArray[i];
        _startTime.text = tmp.start;
        _endTime.text = tmp.end;
    }
    
    if( self.work )
	{
		_startTime.text      = self.work.start;
		_endTime.text     = self.work.end;
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 完了ボタンが押された時に発生します。
 *
 * @param sender 送信者データ。
 */
- (void)done:(id)sender
{
	Work* newWork = [[Work alloc] init];
	newWork.day_id    = self.work.day_id;
	newWork.start     = _startTime.text;
	newWork.end    = _endTime.text;
	//newWork.copyright = _copyrightDatePicker.date;
    
	if( self.work )
	{
		//[self.delegate editWorkDidFinish:self.work newWork:newWork];
	}
	else
	{
		//[self.delegate addWorkDidFinish:newWork];
	}
}

- (void)checkDone
{
	self.navigationItem.rightBarButtonItem.enabled = ( _startTime.text.length > 0 && _endTime.text.length > 0 );
}

@end
