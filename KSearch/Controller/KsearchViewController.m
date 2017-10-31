//
//  KsearchViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KsearchViewController.h"
#import "UISearchBar+KP.h"
#import "NSMutableAttributedString+KP.h"

@interface KsearchViewController ()<UISearchBarDelegate>
/**/
@property(nonatomic,strong)NSMutableArray* items;
/**/
@property(nonatomic,strong)NSMutableArray* applets;

/**/
@property(nonatomic,strong)NSMutableArray* data;

@end

@implementation KsearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNoDataView) name:@"KShowNoDataViewNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNoDataView) name:@"KHiddenNoDataViewNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditStyle) name:@"KEndEditNotification" object:nil];
}

-(void)showNoDataView{
    
    self.nodataView.hidden = NO;
//    UITextField* textfield = [self.searchBar valueForKey:@"searchField"];
//    UIImageView* leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    leftView.image = [[UIImage imageNamed:@"search"] imageByResizeToSize:CGSizeMake(20, 20)];
//    textfield.leftView = leftView;
//    textfield.leftViewMode = UITextFieldViewModeAlways;
//
//    UIButton* voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [voiceBtn setImage:[[UIImage imageNamed:@"voice"] imageByResizeToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
//    [voiceBtn addTarget:self action:@selector(voiceInputAction) forControlEvents:UIControlEventTouchUpInside];
//    voiceBtn.frame = CGRectMake(0, 0, 20, 20);
//    textfield.rightView = voiceBtn;
//    textfield.rightViewMode = UITextFieldViewModeAlways;
    
}

-(void)endEditStyle{
    [self.searchBar resignFirstResponder];
}

-(void)hiddenNoDataView{
    self.nodataView.hidden = YES;
}

-(void)clearSearchText{
    self.searchBar.text = @"";
}

-(void)voiceInputAction{
    NSLog(@"语音输入");
    [self.searchBar resignFirstResponder];
}

-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    if (self == [super initWithSearchResultsController:searchResultsController]) {
        [self.searchBar resignFirstResponder];
        [self showNoDataView];
    }
    return self;
}




-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(KNoDataView *)nodataView
{
    if (!_nodataView) {
        _nodataView = [[KNoDataView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
        @weakify(self);
        _nodataView.clickBlock = ^(KSearchItem *item) {
            [weak_self handleItem:item];
        };
        [self.view addSubview:_nodataView];
    }
    return _nodataView;
}

-(void)handleItem:(KSearchItem*)item{
    
    [self.searchBar setImage:[UIImage imageNamed:@"voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
//    UITextField* textfield = [self.searchBar valueForKey:@"searchField"];
//    UIImageView* leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    leftView.image = [[UIImage imageNamed:@"voice"] imageByResizeToSize:CGSizeMake(20, 20)];
//    textfield.leftView = leftView;
//    textfield.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
