//
//  AppDelegate.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 12/29/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "ScheduledItemsTVC.h"
#import "AddData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    // Register for Local User Notifications
    UIUserNotificationSettings *mysettings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:mysettings];

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

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    // I recieved a notification
    
    // Let's find in our database the appropriate entry to show when notification fires
    
    
    // Programmatically create our Storyboard & ViewControllers
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *dvc = [sb instantiateViewControllerWithIdentifier:@"DetailViewController"];
    ScheduledItemsTVC *svc = [sb instantiateViewControllerWithIdentifier:@"ScheduledItemsTVC"];
//    dvc.setIndexPath = @"Passing a value"; //Optional
    
    // Programmatically create UINavicationController, add it as a root ViewController and add created VC's to it
    UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
    nav.viewControllers = [NSArray arrayWithObjects:svc,dvc, nil];
    
    //Show DetailViewController
    [(UINavigationController *)self.window.rootViewController popToViewController:dvc animated:TRUE];
    
}
@end
