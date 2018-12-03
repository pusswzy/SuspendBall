//
//  ViewController.m
//  SuspendBall
//
//  Created by 李昊泽 on 17/1/3.
//  Copyright © 2017年 李昊泽. All rights reserved.
//

#import "ViewController.h"
#import "SuspendBall.h"
@interface ViewController ()<SuspendBallDelegte>
/** URL数组  */
@property (nonatomic, strong) NSMutableArray *urlArray;
/** webView  */
@property (nonatomic, strong) UIWebView *webView;
/** 悬浮球  */
@property (nonatomic, strong) SuspendBall *suspendBall;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"悬浮球demo";
    
    CGFloat btnWH = 50.f;
    SuspendBall *suspendBall = [SuspendBall suspendBallWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - btnWH, 100, btnWH, btnWH) delegate:self subBallImageArray:@[@"suspend-back", @"suspend-share", @"full_screen_exit", @"up", @"down"]];
    self.suspendBall = suspendBall;
    [self.view addSubview:suspendBall];
    
    [self setupWebView];
}

- (void)dealloc
{
    self.suspendBall.delegate = nil;
    self.suspendBall = nil;
    NSLog(@"%s", __func__);
}

- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    [self.view insertSubview:webView belowSubview:self.suspendBall];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlArray.firstObject]];
    [webView loadRequest:request];
}

#pragma mark - SuspendBallDelegte
- (void)suspendBall:(UIButton *)subBall didSelectTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 3:
            [self.webView goBack];
            break;
            
        case 4:
            [self.webView goForward];
            
        default:
            break;
    }
}

#pragma mark - Lazy
- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray arrayWithCapacity:10];
        [_urlArray addObjectsFromArray:@[@"https://www.zhihu.com/topic/19555404/hot"]];
    }
    return _urlArray;
}


@end
