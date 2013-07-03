//
//  MainAppDelegate.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "MainAppDelegate.h"
#import "Tweet.h"

@implementation MainAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Setup RESTKit
    [self setupTwitterObjectManager];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Setting up the object managers to use with various APIs
//Creates the object manager for the twitter API, it will be used as the default manager since it gets called first in the application launcher
- (void)setupTwitterObjectManager
{
    //Setup Restkit
    RKObjectManager *twitterApi = [RKObjectManager managerWithBaseURLString: @"https://api.twitter.com/1.1"];
    twitterApi.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    twitterApi.acceptMIMEType = RKMIMETypeJSON;
    twitterApi.serializationMIMEType=RKMIMETypeJSON;
    
    //Disable RESTKit logging because my own logging is more specific 99% of the time
    RKLogConfigureByName("*", RKLogLevelOff);
    
    //Setup object mappings
    [Tweet setupObjectMapping];
}

@end
