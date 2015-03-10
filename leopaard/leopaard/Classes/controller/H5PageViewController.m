//
//  H5PageViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-18.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "H5PageViewController.h"

@interface H5PageViewController ()

@end

@implementation H5PageViewController
-(void)backButtonItemAction:(id)sender{
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"界面展示"];
    self.navigationController.navigationBarHidden = NO;
    //重新设定大小
    _webview.frame = self.view.frame;
    _webview.delegate = self;
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSURL *url =[NSURL URLWithString:delegate.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = NO;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //网页加载失败
    [FVCustomAlertView hideAlertFromView:self.view fading:NO];
    [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"加载超时!"];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页加载完成
    NSLog(@"加载完成");
    [FVCustomAlertView hideAlertFromView:self.view fading:YES];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [self.webview loadRequest:request];
        return NO;
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //网页开始加载
    [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:@"加载中.."];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
