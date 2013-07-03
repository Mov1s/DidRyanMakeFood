//
//  Tweet.h
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *text;

+ (void)setupObjectMapping;
@end
