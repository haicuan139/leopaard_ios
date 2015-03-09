//
//  LEDelegate.m
//  leopaard
//
//  Created by haicuan139 on 15-3-2.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "LEDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@implementation LEDelegate
-(NSMutableArray *)getItemDicWithTabType:(NSInteger)type{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [ud objectForKey:ITEM_JSON];
    NSArray *itemArray = [dic objectForKey:@"authList"];
    NSMutableArray *retArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < itemArray.count; i++) {
        NSDictionary *d = [itemArray objectAtIndex:i];
        NSInteger tabType = [[d objectForKey:@"tabType"] integerValue];
        if (tabType == type) {
            [retArray addObject:d];
        }
    }
    return retArray;
}
-(void)saveServerItemJson{
    NSError         *error      = nil;
            NSURL *url = [ NSURL URLWithString :@"http://114.215.196.175/itemjson.json"];
    NSString *responseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    SBJsonParser    *parser     = [[SBJsonParser alloc] init];
    NSDictionary    *rootDic    = [parser objectWithString:responseString error:&error];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:rootDic forKey:ITEM_JSON];

}
@end
