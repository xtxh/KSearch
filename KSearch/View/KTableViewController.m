//
//  KTableViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KTableViewController.h"
#import "KTableView.h"
#import "KTableViewCell.h"

@interface KTableViewController ()

@end

@implementation KTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
        tableView.rowHeight = 44;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

-(KTableView *)groupView
{
    if (!_groupView) {
        KTableView* groupView = [[KTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        groupView.dataSource = self;
        groupView.delegate = self;
        groupView.sectionFooterHeight = 0.0;
        groupView.sectionHeaderHeight = 0.0;
        groupView.rowHeight = 44;
        [self.view addSubview:groupView];
        _groupView = groupView;
    }
    return _groupView;
}



@end
