//
//  RequestGetMyTweets.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "RequestGetMyTweets.h"

@implementation RequestGetMyTweets

- (void)execute
{
    [super execute];
    
    //Tweets URL
    NSString *url = @"/statuses/user_timeline.json";
    
    //Query Params
    url = [url stringByAppendingFormat: @"?screen_name=%@", @"DidRyanMakeFood"];
    
    //Make Request
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: url usingBlock: ^(RKObjectLoader *loader)
     {
         loader.userData = self;
         loader.delegate = self;
     }];
}
@end
