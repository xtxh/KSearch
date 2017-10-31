//
//  KTableViewController.h
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KViewController.h"
#import "KTableViewCell.h"
#import "KTableView.h"

@interface KTableViewController : KViewController<UITableViewDelegate,UITableViewDataSource>

/**/
@property(nonatomic,weak) UITableView* tableView;
/**/
@property(nonatomic,weak) KTableView* groupView;

@end
