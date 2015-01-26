//
//  AppDelegate.m
//  Rotten_Tomatoes
//
//  Created by Nadav Golbandi on 1/23/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"
#import "TabController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MoviesViewController* mvc = [[MoviesViewController alloc] init];
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    self.window.rootViewController = nvc;

    
//    //create an array of all view controllers that will represent the tab at the bottom
//    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:
//                                  nvc, nil];
//    
//    //initialize the tab bar controller
//    TabController* tabController = [[TabController alloc] init];
//    
//    //set the view controllers for the tab bar controller
//    [tabController setViewControllers:myViewControllers];
//    
//    //add the tab bar controllers view to the window
//    [self.window addSubview:tabController.view];
//
////    self.window.rootViewController = nvc;

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
