//
//  TopBarView.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView

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
    UIImage *backgroundImage = [[UIImage imageNamed: @"bg_top_bar.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(0, 0, 2, 0)];
    UIImageView *background = [[UIImageView alloc] initWithImage: backgroundImage];
    background.frame = self.bounds;
    background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview: background];
}

@end
