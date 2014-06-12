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
    [super viewDidLoad];
    [self.webView setBackgroundColor:[UIColor lightGrayColor]];
    NSMutableString* content = [NSMutableString stringWithString:self.webContent];
    [content insertString:@"<p style=\"overflow:hidden;\">" atIndex:0];
    [content appendString:@"</p>"];
    [self.webView loadHTMLString:content baseURL:nil];
}

@end
