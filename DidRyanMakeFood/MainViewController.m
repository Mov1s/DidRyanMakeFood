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
@property (nonatomic, strong) NSString *lastErrorMessage;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Request my tweets
    RequestGetMyTweets *myTweetsRequest = [[RequestGetMyTweets alloc] initWithCallback: @selector(myTweetsCallback:) sender: self];
    [myTweetsRequest execute];
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
        [self drawTweetText: tweet.text];
    }
}

#pragma mark - Tweet Drawing Methods
//Draws text out to the main text area
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
}

}
@end
