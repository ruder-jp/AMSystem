//
//  KinmuViewController.m
//  AMSystem
//
//  Created by ブロス on 13/11/01.
//  Copyright (c) 2013年 abcc_joko4. All rights reserved.
//

#import "KinmuViewController.h"
#import "WorkModel.h"
#import "Work.h"

@interface KinmuViewController ()
{
    NSInteger daysnum;
    int date;
    NSString* monthDate;
}
@property(nonatomic,retain)WorkModel* worksModel;
@property(nonatomic,retain)Work* work;


@end

@implementation KinmuViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Custom initialization
    self.worksModel = [[WorkModel alloc]init];
    self.work = [[Work alloc]init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateVisibleCells];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{ 
    return @"日付(曜日)　　 始業　　      　 終業";
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //今月の日数を取得
    NSDate *now = [NSDate date];
    /* NSCalendarを取得する */
    NSDate *month = [NSDate date];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"yyyy-MM"];
    NSString *monthStr = [monthFormatter stringFromDate:month];
    monthDate = monthStr;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];;
    NSInteger daysOfThisMonth =[ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now ].length;
    daysnum = daysOfThisMonth;
    return daysOfThisMonth;
    
}

-(NSString*)passMonth
{
    NSDate *month = [NSDate date];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"yyyy-MM"];
    NSString *monthStr = [monthFormatter stringFromDate:month];
    return monthStr;
}


/*
 セルの内容を返す
 まだ途中セルに日付を出力しようとしたら４筒増加する
 
 */
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString* number = [[NSString alloc] initWithFormat:@"%d",indexPath.row + 1];
    cell.textLabel.text = [self passString:number];
    cell.backgroundColor =[self daycolor:number];
}

- (void)updateVisibleCells {
    for (UITableViewCell *cell in [self.tableView visibleCells]){
        [self updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [self updateCell:cell atIndexPath:indexPath]; 
    return cell;
    
}



-(NSString*)passString:(NSString*)day
{
    NSString* dayNumber;
    
    if(day.length < 2){
        dayNumber = [NSString stringWithFormat:@"0%@",day];
        day = [NSString stringWithFormat:@" %@ ",day];
            
    }else{
        dayNumber = day;
    }
    
    NSArray* array = [self.worksModel datas:dayNumber];
    int count = [array count];
    date = date + 1;
    NSString *dateText;
    if(count != 0){
        for(int i=0;i < count;i++){
            Work* tmp = array[i];
            dateText = [[NSString alloc]initWithFormat:@"%@%@                %@              %@",day,[self stringWeekDay:day],tmp.start,tmp.end];
        }
    }else{
        dateText =[[NSString alloc]initWithFormat:@"%@%@",day,[self stringWeekDay:day]];
    }
    return dateText;
}

-(NSArray*)passArray:(NSString*)day
{
    NSString* dayNumber;
    if(day.length < 2){
        dayNumber = [NSString stringWithFormat:@"0%@",day];
    }else{
        dayNumber = day;
    }
    NSMutableString *fusion = [NSMutableString stringWithString: monthDate];
    [fusion appendFormat:@"-%@",dayNumber];
    NSArray* array = [self.worksModel datas:dayNumber];
    NSArray* passDate;
    int count = [array count];
    date = date + 1;
    if(count != 0){
        for(int i=0;i < count;i++){
            Work* tmp = array[i];
            passDate = [NSArray arrayWithObjects:fusion,tmp.start,tmp.end, nil];
        }
    }else{
         passDate = [NSArray arrayWithObjects:fusion,@"",@"",nil];
    }
    return passDate;
}

-(NSString*)stringWeekDay:(NSString*)day
{
    NSString* dayNumber;
    NSString* backDate;
    NSArray* arrayWeekday = [NSArray arrayWithObjects:@"",@"(日)",@"(月)",@"(火)",@"(水)",@"(木)",@"(金)",@"(土)",nil];
    if(day.length < 2){
        dayNumber = [NSString stringWithFormat:@"0%@",day];
    }else{
        dayNumber = day;
    }
    NSMutableString *fusion = [NSMutableString stringWithString: monthDate];
    [fusion appendFormat:@"-%@",dayNumber];
    NSInteger weekday = [self weekday:fusion];
    backDate = arrayWeekday[weekday];
    return backDate;
}

-(UIColor*)daycolor:(NSString*)day
{
    NSString* dayNumber;
    if(day.length < 2){
        dayNumber = [NSString stringWithFormat:@"0%@",day];
    }else{
        dayNumber = day;
    }
    NSMutableString *fusion = [NSMutableString stringWithString: monthDate];
    [fusion appendFormat:@"-%@",dayNumber];
    NSInteger weekday = [self weekday:fusion];
    UIView* setView = [[UIView alloc]init];
    if(weekday == 7)
    {
        setView.backgroundColor = [UIColor cyanColor];
        return setView.backgroundColor;
    }else if(weekday == 1){
        setView.backgroundColor = [UIColor redColor];
        return setView.backgroundColor;
    }else{
        setView.backgroundColor = [UIColor whiteColor];
        return setView.backgroundColor;

    }
}

-(NSInteger)weekday:(NSString*)day
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * days = [dateFormatter dateFromString:day];
    NSCalendar* gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [gregorian components:(NSDayCalendarUnit|NSWeekdayCalendarUnit)fromDate:days];
    NSInteger intWeekday = [weekdayComponents weekday];
    
    return intWeekday;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger number = indexPath.row +1;
    NSString* numberStr = [NSString stringWithFormat:@"%d",number];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     AlterationViewController   *alteration = [self.storyboard instantiateViewControllerWithIdentifier:@"alteration"];
    alteration.delegate = self;
    alteration.date = [self passArray:numberStr];
    alteration.title = @"勤務時間変更";
    [[self navigationController] pushViewController:alteration animated:YES];
    
}


- (IBAction)kinmuBackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


@end
