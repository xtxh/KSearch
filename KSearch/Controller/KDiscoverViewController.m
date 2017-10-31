//
//  KDiscoverViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KDiscoverViewController.h"
#import "KSearchBar.h"
#import "UISearchBar+KP.h"

@interface KDiscoverViewController ()<UISearchBarDelegate>

/**/
@property(nonatomic,strong)KSearchBar* searchBar;

@end

@implementation KDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i = 0; i < 100; i ++) {
        [self.data addObject:@(i)];
    }
    
    self.tableView.tableHeaderView = self.searchBar;
    
    
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
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[KTableViewCell className]];
    
    if (!cell) {
        cell = [[KTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[KTableViewCell className]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"发现%ld",indexPath.row+1];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(KSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[KSearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.tintColor = UIColorHex(F6F7F6);
        _searchBar.showsBookmarkButton = YES;
        [_searchBar setImage:[UIImage imageNamed:@"voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        _searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 5);
        [_searchBar setCancelText:@"取消"];
    }
    return _searchBar;
    return _searchBar;
}

@end
