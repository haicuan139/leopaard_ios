//
//  LoginViewController.m
//  leopaard
//
//  Created by haicuan139 on 14-12-15.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#import "LoginViewController.h"
#import "SBJson.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)backButtonItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_login_password resignFirstResponder];
    [_login_username resignFirstResponder];
}
-(void)initNavcationPage{
    EAIntroPage *page1 = [EAIntroPage page];
    
    page1.bgImage = [UIImage imageNamed:@"welcome_bg_1.jpg"];
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    
    page2.bgImage = [UIImage imageNamed:@"welcome_bg_2.jpg"];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2]];
    
    [intro showInView:self.view animateDuration:0.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"账户登录"];
    BOOL first = [[NSUserDefaults standardUserDefaults]boolForKey:FIRST_RUN];
    if (!first) {
        //first run
        [self initNavcationPage];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FIRST_RUN];
    }
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_rootScrollView addGestureRecognizer:tapGestureRecognizer];
    _rootScrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height + 1);
    [self resetViewPosition];
     self.view.layer.contents = (id) [UIImage imageNamed:@"login_bg"].CGImage;
    //登录按钮圆角
    _login_button.layer.cornerRadius = 4;
    _login_button.layer.masksToBounds = YES;
    _login_password.secureTextEntry = YES;
//    [_login_username becomeFirstResponder];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"返回"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    [_login_back setAttributedTitle:str forState:UIControlStateNormal];
    _login_back.hidden = YES;//隐藏返回按钮
    _login_password.delegate = self;
}

#pragma -mark 重新设置VIEW位置
-(void)resetViewPosition{
    for (id obj in self.view.subviews)  {
        UIView *view = (UIView *)obj;
        CGRect rect = view.frame;
        rect.origin.x = self.view.frame.size.width / 2 - view.frame.size.width/2;
        view.frame = rect;
    }


    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



- (void)dealloc {
    [_login_button release];
    [_login_username release];
    [_login_password release];
    [_login_back release];
    [_login_lable_1 release];
    [_login_lable_2 release];
    [_login_lable_3 release];
    [_rootScrollView release];
    [super dealloc];
}
- (IBAction)backAction:(id)sender {

    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginAction:(id)sender {

    [self login];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self login];
    return  YES;
}
-(void)login{
    UIAlertView *alert = [[UIAlertView alloc]init];
    [alert addButtonWithTitle:@"确定"];
    __block ASIFormDataRequest *request = [ ASIFormDataRequest requestWithURL :[NSURL URLWithString:@"http://114.215.84.87:8080/cflb/cflb/app_user/doLogin.htm"]];
    NSString *pass = _login_password.text;
    NSString *user = _login_username.text;
    if (pass.length != 0 && user.length != 0) {
    [request setPostValue:user forKey:@"u_name"];
    [request setPostValue:pass forKey:@"u_pwd"];
    [request setCompletionBlock:^{
        //请求完成
        NSString *responseString = [request responseString];
        NSError         *error      = nil;
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];
        NSDictionary    *rootDic    = [parser objectWithString:responseString error:&error];
        NSString *code = [rootDic objectForKey:@"code"];
        NSString *msg = [rootDic objectForKey:@"msg"];
        if ([code isEqualToString:@"00"]) {
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
            NSDictionary *val = [rootDic objectForKey:@"val"];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:val forKey:ITEM_JSON];
            UIStoryboard* st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *controller = [st instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
            self.view.window.rootViewController = controller;
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_TYPE object:self];
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:USER_NAME];
            [[NSUserDefaults standardUserDefaults] setObject:pass forKey:USER_PASS];
        } else {
            alert.message = msg;
            [alert show];
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        }
        
    }];
    [request setFailedBlock:^{
        //请求失败
        NSLog(@"请求失败");
        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        alert.message = @"网络异常";
        [alert show];
        

    }];
    [request setStartedBlock:^{
        //请求开始
        NSLog(@"请求开始");
        [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:@"加载中.."];

    }];
    [request startAsynchronous];
    } else {
        alert.message = @"用户名密码不能为空";
        [alert show];
    }
    //匹配账户信息
//    NSString *pass = _login_password.text;
//    NSString *user = _login_username.text;
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    if (user != nil && user.length != 0 ) {

//
//    }
    
}

@end
