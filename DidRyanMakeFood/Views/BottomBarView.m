//
//  BottomBarView.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/5/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "BottomBarView.h"

@implementation BottomBarView

- (id)initWithCoder: (NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if(self)
        [self setup];
    return self;
}

- (id)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if(self)
        [self setup];
    return self;
}

- (void)setup
{
    UIImage *backgroundImage = [[UIImage imageNamed: @"bg_bottom_bar.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(2, 0, 0, 0)];
    UIImageView *background = [[UIImageView alloc] initWithImage: backgroundImage];
    background.frame = self.bounds;
    background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview: background];
}

@end
