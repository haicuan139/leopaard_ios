//
//  AppDelegate.h
//  leopaard
//
//  Created by haicuan139 on 14-12-7.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSString *url;
-(float)getAppVersion;

@end

