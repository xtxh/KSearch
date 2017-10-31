//
//  KSearchResultViewController.h
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KsearchViewController;



@interface KSearchResultViewController : UIViewController<UISearchResultsUpdating>

-(instancetype)initWithData:(NSArray*)data;

/**/
@property(nonatomic,strong)UITableView* tableView;
/**/
@property(nonatomic,strong)NSMutableArray* data;
/**/
@property(nonatomic,strong)NSMutableArray* results;

-(void)setTableInserts:(UIEdgeInsets)insets;

@end
