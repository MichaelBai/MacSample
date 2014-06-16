//
//  BJXItemViewController.m
//  BaiJiaXing
//
//  Created by Michael on 5/19/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import "BJXItemViewController.h"

@interface BJXItemViewController ()

- (void) backViewGesture:(UIPanGestureRecognizer *)sender;

@end

@implementation BJXItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView setBackgroundColor:[UIColor lightGrayColor]];
    // customize webcontent
    NSMutableString* content = [NSMutableString stringWithString:self.webContent];
    [content insertString:@"<p style=\"overflow:hidden;\">" atIndex:0];
    [content appendString:@"</p>"];
    [self.webView loadHTMLString:content baseURL:nil];
    
    //Set gesture
    UIPanGestureRecognizer *backViewGestureRecognizer
    = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(backViewGesture:)];
    
    [self.view addGestureRecognizer:backViewGestureRecognizer];
}

- (void) backViewGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:sender.view];
    //Threshold : distance which how long move your thumb.
    if (translation.x > 45.0) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.view removeGestureRecognizer:sender];
    }
}

@end
