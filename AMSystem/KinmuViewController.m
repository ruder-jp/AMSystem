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
}
@property(nonatomic,retain)WorkModel* worksModel;
@property(nonatomic,retain)Work* work;


@end

@implementation KinmuViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Custom initialization
    self.worksModel = [[WorkModel alloc]init];
    self.work = [[Work alloc]init];
    
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
    return @"日付　　　       始業　　      　 終業";
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //今月の日数を取得
    NSDate *now = [NSDate date];
    /* NSCalendarを取得する */
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];;
    NSInteger daysOfThisMonth =[ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now ].length;
    daysnum = daysOfThisMonth;
    return daysOfThisMonth;
}


/*
 セルの内容を返す
 まだ途中セルに日付を出力しようとしたら４筒増加する
 
 */



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    if(indexPath.row == 0) {
        cell.textLabel.text = [self passString:@"1"];
    } else if(indexPath.row == 1){
        cell.textLabel.text = [self passString:@"2"];
    } else if(indexPath.row == 2){
        cell.textLabel.text = [self passString:@"3"];
    } else if(indexPath.row == 3){
        cell.textLabel.text = [self passString:@"4"];
    } else if(indexPath.row == 4){
        cell.textLabel.text = [self passString:@"5"];
    } else if(indexPath.row == 5){
        cell.textLabel.text = [self passString:@"6"];
    } else if(indexPath.row == 6){
        cell.textLabel.text = [self passString:@"7"];
    } else if(indexPath.row == 7){
        cell.textLabel.text = [self passString:@"8"];
    } else if(indexPath.row == 8){
        cell.textLabel.text = [self passString:@"9"];
    } else if(indexPath.row == 9){
        cell.textLabel.text = [self passString:@"10"];
    } else if(indexPath.row == 10){
        cell.textLabel.text = [self passString:@"11"];
    } else if(indexPath.row == 11){
        cell.textLabel.text = [self passString:@"12"];
    } else if(indexPath.row == 12){
        cell.textLabel.text = [self passString:@"13"];
    } else if(indexPath.row == 13){
        cell.textLabel.text = [self passString:@"14"];
    } else if(indexPath.row == 14){
        cell.textLabel.text = [self passString:@"15"];
    } else if(indexPath.row == 15){
        cell.textLabel.text = [self passString:@"16"];
    } else if(indexPath.row == 16){
        cell.textLabel.text = [self passString:@"17"];
    } else if(indexPath.row == 17){
        cell.textLabel.text = [self passString:@"18"];
    } else if(indexPath.row == 18){
        cell.textLabel.text = [self passString:@"19"];
    } else if(indexPath.row == 19){
        cell.textLabel.text = [self passString:@"20"];
    } else if(indexPath.row == 20){
        cell.textLabel.text = [self passString:@"21"];
    } else if(indexPath.row == 21){
        cell.textLabel.text = [self passString:@"22"];
    } else if(indexPath.row == 22){
        cell.textLabel.text = [self passString:@"23"];
    } else if(indexPath.row == 23){
        cell.textLabel.text = [self passString:@"24"];
    } else if(indexPath.row == 24){
        cell.textLabel.text = [self passString:@"25"];
    } else if(indexPath.row == 25){
        cell.textLabel.text = [self passString:@"26"];
    } else if(indexPath.row == 26){
        cell.textLabel.text = [self passString:@"27"];
    } else if(indexPath.row == 27){
        cell.textLabel.text = [self passString:@"28"];
    } else if(indexPath.row == 28){
        cell.textLabel.text = [self passString:@"29"];
    } else if(indexPath.row == 29){
        cell.textLabel.text = [self passString:@"30"];
    } else {
        cell.textLabel.text = [self passString:@"31"];
    }    
    return cell;
    
}

-(NSString*)passString:(NSString*)days
{
    NSString* dayNumber;
    if(days.length < 2){
        dayNumber = [NSString stringWithFormat:@"0%@",days];
    }else{
        dayNumber = days;
    }
    NSLog(@"%@",dayNumber);
    NSArray* array = [self.worksModel datas:dayNumber];
    int count = [array count];
    date = date + 1;
    NSString *dateText;
    if(count != 0){
        for(int i=0;i < count;i++){
            Work* tmp = array[i];
            dateText = [[NSString alloc]initWithFormat:@"%@                     %@              %@",days,tmp.start,tmp.end];
        }
    }else{
        dateText = days;
    }
    return dateText;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     AlterationViewController   *alteration = [self.storyboard instantiateViewControllerWithIdentifier:@"alteration"];
    alteration.title = @"勤務時間設定";
    [[self navigationController] pushViewController:alteration animated:YES];
    
}

- (IBAction)kinmuBackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


@end
