//
//  MainTabBarViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-18.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroPage.h"
#import "EAIntroView.h"
#import "EDColor.h"
#import "FMDatabase.h"
#import "UIColor+Hex.h"
@interface MainTabBarViewController : UITabBarController <EAIntroDelegate>
-(void)initNavcationPage;
-(void)initDatabase;
@end
