//
//  Tab1ViewController_v3.h
//  leopaard
//
//  Created by haicuan139 on 15-1-21.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "EDColor.h"
#import "SBJson.h"
#import "itemCell.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"
#import "LEDelegate.h"
#import "Cell.h"
#import "ItemCellCollectionViewCell.h"
#import "CycleScrollView.h"
#import "AutoScrollUILable.h"
#import "UIImageView+WebCache.h"
@interface Tab1ViewController_v3 : UICollectionViewController
{
    BOOL messageHidden;
}
@property (nonatomic ,retain) NSMutableArray *currentData;
@property (nonatomic ,retain) UIBarButtonItem *rightItem;
@property (nonatomic ,retain) UIView *messageView;
@property (nonatomic ,retain) CycleScrollView *autoScrollview;
-(void)actionRightItemClick:(id)sender;
-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden;
-(void)execute:(NSNotification *)notification;
-(void)initData;
-(void)messageHiddenAction:(UIButton *)button;
-(void)addMessageButton;
-(void)addHeaderScrollView;
@end
