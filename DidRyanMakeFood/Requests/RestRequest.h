//
//  RestRequest.h
//  MovServer Manager
//
//  Created by Ryan Popa on 9/3/12.
//  Copyright (c) 2012 RECSOLU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface RestRequest : NSObject <RKObjectLoaderDelegate>
@property (nonatomic) SEL callbackSelector;
@property (nonatomic, strong) id sender;

- (void)execute;
- (id)initWithCallback: (SEL)aSelector sender: (id)theSender;
@end
