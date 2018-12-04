# SuspendBal



## Installation
> pod 'SuspendBall'


## Usage introduce
一行代码在项目中集成悬浮球功能:
* 全局使用悬浮球功能:
在Appdelegate.m里导入#import "SuspendBall.h", 并在
```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions```
函数中加如下代码,
```
SuspendBall *suspendBall = [SuspendBall suspendBallWithFrame:CGRectMake(0, 84, 50, 50) delegate:nil subBallImageArray:@[@"suspend-back", @"suspend-share", @"full_screen_exit", @"up", @"down"]];
    [[UIApplication sharedApplication].keyWindow addSubview:suspendBall];
```
即可在全部页面展示悬浮球

* 部分页面集成悬浮球功能:  
在对应页面添加
```
SuspendBall *suspendBall = [SuspendBall suspendBallWithFrame:CGRectMake(0, 84, 50, 50) delegate:self subBallImageArray:@[@"suspend-back", @"suspend-share", @"full_screen_exit", @"up", @"down"]];
    self.suspendBall = suspendBall;
    [self.view addSubview:suspendBall];
```

## Reference
http://www.jianshu.com/p/7b7a43736286
