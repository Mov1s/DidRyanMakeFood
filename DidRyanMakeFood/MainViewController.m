//
//  MainViewController.m
//  DidRyanMakeFood
//
//  Created by Ryan Popa on 7/3/13.
//  Copyright (c) 2013 Ryan Popa. All rights reserved.
//

#import "MainViewController.h"
#import "RequestGetMyTweets.h"
#import "Tweet.h"

@interface MainViewController ()
@property (nonatomic, strong) Tweet *currentTweet;
@property (nonatomic, strong) NSString *lastErrorMessage;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set background
    UIImage *background = [UIImage imageNamed: @"bg_main.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage: background];
    
    //Request my tweets
    RequestGetMyTweets *myTweetsRequest = [[RequestGetMyTweets alloc] initWithCallback: @selector(myTweetsCallback:) sender: self];
    [myTweetsRequest execute];
}

#pragma mark - Orientation Change Methods
//When the orientation changes refresh the tweet to refresh the font sizes
- (void)didRotateFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation
{
    [self refreshTweetText: self.currentTweet.text];
}

#pragma mark - Callbacks
//Callback for when my tweets return
- (void)myTweetsCallback: (id)object
{
    //Write the error to the error property for displaying later
    if([object isKindOfClass: [NSError class]])
        self.lastErrorMessage = [(NSError *)object localizedDescription];
    
    //Draw the tweet text to the screen
    else
    {
        Tweet *tweet = (Tweet *)object[0];
        self.currentTweet = tweet;
        [self refreshTweetText: tweet.text];
    }
}

#pragma mark - Tweet Drawing Methods
//Draws text out to the main text area
//Resizes the text to take up as much space as possible
- (void)drawTweetText: (NSString *)text
{
    //Get the main text of the tweet (first word)
    NSMutableArray *wordArray = [[text componentsSeparatedByString: @" "] mutableCopy];
    NSString *mainText = wordArray[0];
    
    //Get the sub text of the tweet (all the other words)
    [wordArray removeObjectAtIndex: 0];
    NSString *subText = [wordArray componentsJoinedByString: @" "];
    
    //Draw them
    self.tweetMainLabel.text = mainText;
    self.tweetSubLabel.text = subText;
    
    //Adjust font sizes
    CGFloat mainLabelFontSize = [self biggestFontSizeForText: mainText inRect: self.tweetMainLabel.bounds];
    CGFloat subLabelFontSize = [self biggestFontSizeForText: mainText inRect: self.tweetSubLabel.bounds];
    self.tweetMainLabel.font = [UIFont systemFontOfSize: mainLabelFontSize];
    self.tweetSubLabel.font = [UIFont systemFontOfSize: subLabelFontSize];
}

//Shows the tweet labels
- (void)showTweetLabels
{
    self.tweetMainLabel.alpha = 1;
    self.tweetSubLabel.alpha = 1;
}

//Hides the tweet labels
- (void)hideTweetLabels
{
    self.tweetMainLabel.alpha = 0;
    self.tweetSubLabel.alpha = 0;
}

//Fades out the old tweet and fades in the new tweet text
- (void)refreshTweetText: (NSString *)text
{
    [UIView animateWithDuration: 1 animations: ^{
        [self hideTweetLabels];
    } completion: ^(BOOL finished) {
        [self drawTweetText: text];
        [UIView animateWithDuration: 1 animations: ^{ [self showTweetLabels]; }];
    }];
}

#pragma mark - Helpers
//Returns the biggest font size that doesn't overflow the given rectangle
- (CGFloat)biggestFontSizeForText: (NSString *)text inRect: (CGRect)rect
{
    CGFloat fontSize = 0;
    for(int size = 15; YES; size += 2)
    {
        CGSize fontRectSize = [text sizeWithFont: [UIFont boldSystemFontOfSize: size]];
        if(fontRectSize.height >= rect.size.height || fontRectSize.width >= rect.size.width)
            break;
        fontSize = size;
    }
    return fontSize;
}
@end
