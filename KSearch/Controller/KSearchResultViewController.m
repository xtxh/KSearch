//
//  KSearchResultViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KSearchResultViewController.h"
#import "KSearchItem.h"

@interface KSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>

/**/
@property(nonatomic,strong)NSMutableArray* contactsData;
/**/
@property(nonatomic,strong)NSMutableArray* groupsData;
/**/
@property(nonatomic,assign)UIEdgeInsets inserts;

@end

@implementation KSearchResultViewController

-(instancetype)initWithData:(NSArray *)data
{
    if (self == [super init]) {
        [self.data addObjectsFromArray:data];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setTableInserts:(UIEdgeInsets)insets
{
    self.inserts = insets;
}


#pragma mark - UITableViewDelegate/DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.results.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.results.count-1) {
        return 0.0;
    }else{
        return 54;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == self.results.count-1) {
        return nil;
    }else{
        UIView* view = [UIView new];
        UILabel* label = [UILabel new];
        [label setFrame:CGRectMake(10, 20, self.view.width-20, 24)];
        label.text = @"联系人";
        label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        label.textColor = [UIColor darkGrayColor];
        [view addSubview:label];
        return view;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    
    if (indexPath.section == self.results.count-1) {
        cell.textLabel.text = [NSString stringWithFormat:@"百度搜索 %@",self.results[indexPath.section][indexPath.row]];
    }else{
        cell.textLabel.text = self.results[indexPath.section][indexPath.row];
    }
    return cell;
}

#pragma mark - LazyLoad
-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(NSMutableArray *)results
{
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}

-(NSMutableArray *)contactsData
{
    if (!_contactsData) {
        _contactsData = [NSMutableArray array];
    }
    return _contactsData;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0.0;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.rowHeight = 44;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.results removeAllObjects];
    [self.tableView setContentInset:self.inserts];
    NSString* text = searchController.searchBar.text;
    if ([text isNotBlank]) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",text];
        NSArray* results = [self.data filteredArrayUsingPredicate:predicate];
        if (results.count > 0) {
            self.contactsData = [NSMutableArray arrayWithArray:results];
            [self.results addObject:self.contactsData];
            [self.results addObject:@[text]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KHiddenNoDataViewNotification" object:nil];
        }

    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KShowNoDataViewNotification" object:nil];
    }
    [self.tableView reloadData];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
