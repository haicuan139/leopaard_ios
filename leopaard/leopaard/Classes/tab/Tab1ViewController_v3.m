//
//  Tab1ViewController_v3.m
//  leopaard
//
//  Created by haicuan139 on 15-1-21.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "Tab1ViewController_v3.h"

@interface Tab1ViewController_v3 ()

@end

@implementation Tab1ViewController_v3

static NSString * const reuseIdentifier = @"ItemCellCollectionViewCell";


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_currentData count];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 3.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)
collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCellCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [_currentData objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *iconName = [dic objectForKey:@"icon"];
    cell.itemLable.text = title;
    [cell.imageIcon setImage:[UIImage imageNamed:iconName]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 70);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSInteger h = 140;
    if (messageHidden) {
        h = 110;
    }
    return UIEdgeInsetsMake(h, 5, 5, 5);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        self.navigationController.navigationBarHidden = YES;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *dic = [_currentData objectAtIndex:[indexPath row]];
    NSString *url = [dic objectForKey:@"url"];
    delegate.url = url;
    [self pushViewControllerWithStorboardName:@"h5page" sid:@"h5page" hiddenTabBar:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)addMessageButton{
    messageHidden = NO;
    _messageView.frame = CGRectMake(0, 100 , self.view.frame.size.width, 33);
    
    AutoScrollUILable *textLable = [[AutoScrollUILable alloc]init];//添加Lable
    [textLable setText:@"雷迪斯按的剪头们你们号码！雷迪斯按的剪头们你们号码！雷迪斯按的剪头们你们号码！"];
    textLable.frame = CGRectMake(5, 0, self.view.frame.size.width*2, 33);
    textLable.textColor = [UIColor colorWithHexString:@"#333333"];
    [textLable setFont:[UIFont fontWithName:nil size:13]];
    [_messageView addSubview:textLable];
    _messageView.backgroundColor = [UIColor colorWithHexString:@"#FFF777"];
    [self.collectionView addSubview:_messageView];
    [self.collectionView reloadData];
}
-(void)addHeaderScrollView{
    //测试数据
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor greenColor];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    UIImageView *image = [[UIImageView alloc]initWithFrame:view.frame];
    [image setImage: [UIImage imageNamed:@"test.jpg"]];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:view.frame];
    [image1 setImage:[UIImage imageNamed:@"test2.jpg"]];
    NSArray *views = [[NSArray alloc]initWithObjects:image,image1, nil];
    
    //TODO:添加可以轮播的ScrollView
    [self.collectionView addSubview:view];
    _autoScrollview = [[CycleScrollView alloc] initWithFrame:view.frame animationDuration:2];
    _autoScrollview.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        
        return views[pageIndex];
    };
    _autoScrollview.totalPagesCount = ^NSInteger(void){
        return views.count;
    };
    _autoScrollview.TapActionBlock = ^(NSInteger pageIndex){
        //点击事件
    };
    _autoScrollview.TapChangeBlock = ^(NSInteger pageIndex){
        //切换界面的回调
    };
    [view addSubview:_autoScrollview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    messageHidden = YES;
    [self addHeaderScrollView];
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y - [[UIApplication sharedApplication] statusBarFrame].size.height, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    //添加message view
    _messageView = [[UIView alloc]init];
    self.navigationController.navigationBarHidden = YES;
    self.title = @"通用";
   _rightItem = [[UIBarButtonItem alloc ] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightItemClick:)];
    [_rightItem  setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = _rightItem;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:USER_TYPE
                                               object:nil];
    // Register cell classes
    [self.collectionView registerClass:[ItemCellCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self initData];
    [self addMessageButton];
}
-(void)messageHiddenAction:(UIButton *)button{
    messageHidden = YES;
    //隐藏messageView,开启动画
    [UIView animateWithDuration:0.3 animations:^{
        _messageView.frame = CGRectMake(0, 100 - 30 , self.view.frame.size.width, 30);
        _messageView.alpha = 0;
    } completion:^(BOOL finished) {
        [_messageView removeFromSuperview];
    }];
    [self.collectionView reloadData];
}
-(void)dealloc{
    [super dealloc];
//    [_currentData release];
//    [_rightItem release];
}
-(void)actionRightItemClick:(id)sender{
        [self pushViewControllerWithStorboardName:@"login" sid:@"login" hiddenTabBar:YES];
}
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden{
    UIStoryboard* st = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *controller = [st instantiateViewControllerWithIdentifier:id];
    controller.hidesBottomBarWhenPushed = hidden;
    [controller retain];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)execute:(NSNotification *)notification{
    [self initData];
    [self.collectionView reloadData];
}

-(void)initData{
    _currentData = [[NSMutableArray alloc]init];
    LEDelegate *de = [[LEDelegate alloc]init];
    _currentData = [de getItemDicWithTabType:ITEM_TYPE_TONGYONG];
    
}
@end
