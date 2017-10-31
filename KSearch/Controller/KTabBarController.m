//
//  KTabBarController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KTabBarController.h"
#import "KContactsViewController.h"
#import "KMessageViewController.h"
#import "KDiscoverViewController.h"
#import "KMineViewController.h"
#import "KNavigationController.h"


/**/
static NSString* const kClassKey = @"kClassKey";
/**/
static NSString* const kTitleKey = @"kTitleKey";
/**/
static NSString* const kImgKey = @"kImgKey";
/**/
static NSString* const kSelImgKey = @"kSelImgKey";

@interface KTabBarController ()

@end


@implementation KTabBarController

+(void)initialize{
    
    //设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    
    //设置背景颜色
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]];
    
    //拿到整个导航控制器的外观
    UITabBarItem* item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    //Normal状态
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[UIFont systemFontSize]],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    //选中状态
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[UIFont systemFontSize]],NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[KMessageViewController new] imageName:@"tabbar_mainframe" title:@"微信"];
    [self addChildViewController:[KContactsViewController new] imageName:@"tabbar_contacts" title:@"通讯录"];
    [self addChildViewController:[KDiscoverViewController new] imageName:@"tabbar_discover" title:@"发现"];
    [self addChildViewController:[KMineViewController new] imageName:@"tabbar_me" title:@"我"];
}

-(void)addChildViewController:(UIViewController *)childController imageName:(NSString*)imageName title:(NSString*)title{
    KNavigationController* navi = [[KNavigationController alloc]initWithRootViewController:childController];
    navi.tabBarItem.title = title;
    childController.navigationItem.title = title;
    navi.tabBarItem.image = [UIImage imageNamed:imageName];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@HL",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:navi];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
