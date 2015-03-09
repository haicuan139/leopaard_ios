//
//  Tab1ViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"
#import "EDColor.h"
#import "SBJson.h"
#import "GMGridView.h"
#import "GMGridView-Prefix.pch"
#import "ODRefreshControl.h"
#define NUMBER_ITEMS_ON_LOAD 20
#define NUMBER_ITEMS_ON_LOAD2 30
#define IPHONE4_SCREEN_HEIGHT 480
#define IPHONE5_SCREEN_HEIGHT 568
#define IPHONE6_SCREEN_HEIGHT 568
#define ITEMVIEW_TAG 19
#define DELETE_BUTTON_TAG 87

@interface Tab1ViewController : UIViewController<GMGridViewDataSource , GMGridViewActionDelegate , GMGridViewSortingDelegate , GMGridViewTransformationDelegate>
{
    __gm_weak GMGridView *_gmGridView;
//    __gm_weak NSMutableArray *_currentData;
//    NSMutableArray *_data;
    NSInteger _lastDeleteItemIndexAsked;
    NSInteger finalDeletePosition;
    UIBarButtonItem *_rightItem;
    UIBarButtonItem *_leftItem;


}
@property (nonatomic ,retain) NSMutableArray *currentData;
@property (nonatomic ,retain)     NSMutableArray *data;
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
-(void)initData;
- (void)addMoreItem;
- (void)removeItem;
- (void)initview;
- (void)actionLeftItemClick:(id)sender;
- (void)actionRightItemClick:(id)sender;
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden;
- (void)execute:(NSNotification *)notification;
//-(void)deleteItemButtonCallBack:(UIButton *)sender;
@end
