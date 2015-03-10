//
//  ItemCellCollectionViewCell.m
//  leopaard
//
//  Created by haicuan139 on 15-3-2.
//  Copyright (c) 2015年 haicuan139. All rights reserved.
//

#import "ItemCellCollectionViewCell.h"

@implementation ItemCellCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ItemCellCollectionViewCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
@end
