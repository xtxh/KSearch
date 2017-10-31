//
//  KContactsViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KContactsViewController.h"
#import "KsearchViewController.h"
#import "KSearchResultViewController.h"
#import "UISearchBar+KP.h"
#import "NSString+KP.h"
#import "NSMutableAttributedString+KP.h"
#import <YYKit.h>
#import "KNavigationController.h"

@interface KContactsViewController ()<UISearchControllerDelegate,UISearchBarDelegate>

/**/
@property(nonatomic,strong)KsearchViewController* searchController;
/**/
@property(nonatomic,strong)KSearchResultViewController* resultVc;
/**/
@property(nonatomic,strong)NSMutableArray* contacts;

@end

@implementation KContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    for (NSInteger i = 0; i < 50; i++) {
        [self.data addObject:[NSString stringWithFormat:@"联系人%ld",i+1]];
    }
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 键盘处理
-(void)showKeyboard:(NSNotification*)notify{
    NSDictionary * info = [notify userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [self.resultVc setTableInserts:UIEdgeInsetsMake(0, 0, kbSize.height, 0)];
}

-(void)hiddenKeyboard:(NSNotification*)notify{
    [self.resultVc setTableInserts:UIEdgeInsetsZero];
}

-(KSearchResultViewController *)resultVc
{
    if (!_resultVc) {
        _resultVc = [[KSearchResultViewController alloc] initWithData:self.data];
    }
    return _resultVc;
}

-(KsearchViewController *)searchController
{
    if (!_searchController) {
        //初始化及代理设置
        _searchController = [[KsearchViewController alloc] initWithSearchResultsController:[[KNavigationController alloc]initWithRootViewController:self.resultVc]];
        UISearchBar* searchBar = _searchController.searchBar;
        _searchController.delegate = self;
        //搜索结果更新代理
        _searchController.searchResultsUpdater = self.resultVc;
        searchBar.delegate = self;
        //重要：当界面包裹在UITabBarController及UINavigationController时，弹出搜索界面时需要设置上下文，否则会显示异常
        self.definesPresentationContext = YES;
        //弹出时的背景设置
        _searchController.hidesNavigationBarDuringPresentation = YES;
        //取消文字
        [searchBar setCancelText:@"取消"];
        //tintColor、语音按钮、偏移量
        [searchBar setBarTintColor:UIColorHex(F6F7F6)];
        
        searchBar.showsBookmarkButton = YES;
        [searchBar setImage:[UIImage imageNamed:@"voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        //CGRect rect = _searchController.searchBar.frame;
        //[searchBar setPositionAdjustment:UIOffsetMake(rect.size.width/2-44, 0) forSearchBarIcon:UISearchBarIconSearch];
        
        searchBar.placeholder = @"搜索联系人";
        [searchBar setPlaceholderAlignmentCenter];
        //去掉编辑状态的黑线
        UIImageView* backView = [[_searchController.searchBar subviews] firstObject];
        backView.layer.borderColor = UIColorHex(F6F7F6).CGColor;
        backView.layer.borderWidth = 1.0;
        //去掉非编辑状态的黑线
        [searchBar setBackgroundImage:[UIImage imageWithColor:UIColorHex(F6F7F6)]];
        
        [searchBar setCancelButtonTitleAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
        
        
    }
    return _searchController;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[KTableViewCell className]];
    if (!cell) {
        cell = [[KTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[KTableViewCell className]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"联系人%ld",indexPath.row+1];
    cell.imageView.image = [[[UIImage imageNamed:@"launch"] imageByResizeToSize:CGSizeMake(34, 34)] imageByRoundCornerRadius:100.0];
    return cell;
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
        CGRect rect = searchBar.frame;
        [UIView animateWithDuration:0.5 animations:^{
//            [searchBar setPositionAdjustment:UIOffsetMake(rect.size.width/2-44, 0) forSearchBarIcon:UISearchBarIconSearch];
            [searchBar setPlaceholderAlignmentCenter];
        } completion:nil];
    }
}
/*searchBar开始编辑*/
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}
/*取消按钮点击*/
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}
/*bookmark按钮点击*/
-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"语音");
}
/*searchBar文本监听*/
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

#pragma mark - UISearchController
/*searchController将要弹出*/
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat width = [searchController.searchBar.placeholder?:@"" widthWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToHeight:44];
        [searchController.searchBar setPositionAdjustment:UIOffsetMake((kScreenWidth-(width+44+64))/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        //[searchController.searchBar setPlaceholderAlignmentCenter];
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
/*searchController简要消失*/
- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
    
    [UIView animateWithDuration:0.5 animations:^{
        [searchController.searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    } completion:nil];
}
/*searchController已经消失*/
- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}


@end
