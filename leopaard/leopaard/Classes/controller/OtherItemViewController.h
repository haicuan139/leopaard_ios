//
//  OtherItemViewController.h
//  leopaard
//
//  Created by haicuan139 on 15-1-12.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "GMGridView.h"
#import "GMGridView-Prefix.pch"
#import "EDColor.h"
#import "ODRefreshControl.h"
#import "SBJson.h"
#define ITEMVIEW_TAG 199
@interface OtherItemViewController : UIViewController <GMGridViewDataSource , GMGridViewActionDelegate , GMGridViewSortingDelegate , GMGridViewTransformationDelegate>
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
- (void)initview;
-(void)initData;
- (void)dataSetChange:(UISegmentedControl *)control;

@end
