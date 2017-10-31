//
//  KNoDataView.m
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KNoDataView.h"
#import <YYKit.h>

@implementation KNoDataView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kScreenHeight;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColorHex(F9FAF8);
    
    CGFloat top = 84;
    _itemLabel = [UILabel new];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.text = @"搜索指定内容";
    _itemLabel.textColor = UIColorHex(B6B7B6);
    [_itemLabel setFrame:CGRectMake(0, top, self.width, 44)];
    _itemLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_itemLabel];
    top += _itemLabel.height;
    
    NSMutableArray* buttons = [NSMutableArray array];
    CGSize btnSize = CGSizeMake(kScreenWidth/3 - 62/3, 44);
    CGSize lineSize = CGSizeMake(1, 24);
    top += 10;
    NSArray* titles = @[@"朋友圈",@"资讯",@"公众号",@"小说",@"音乐",@"表情"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorHex(53AE19) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        btn.size = btnSize;
        [btn addTarget:self action:@selector(buttonItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* line = [UIView new];
        line.backgroundColor = UIColorHex(EBECEB);
        line.size = lineSize;
        
        btn.left = 30+(btn.width+1)*(i%3);
        btn.top = top+(btn.height+10)*(i/3);
        if (i%3 == 2) line.hidden = YES;
        [line setFrame:CGRectMake(btn.width-1, 10, 1, 24)];
        [btn addSubview:line];
        [self addSubview:btn];
        [buttons addObject:btn];
    }
    self.itemViews = buttons;
    top += (btnSize.height+10) * 2;
    
    top += 20;
    _appletLabel = [UILabel new];
    _appletLabel.text = @"小程序";
    _appletLabel.textAlignment = NSTextAlignmentCenter;
    _appletLabel.textColor = UIColorHex(B6B7B6);
    [_appletLabel setFrame:CGRectMake(0, top, self.width, 44)];
    _appletLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_appletLabel];
    
    top += 30;
    top += _appletLabel.height;
    NSMutableArray* apps = [NSMutableArray array];
    NSArray* images = @[@"launch",@"launch",@"launch",@"launch",@"launch"];
    CGSize size = CGSizeMake(CGFloatPixelRound(44), CGFloatPixelRound(44));
    for (NSInteger i = 0; i < images.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size = size;

        [btn setImage:[[[UIImage imageWithColor:UIColorHex(EE5C49)] imageByResizeToSize:size contentMode:UIViewContentModeScaleAspectFill] imageByRoundCornerRadius:100.0] forState:UIControlStateNormal];
        
        btn.left = (kScreenWidth-(size.width+10)*5)/2.0+(size.width+10)*i;
        btn.top = top;
        [btn addTarget:self action:@selector(buttonAppletClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [apps addObject:btn];
    }
    self.applets = apps;
    
    return self;
}

-(void)buttonItemClick:(UIButton*)sender
{
    NSString* title = sender.titleLabel.text;
    KSearchItemType type;
    if ([@"朋友圈" isEqualToString:title]) {
        type = KSearchItemCycle;
    }else if ([@"资讯" isEqualToString:title]){
        type = KSearchItemNews;
    }else if ([@"公众号" isEqualToString:title]){
        type = KSearchItemSubscribe;
    }else if ([@"小说" isEqualToString:title]){
        type = KSearchItemStory;
    }else if ([@"音乐" isEqualToString:title]){
        type = KSearchItemMusic;
    }else if ([@"表情" isEqualToString:title]){
        type = KSearchItemEmoji;
    }else{
        type = KSearchItemApplet;
    }
    
    KSearchItem* item = [KSearchItem new];
    item.itemTitle = title;
    item.type = type;
    if (self.clickBlock) {
        self.clickBlock(item);
    }
    
}

-(void)buttonAppletClick:(UIButton*)sender
{
    NSString* title = sender.titleLabel.text;
    KSearchItem* item = [KSearchItem new];
    item.itemTitle = title;
    item.type = KSearchItemApplet;
    if (self.clickBlock) {
        self.clickBlock(item);
    }
}

@end
