//
//  KNoDataView.h
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSearchItem.h"

@interface KNoDataView : UIView

/*点击回调*/
@property(nonatomic,copy)void(^clickBlock) (KSearchItem* item);

/**/
@property(nonatomic,strong)UILabel* itemLabel;
/**/
@property(nonatomic,strong)NSArray* itemViews;

/**/
@property(nonatomic,strong)UILabel* appletLabel;
/**/
@property(nonatomic,strong)NSArray* appletViews;

/*第三方服务*/
@property(nonatomic,strong)NSArray* items;
/*小程序*/
@property(nonatomic,strong)NSArray* applets;

@end
