//
//  Tab2TableViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-8.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "AppDelegate.h"
#include "Header.h"
#import "CustomTableViewCell.h"
#import "LEDelegate.h"
@interface Tab2TableViewController : UITableViewController
@property (nonatomic,retain) NSMutableArray *currentData;
-(void)initdata;
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden;
- (void)execute:(NSNotification *)notification;
@end
