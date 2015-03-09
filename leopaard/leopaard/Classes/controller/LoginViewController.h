//
//  LoginViewController.h
//  leopaard
//
//  Created by haicuan139 on 14-12-15.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FVCustomAlertView.h"
#import "Header.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIButton *login_button;
@property (retain, nonatomic) IBOutlet UITextField *login_username;
@property (retain, nonatomic) IBOutlet UITextField *login_password;
@property (retain, nonatomic) IBOutlet UIButton *login_back;
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *login_lable_1;
@property (retain, nonatomic) IBOutlet UILabel *login_lable_2;
@property (retain, nonatomic) IBOutlet UILabel *login_lable_3;
@property (retain, nonatomic) IBOutlet UIScrollView *rootScrollView;

- (IBAction)loginAction:(id)sender;
-(void)resetViewPosition;
-(void)login;
-(void)backButtonItemAction:(id)sender;
-(void)keyboardHide:(UITapGestureRecognizer*)tap;
-(void)initNavcationPage;
@end
