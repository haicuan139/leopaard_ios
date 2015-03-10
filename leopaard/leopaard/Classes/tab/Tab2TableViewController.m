//
//  Tab2TableViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "Tab2TableViewController.h"

@interface Tab2TableViewController ()

@end

@implementation Tab2TableViewController

-(void)initdata{
    _currentData = [[NSMutableArray alloc]init];
//    SBJsonParser    *parser     = [[SBJsonParser alloc] init];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSInteger type = [ud integerForKey:USER_TYPE];
//    NSString *typeJson = @"";
//    if (type == 0) {
//        typeJson = @"zixun_a";
//    } else {
//        typeJson = @"zixun_b";
//    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:typeJson ofType:@"json"];
//    NSError *error=nil;
//    NSString *str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//    NSDictionary    *rootDic = [parser objectWithString:str];
//    _currentData = [rootDic objectForKey:@"rows"];
    LEDelegate *de = [[LEDelegate alloc]init];
    _currentData = [de getItemDicWithTabType:ITEM_TYPE_ZIXUN];
}
- (void)execute:(NSNotification *)notification{
    [self initdata];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _currentData.count;
}

-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden
{
    NSLog(@"调用了PushView");
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    controller.hidesBottomBarWhenPushed = hidden;
    [self.navigationController pushViewController:controller animated:YES];
    
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initdata];
    [self.tableView reloadData];
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


@end
