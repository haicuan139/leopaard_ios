//
//  Tab1ViewController_v2.h
//  leopaard
//
//  Created by haicuan139 on 15-1-21.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "Cell.h"
#import "Header.h"
#import "SBJson.h"
@interface Tab1ViewController_v2 : UIViewController<UIGridViewDelegate>
@property (nonatomic, retain) UIGridView *table;
- (void)actionRightItemClick:(id)sender;
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden;
@property (nonatomic ,retain) NSMutableArray *currentData;
- (void)execute:(NSNotification *)notification;
-(void)initData;
@end
