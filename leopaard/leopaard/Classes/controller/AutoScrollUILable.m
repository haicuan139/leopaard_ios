//
//  AutoScrollUILable.m
//  leopaard
//
//  Created by haicuan139 on 15-3-9.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "AutoScrollUILable.h"

@implementation AutoScrollUILable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    float w = self.frame.size.width;
//    if (motionWidth >= w) {
//        return;
//    }
//
    
    CGRect frame = self.frame;
    frame.origin.x = 320;
    self.frame = frame;
    
    [UIView beginAnimations:@"textAnimation" context:NULL];
    [UIView setAnimationDuration:5.0f*(w<320?320:w) /320.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];//是否能反转
    [UIView setAnimationRepeatCount:LONG_MAX];//重复次数
    
    frame = self.frame;
    frame.origin.x = -w;
    self.frame = frame;
    [UIView commitAnimations];
}
@end
