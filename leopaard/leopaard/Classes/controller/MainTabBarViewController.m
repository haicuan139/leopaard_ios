//
//  MainTabBarViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-18.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "Header.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor colorWithHexString:@"#13369B"]];
    
//    [self initDatabase];
    // Do any additional setup after loading the view.
}

#pragma -mark 初始化数据库
-(void)initDatabase{
    
    //初始化首页默认数据
    //1.创建数据库与数据表
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    } else {
        NSLog(@"打开成功!");
    }
    //创建首页数据表
    [db executeUpdate:@"CREATE TABLE db_tab_home (iconname text, textname text, url text, data_1 text, data_2 text, data_3 text)"];
    //创建资讯数据表
    [db executeUpdate:@"CREATE TABLE db_tab_zixun (iconname text, textname text, url text, data_1 text, data_2 text, data_3 text)"];
    //创建培训数据表
    [db executeUpdate:@"CREATE TABLE db_tab_peixun (iconname text, textname text, url text, data_1 text, data_2 text, data_3 text)"];
    //创建更多数据表
    [db executeUpdate:@"CREATE TABLE db_tab_more (iconname text, textname text, url text, data_1 text, data_2 text, data_3 text)"];
    //2.将默认数据插入到数据库中
    
    
    //初始化资讯数据
    //初始化培训数据
    //初始化更多数据
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initNavcationPage{
    EAIntroPage *page1 = [EAIntroPage page];

    page1.bgImage = [UIImage imageNamed:@"welcome_bg_1.jpg"];

    
    EAIntroPage *page2 = [EAIntroPage page];

    page2.bgImage = [UIImage imageNamed:@"welcome_bg_2.jpg"];


    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}
- (void)introDidFinish{

}
@end
