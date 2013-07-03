//
//  Tweet.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "Tweet.h"

@implementation Tweet

//Creates the mapping for RESTKit
+ (void)setupObjectMapping
{
    RKObjectMapping *tweetMapping = [RKObjectMapping mappingForClass: [self class]];
    [tweetMapping mapKeyPath: @"created_at" toAttribute: @"createdAt"];
    [tweetMapping mapKeyPath: @"text" toAttribute: @"text"];
    [[[RKObjectManager sharedManager] mappingProvider] setObjectMapping: tweetMapping forResourcePathPattern: @"/statuses/user_timeline.json"];
}
@end
