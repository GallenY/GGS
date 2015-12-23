//
//  AppDelegate.m
//  GGS
//
//  Created by 高阳 on 15/11/5.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "AppDelegate.h"
#import "GGSMenuViewController.h"
#import "GGSMovieViewController.h"
#import "GGSAirViewController.h"
#import "GGSPersonViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    //菜谱大全
    UIStoryboard *menuStoryboard = [UIStoryboard storyboardWithName:@"GGSMenuViewController" bundle:nil];
    GGSMovieViewController *menuViewController = [menuStoryboard instantiateInitialViewController];
    UINavigationController *menuNavigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    menuViewController.navigationItem.title = @"菜谱大全";
    menuNavigationController.tabBarItem.title = @"菜谱大全";
    menuNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_home"];
    //电影票房
    GGSMovieViewController *movieViewController = [[GGSMovieViewController alloc] init];
    UINavigationController *movieNavigationController = [[UINavigationController alloc] initWithRootViewController:movieViewController];
    //空气质量
    UIStoryboard *airStoryboard = [UIStoryboard storyboardWithName:@"GGSAirViewController" bundle:nil];
    GGSAirViewController *airViewController = [airStoryboard instantiateInitialViewController];
    UINavigationController *airNavigationController = [[UINavigationController alloc] initWithRootViewController:airViewController];
    airViewController.navigationItem.title = @"空气质量";
    airNavigationController.tabBarItem.title = @"空气质量";
    airNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_air"];
    //个人
    UIStoryboard *personStoryboard = [UIStoryboard storyboardWithName:@"GGSPersonViewController" bundle:nil];
    GGSPersonViewController *personViewController = [personStoryboard instantiateInitialViewController];
    UINavigationController *personNavigationController = [[UINavigationController alloc] initWithRootViewController:personViewController];
    personViewController.navigationItem.title = @"个人";
    personNavigationController.tabBarItem.title = @"个人";
    personNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_person"];
    
    tabBarController.viewControllers = @[menuNavigationController,movieNavigationController,airNavigationController,personNavigationController];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
