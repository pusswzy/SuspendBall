//
//  AppDelegate.m
//  SuspendBall
//
//  Created by 李昊泽 on 17/1/3.
//  Copyright © 2017年 李昊泽. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNavigationController.h"
#import "SuspendBall.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MainNavigationController alloc] initWithRootViewController:[NSClassFromString(@"RootViewController") new]];
    [self.window makeKeyAndVisible];
    
//    SuspendBall *suspendBall = [SuspendBall suspendBallWithFrame:CGRectMake(0, 64, 50, 50) delegate:nil subBallImageArray:@[@"suspend-back", @"suspend-share", @"full_screen_exit", @"up", @"down"]];
//    [[UIApplication sharedApplication].keyWindow addSubview:suspendBall];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
