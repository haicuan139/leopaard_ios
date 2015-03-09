//
//  H5PageViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-18.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FVCustomAlertView.h"
@interface H5PageViewController : UIViewController <UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webview;
-(void)backButtonItemAction:(id)sender;
@end
