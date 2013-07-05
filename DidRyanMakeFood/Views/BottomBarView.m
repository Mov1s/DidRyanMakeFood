//
//  BottomBarView.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/5/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "BottomBarView.h"

@interface BottomBarView()
@property (nonatomic, strong) UIImageView *background;
@end

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
    self.background = [[UIImageView alloc] initWithImage: backgroundImage];
    self.background.frame = self.bounds;
    self.background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview: self.background];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self sendSubviewToBack: self.background];
}

@end
