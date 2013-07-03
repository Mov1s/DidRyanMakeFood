//
//  RestRequest.m
//  MovServer Manager
//
//  Created by Ryan Popa on 9/3/12.
//  Copyright (c) 2012 RECSOLU. All rights reserved.
//
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "RestRequest.h"

@implementation RestRequest
@synthesize callbackSelector;
@synthesize sender;

#pragma mark - Init Methods
//Initializes the request with a callback to call when the request returns
- (id)initWithCallback: (SEL)aSelector sender: (id)theSender
{
    self = [super init];
    if(self)
    {
        self.callbackSelector = aSelector;
        self.sender = theSender;
    }
    return self;
}

#pragma mark - RESTKit object loaderes
//RESTKit object loader
- (void)objectLoader: (RKObjectLoader *)objectLoader didLoadObjects: (NSArray *)objects
{
    [self mapResponseWithObjects: objects];
}

//RESTKit request response handler
- (void)request: (RKRequest*)request didLoadResponse: (RKResponse*)response
{    
    //Get object for various response types
    if([response isOK])
        [self successResponse];
    else if([response isConflict])
        [self conflictResponse];
    else if([response isUnauthorized])
        [self unauthorizedResponse];
}

//RESTKit object loader failure handler
- (void)objectLoader: (RKObjectLoader *)objectLoader didFailWithError: (NSError *)error
{    
    //Get object for various response types
    if(error.code == 2)
        [self offlineResponse];
    if(error.code == -1001)
        [self timeoutResponse];
    else
        [self failureResponse];
}

#pragma mark - Executors
- (void)execute
{
    NSLog(@"%@ executed online.", [self class]);
}

#pragma mark - Request Response Types
- (void)mapResponseWithObjects: (NSArray *)objects
{
    NSLog(@"%@ was mapped.", [self class]);
    [self.sender performSelector: self.callbackSelector withObject: objects];
}

- (void)successResponse
{
    NSLog(@"%@ returned successfully.", [self class]);
}

- (void)failureResponse
{
    NSLog(@"%@ returned with a failure.", [self class]);
    
    //Create error
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject: @"Request Failed" forKey: NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain: @"request" code: 500 userInfo: userInfo];
    
    //Perform callback selector with error
    [self.sender performSelector: self.callbackSelector withObject: error];
}

- (void)offlineResponse
{
    NSLog(@"%@ is offline.", [self class]);
    
    //Create error
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject: @"No Network Connection" forKey: NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain: @"request" code: 600 userInfo: userInfo];
    
    //Perform callback selector with error
    [self.sender performSelector: self.callbackSelector withObject: error];
}

- (void)timeoutResponse
{
    NSLog(@"%@ timed out.", [self class]);
    
    //Create error
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject: @"Network Timeout" forKey: NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain: @"request" code: 601 userInfo: userInfo];
    
    //Perform callback selector with error
    [self.sender performSelector: self.callbackSelector withObject: error];
}

- (void)conflictResponse
{
    NSLog(@"%@ had a conflict.", [self class]);
}

- (void)unauthorizedResponse
{
    NSLog(@"%@ is unauthorized.", [self class]);
}
@end
