//
//  Tab1ViewController_v2.m
//  leopaard
//
//  Created by haicuan139 on 15-1-21.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "Tab1ViewController_v2.h"

@interface Tab1ViewController_v2 ()

@end

@implementation Tab1ViewController_v2
@synthesize table;
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)execute:(NSNotification *)notification{
    [self.table reloadData];
}
//初始化数据
-(void)initData{
    SBJsonParser    *parser     = [[SBJsonParser alloc] init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger type = [ud integerForKey:USER_TYPE];
    NSString *typeJson = @"";
    if (type == 0) {
        typeJson = @"tongyong_a";
    } else {
        typeJson = @"tongyong_b";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:typeJson ofType:@"json"];
    NSError *error=nil;
    NSString *str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSDictionary    *rootDic = [parser objectWithString:str];
    _currentData = [rootDic objectForKey:@"rows"];
}
-(void)viewDidLoad{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:USER_TYPE
                                               object:nil];
    [self pushViewControllerWithStorboardName:@"login" sid:@"login" hiddenTabBar:YES];
    self.navigationController.navigationBarHidden = YES;
    self.table = [[UIGridView alloc]init];
    self.table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 66);
        self.table.uiGridViewDelegate = self;
    [self.view addSubview:self.table];
   UIBarButtonItem *rightItem = [[UIBarButtonItem alloc ] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightItemClick:)];
    [rightItem  setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)actionRightItemClick:(id)sender{
        [self pushViewControllerWithStorboardName:@"login" sid:@"login" hiddenTabBar:NO];
}
- (void)viewDidUnload {
    [super viewDidUnload];

}

-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden
{
    NSLog(@"调用了PushView");
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    controller.hidesBottomBarWhenPushed = hidden;
    [self.navigationController pushViewController:controller animated:YES];
    
}




- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    return 80;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 80;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 4;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
    return 33;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell *cell = (Cell *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[Cell alloc] init];
    }
    NSDictionary *dic = [_currentData objectAtIndex:index];
    cell.label.text = [NSString stringWithFormat:@"(%d,%d)", rowIndex, columnIndex];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSLog(@"%d, %d clicked", rowIndex, colIndex);
}

@end
