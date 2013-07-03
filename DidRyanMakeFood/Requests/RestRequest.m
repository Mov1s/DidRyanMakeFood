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
    id returnObject = [self mapResponseWithObjects: objects];
    [self.sender performSelector: self.callbackSelector withObject: returnObject];
}

//RESTKit request response handler
- (void)request: (RKRequest*)request didLoadResponse: (RKResponse*)response
{
    id returnObject;
    
    //Get object for various response types
    if([response isOK])
        returnObject = [self successResponse];
    else if([response isConflict])
        returnObject = [self conflictResponse];
    else if([response isUnauthorized])
        returnObject = [self unauthorizedResponse];
    
    [self.sender performSelector: self.callbackSelector withObject: returnObject];
}

//RESTKit object loader failure handler
- (void)objectLoader: (RKObjectLoader *)objectLoader didFailWithError: (NSError *)error
{
    id returnObject;
    
    //Get object for various response types
    if(error.code == 2)
        returnObject = [self offlineResponse];
    if(error.code == -1001)
        returnObject = [self timeoutResponse];
    else
        returnObject = [self failureResponse];
    
    [self.sender performSelector: self.callbackSelector withObject: returnObject];
}

#pragma mark - Executors
- (void)execute
{
    NSLog(@"%@ executed online.", [self class]);
}

#pragma mark - Request Response Types
- (id)mapResponseWithObjects: (NSArray *)objects
{
    NSLog(@"%@ was mapped.", [self class]);
    return objects;
}

- (id)successResponse
{
    NSLog(@"%@ returned successfully.", [self class]);
    return nil;
}

- (id)failureResponse
{
    NSLog(@"%@ returned with a failure.", [self class]);
    return nil;
}

- (id)offlineResponse
{
    NSLog(@"%@ is offline.", [self class]);
    return nil;
}

- (id)timeoutResponse
{
    NSLog(@"%@ timed out.", [self class]);
    return nil;
}

- (id)conflictResponse
{
    NSLog(@"%@ had a conflict.", [self class]);
    return nil;
}

- (id)unauthorizedResponse
{
    NSLog(@"%@ is unauthorized.", [self class]);
    return nil;
}
@end
