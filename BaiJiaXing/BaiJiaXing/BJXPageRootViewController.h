//
//  BJXPageRootViewController.h
//  BaiJiaXing
//
//  Created by Michael on 6/3/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJXPageRootViewController : UIViewController <UIPageViewControllerDataSource>

@property NSArray* pageTitles;
@property UIPageViewController* pageViewController;

@end
