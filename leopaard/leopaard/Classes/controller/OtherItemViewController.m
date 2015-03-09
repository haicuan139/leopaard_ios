//
//  OtherItemViewController.m
//  leopaard
//
//  Created by haicuan139 on 15-1-12.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "OtherItemViewController.h"

@interface OtherItemViewController ()

@end

@implementation OtherItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _gmGridView.mainSuperView = self.navigationController.view;
}
-(void)loadView{
    [super loadView];
    [self initview];
}

-(void)initview{
    [self initData];
    NSInteger spacing = INTERFACE_IS_PHONE ? 1 : 5;
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor colorWithHexString:@"#EFEEF4"];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _gmGridView.centerGrid = NO;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;

}
-(void)initData{
    SBJsonParser    *parser     = [[SBJsonParser alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tongyong" ofType:@"json"];
    NSError *error=nil;
    NSString *str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSDictionary    *rootDic = [parser objectWithString:str];
    _currentData = [rootDic objectForKey:@"rows"];
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    
    NSObject *object = [_currentData objectAtIndex:oldIndex];
    [_currentData removeObject:object];
    [_currentData insertObject:object atIndex:newIndex];
}
- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
 
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
- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    
    _lastDeleteItemIndexAsked = index;
    [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
}
#pragma -mark item点击事件
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"点击事件");
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
    CGFloat height = size.height;
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(width/4 - 3, height/7 + 15);//103 * 123
        }
        else
        {
            return CGSizeMake(width/4 - 3, height/6);//103 * 123
            
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
    itemView.tag = ITEMVIEW_TAG;
    itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    itemView.backgroundColor = [UIColor whiteColor];
    //初始化图标
    UIImageView *icon = [[UIImageView alloc]init];
    
    [icon setImage:[UIImage imageNamed:@"test.png"]];
    CGFloat iconW = size.width/2.5f;
    CGFloat iconH = iconW;
    CGFloat iconX = (size.width/2) - (iconH / 2);
    CGFloat iconY = size.height/4;
    icon.frame = CGRectMake(iconX, iconY, iconW,iconH);
    //初始化文字
    UIButton *lable = [[UIButton alloc]init];
    
    lable.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    NSDictionary *dic = [_currentData objectAtIndex:index];
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

    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor whiteColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

@end
