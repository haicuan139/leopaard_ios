//
//  LEDelegate.h
//  leopaard
//
//  Created by haicuan139 on 15-3-2.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
@interface LEDelegate : NSObject
-(NSMutableArray *)getItemDicWithTabType:(NSInteger)type;
-(void)saveServerItemJson;
@end
