//
//  Tab4TableViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "Tab4TableViewController.h"

@interface Tab4TableViewController ()

@end

@implementation Tab4TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:USER_TYPE
                                               object:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self initdata];

}
- (void)execute:(NSNotification *)notification{
    [self initdata];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)initdata{
//    _currentData = [[NSMutableArray alloc]init];
//    SBJsonParser    *parser     = [[SBJsonParser alloc] init];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"gengduo" ofType:@"json"];
//    NSError *error=nil;
//    NSString *str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//    NSDictionary    *rootDic = [parser objectWithString:str];
//    _currentData = [rootDic objectForKey:@"rows"];
    _currentData = [[NSMutableArray alloc]init];
    LEDelegate *de = [[LEDelegate alloc]init];
    _currentData = [de getItemDicWithTabType:ITEM_TYPE_GENGDUO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initdata];
    [self.tableView reloadData];
}
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden{
    NSLog(@"调用了PushView");
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    controller.hidesBottomBarWhenPushed = hidden;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *dic = [_currentData objectAtIndex:indexPath.row];
    NSString *url = [dic objectForKey:@"url"];
    delegate.url = url;
    [self pushViewControllerWithStorboardName:@"h5page" sid:@"h5page" hiddenTabBar:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _currentData.count;
}
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomTableViewCell";
    CustomTableViewCell *cell = (CustomTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *marray = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [marray objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }

    NSDictionary *dic = [_currentData objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *iconName = [dic objectForKey:@"icon"];
    cell.titleLable.text = title;
    [cell.iconImageView setImage:[UIImage imageNamed:iconName]];
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
