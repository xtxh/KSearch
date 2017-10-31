//
//  KNavigationController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/30.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "KNavigationController.h"

@interface KNavigationController ()

@end

@implementation KNavigationController

+(void)initialize{
    //设置不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    //设置导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageWithColor:UIColorHex(F6F7F6)]]];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi_bar_back"] forBarMetrics:UIBarMetricsCompact];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //导航栏返回按钮颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    //去掉返回安妮文字
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-80, -80) forBarMetrics:UIBarMetricsDefault];
    //设置导航栏文字颜色字体大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:UIColorHex(F6F7F6)]];
    UIBarButtonItem* item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
