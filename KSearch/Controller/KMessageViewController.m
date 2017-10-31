//
//  KMessageViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KMessageViewController.h"
#import "KsearchViewController.h"
#import "UISearchBar+KP.h"
#import "NSString+KP.h"


@interface KMessageViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
/**/
@property(nonatomic,strong)UISearchController* searchViewController;
/**/
@property(nonatomic,strong)NSMutableArray* searchList;

@end

@implementation KMessageViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.searchList = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        [self.data addObject:[NSString stringWithFormat:@"消息%ld",i+1]];
    }
    [self.searchViewController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 键盘处理
-(void)showKeyboard:(NSNotification*)notify{
    NSDictionary * info = [notify userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, kbSize.height, 0)];
    
}
-(void)hiddenKeyboard:(NSNotification*)notify{
    [self.tableView setContentInset:UIEdgeInsetsZero];
}

#pragma mark - LazyLoad
-(UISearchController *)searchViewController
{
    if (!_searchViewController) {
        //初始化及代理设置
        _searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchViewController.delegate = self;
        _searchViewController.searchResultsUpdater = self;
        _searchViewController.searchBar.delegate = self;
        //编辑状态背景设置
        _searchViewController.dimsBackgroundDuringPresentation = NO;
        //弹出搜索界面上下文设置
        self.definesPresentationContext = YES;
        //取消按钮文字&颜色
        [_searchViewController.searchBar setCancelText:@"取消"];
        //tintColor
        [_searchViewController.searchBar setBarTintColor:UIColorHex(F6F7F6)];
        //通过设置背景图去掉底部分割线
        [_searchViewController.searchBar setBackgroundImage:[UIImage imageWithColor:UIColorHex(F6F7F6)]];
        //显示bookmark按钮
        _searchViewController.searchBar.showsBookmarkButton = YES;
        //设置语音按钮图标
        [_searchViewController.searchBar setImage:[UIImage imageNamed:@"voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        //去掉编辑状态底部分割线
        UIImageView* backView = [[_searchViewController.searchBar subviews] firstObject];
        backView.layer.borderColor = UIColorHex(F6F7F6).CGColor;
        backView.layer.borderWidth = 1.0;
        [_searchViewController.searchBar setBackgroundImage:[UIImage imageWithColor:UIColorHex(F6F7F6)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        //自适应大小
        [self.searchViewController.searchBar sizeToFit];
        //CGRect rect = _searchViewController.searchBar.frame;
        //设置搜索图标偏移量
        //[_searchViewController.searchBar setPositionAdjustment:UIOffsetMake(rect.size.width/2-44, 0) forSearchBarIcon:UISearchBarIconSearch];
        [_searchViewController.searchBar setPlaceholderAlignmentCenter];
        //占位文字
        _searchViewController.searchBar.placeholder = @"搜索";
        _searchViewController.searchBar.contentScaleFactor = 0.0;
        [_searchViewController.searchBar setCancelButtonTitleAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
    }
    return _searchViewController;
}

#pragma mark - Memory
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchViewController.active && [self.searchViewController.searchBar.text isNotBlank]) {
        return self.searchList.count;
    }
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[KTableViewCell className]];
    
    if (!cell) {
        cell = [[KTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[KTableViewCell className]];
    }
    cell.imageView.image = [[[UIImage imageNamed:@"launch"] imageByResizeToSize:CGSizeMake(34, 34)] imageByRoundCornerRadius:100.0];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    if (self.searchViewController.active  && [self.searchViewController.searchBar.text isNotBlank]) {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
        cell.textLabel.text = self.data[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UISearchUpdateResults
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.searchList removeAllObjects];
    NSString* text = searchController.searchBar.text;
    if ([text isNotBlank]) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",text];
        NSArray* results = [NSMutableArray arrayWithArray:[self.data filteredArrayUsingPredicate:predicate]];
        if (results.count > 0) {
            [self.searchList addObjectsFromArray:results];
        }
        
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchDelegate

/*searchBar结束编辑*/
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text isNotBlank]) {
        [UIView animateWithDuration:0.5 animations:^{
            [searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
        } completion:nil];
    }else{
        //CGRect rect = searchBar.frame;
        [UIView animateWithDuration:0.5 animations:^{
            [searchBar setPlaceholderAlignmentCenter];
            //[searchBar setPositionAdjustment:UIOffsetMake(rect.size.width/2-44, 0) forSearchBarIcon:UISearchBarIconSearch];
        } completion:nil];
    }
}

/*searchBar开始编辑*/
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

/*点击取消按钮*/
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}
/*点击bookMark按钮*/
-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"语音");
}
/*监听searBar文字变化*/
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

#pragma mark - UISearchController
/*searchController将要弹出*/
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat width = [searchController.searchBar.placeholder?:@"" widthWithFont:[UIFont systemFontOfSize:16] constrainedToHeight:44];
        [searchController.searchBar setPositionAdjustment:UIOffsetMake((kScreenWidth-(width+44+64))/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    } completion:^(BOOL finished) {
        
    }];
}
/*searchController已经弹出*/
- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    
    [UIView animateWithDuration:0.3 animations:^{
        [searchController.searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    } completion:nil];
    
}
/*searchController将要消失*/
- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
    [UIView animateWithDuration:0.5 animations:^{
        [searchController.searchBar setPlaceholderAlignmentCenter];
    } completion:nil];
}
/*searchController已经消失*/
- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

@end
