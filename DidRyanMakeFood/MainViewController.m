//
//  MainViewController.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "MainViewController.h"
#import "RequestGetMyTweets.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Request my tweets
    RequestGetMyTweets *myTweetsRequest = [[RequestGetMyTweets alloc] initWithCallback: @selector(myTweetsCallback:) sender: self];
    [myTweetsRequest execute];
}

#pragma mark - Callbacks
//Callback for when my tweets return
- (void)myTweetsCallback: (id)object
{
    NSLog(@"My Tweets Have Returned!");
}
@end
