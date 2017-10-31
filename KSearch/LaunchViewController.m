//
//  LaunchViewController.m
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

/**/
@property(nonatomic,strong)UIImageView* launchImageView;

@end

@implementation LaunchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(dismissLaunchView) withObject:nil afterDelay:1.5];
}

-(void)dismissLaunchView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissLaunchView) object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    UILabel* launchLabel = [[UILabel alloc] init];
    launchLabel.text = @"启动页";
    launchLabel.textColor = [UIColor greenColor];
    launchLabel.font = [UIFont systemFontOfSize:32];
    launchLabel.textAlignment = NSTextAlignmentCenter;
    launchLabel.center = self.view.center;
    launchLabel.frame = self.view.bounds;
    [self.view addSubview:launchLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIImageView *)launchImageView
{
    if (!_launchImageView) {
        _launchImageView = [[UIImageView alloc] init];
        [_launchImageView setFrame:[UIScreen mainScreen].bounds];
        _launchImageView.image = [UIImage imageNamed:@"launch"];
        _launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _launchImageView;
}

-(void)showOnWindow:(UIWindow *)window
{
    [self.view addSubview:self.launchImageView];
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
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
