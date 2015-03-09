//
//  FirstViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-7.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

-(void)pushViewControllerWithStorboardName:(NSString *)storyboardName sid:(NSString *)id hiddenTabBar:(BOOL)hidden;
@end

