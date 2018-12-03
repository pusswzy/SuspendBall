//
//  RootViewController.m
//  SuspendBall
//
//  Created by 李昊泽 on 17/1/9.
//  Copyright © 2017年 李昊泽. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.7];
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(100, 300, 175, 44);
    [nextBtn setTitle:@"下一个控制器" forState:0];
    nextBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextVC
{
    ViewController *VC = [ViewController new];
    [self.navigationController pushViewController:VC animated:YES];
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
