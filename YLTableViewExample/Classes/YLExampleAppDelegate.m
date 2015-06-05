//
//  AppDelegate.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleAppDelegate.h"
#import "YLExampleViewController.h"

@implementation YLExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[YLExampleViewController alloc] init]]];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
