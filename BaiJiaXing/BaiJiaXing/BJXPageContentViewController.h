//
//  BJXPageContentViewController.h
//  BaiJiaXing
//
//  Created by Michael on 6/3/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJXPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSString* titleText;
@property NSUInteger pageIndex;

@end
