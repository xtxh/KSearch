//
//  KSearchBar.m
//  KSearch
//
//  Created by 柯平 on 2017/10/31.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KSearchBar.h"

@implementation KSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
    }
    return self;
}

@end
