//
//  BJXItemViewController.m
//  BaiJiaXing
//
//  Created by Michael on 5/19/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import "BJXItemViewController.h"

@implementation BJXItemViewController

- (void)viewDidLoad
{
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView loadHTMLString:self.webContent baseURL:nil];
}

@end
