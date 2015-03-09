//
//  Tab1ViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "Tab1ViewController.h"

@interface Tab1ViewController ()

@end

@implementation Tab1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushViewControllerWithStorboardName:@"login" sid:@"login" hiddenTabBar:YES];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

        _gmGridView.mainSuperView = self.navigationController.view;
}

-(void)loadView{
    [super loadView];
    [self initview];
}
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden
{
    NSLog(@"调用了PushView");
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    controller.hidesBottomBarWhenPushed = hidden;
    [controller retain];
    [self.navigationController pushViewController:controller animated:YES];

}
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
-(void)execute:(NSNotification *)notification{
    [self initData];
    [_gmGridView reloadData];
}

-(void)initview{
     [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(execute:)
                                                name:USER_TYPE
                                                   object:nil];
    [self initData];
    NSInteger spacing = INTERFACE_IS_PHONE ? 6 : 5;
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor colorWithHexString:@"#EFEEF4"];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
//    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _gmGridView.centerGrid = NO;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;

    //初始化左面
//
//    _leftItem = [[UIBarButtonItem alloc ] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(actionLeftItemClick:)];
//    [_leftItem setTintColor:[UIColor whiteColor]];
//    self.navigationItem.leftBarButtonItem = _leftItem;
    
    //初始化右面
    _rightItem = [[UIBarButtonItem alloc ] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightItemClick:)];
    [_rightItem  setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = _rightItem;
}
- (void)actionLeftItemClick:(id)sender{

        [_gmGridView setEditing:!_gmGridView.editing animated:YES];
    [_gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];
}
- (void)actionRightItemClick:(id)sender{
    NSLog(@"点击右面");
    [self pushViewControllerWithStorboardName:@"login" sid:@"login" hiddenTabBar:NO];
}
- (void)GMGridView:(GMGridView *)gridView changedEdit:(BOOL)edit{
    if (edit) {
        [_leftItem setTitle:@"取消"];
    } else {
        [_leftItem setTitle:@"编辑"];
    }
}
- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{

    NSObject *object = [_currentData objectAtIndex:oldIndex];
    [_currentData removeObject:object];
    [_currentData insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    NSLog(@"交换?%ld,%ld",(long)index1,(long)index2);
    [_currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}
- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{

    return YES;
}
- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor whiteColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}
//#pragma -mark 删除按钮事件
//-(void)deleteItemButtonCallBack:(UIButton *)sender{
//    NSLog(@"点击删除按钮");
//    NSInteger index = sender.tag - 10000;
//    if ([_currentData count] > 0)
//    {
//        [_gmGridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
//        [_currentData removeObjectAtIndex:index];
//    }
//}
#pragma -mark 开始移动
-(void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell position:(NSInteger)index{

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor whiteColor];
                         cell.contentView.layer.shadowOpacity = 0.2;
                     }
                     completion:nil
     ];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_currentData removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
    }
}
- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
//    
//    [alert show];
    
    _lastDeleteItemIndexAsked = index;
    [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束");
}
#pragma -mark item点击事件
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell *cell = [gridView cellForItemAtIndex:position];
    [[cell viewWithTag:ITEMVIEW_TAG] setBackgroundColor:[UIColor colorWithHexString:@"#EFEEF4"]];
    double delayInSeconds = 0.2f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[cell viewWithTag:ITEMVIEW_TAG] setBackgroundColor:[UIColor whiteColor]];
    });
    if (!_gmGridView.editing) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *dic = [_currentData objectAtIndex:position];
        NSString *url = [dic objectForKey:@"url"];
        delegate.url = url;
        [self pushViewControllerWithStorboardName:@"h5page" sid:@"h5page"hiddenTabBar:YES];
        NSLog(@"点击事件");
    }

}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}
- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_currentData count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    //获得屏幕尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
//    CGFloat height = size.height;
    NSInteger wh = width / 5 + 9;
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(wh, wh);//103 * 123
        }
        else
        {
            return CGSizeMake(wh, wh);//103 * 123

        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 205);
        }
        else
        {
            return CGSizeMake(230, 175);
        }
    }
}
#pragma -mark 初始化cell
- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{

    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    
    if (!cell)
    {

        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        cell.deleteButtonOffset = CGPointMake(5, 5);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 0;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //初始化ItemView
    UIView *itemView = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    itemView.layer.masksToBounds = YES;
    itemView.layer.cornerRadius = 5;
    itemView.tag = ITEMVIEW_TAG;
    itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    itemView.backgroundColor = [UIColor whiteColor];
    //初始化图标
    UIImageView *icon = [[UIImageView alloc]init];
    NSDictionary *dic = [_currentData objectAtIndex:index];
    NSString *iconName = [dic objectForKey:@"icon"];
    [icon setImage:[UIImage imageNamed:iconName]];
    
    CGFloat iconW = size.width/2.5f;
    CGFloat iconH = iconW;
    CGFloat iconX = (size.width/2) - (iconH / 2);
    CGFloat iconY = size.height/4;
    icon.frame = CGRectMake(iconX, iconY, iconW,iconH);
    //初始化文字
    UIButton *lable = [[UIButton alloc]init];

    lable.titleLabel.font = [UIFont boldSystemFontOfSize:11];

    [lable setTitle:[dic objectForKey:@"title"] forState:UIControlStateNormal];
    [lable setTitleColor:[UIColor colorWithHexString:@"#858687"] forState:UIControlStateNormal];
    lable.frame = CGRectMake(0, size.height / 4 + iconH * 1.1f, size.width, 20);
    [itemView addSubview:icon];
    [itemView addSubview:lable];
    [cell.contentView addSubview:itemView];

    return cell;
}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    if (index == [_currentData count] - 1) {
        return NO;
    }
    return YES; //index % 2 == 0;
}
- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %ld", (long)index];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}
- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{

    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.2;
                     }
                     completion:nil];
}
- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    NSLog(@"拖拽结束");
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor whiteColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}


- (void)addMoreItem
{
    // Example: adding object at the last position
    NSString *newItem = [NSString stringWithFormat:@"%d", (int)(arc4random() % 1000)];
    [_currentData addObject:newItem];
    [_gmGridView insertObjectAtIndex:[_currentData count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
}

- (void)removeItem
{
    // Example: removing last item
    if ([_currentData count] > 0)
    {
        NSInteger index = [_currentData count] - 1;
        
        [_gmGridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
        [_currentData removeObjectAtIndex:index];
    }
}





@end
