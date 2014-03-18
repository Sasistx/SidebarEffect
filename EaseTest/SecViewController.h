//
//  SecViewController.h
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-21.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdViewController.h"
#import "CYGTXNavigationController.h"
#import "GTXSwipeViewController.h"

@protocol SecViewControllerDelegate <NSObject>
@required
- (void)topItemDidClicked;
@end

@interface SecViewController : UIViewController
@property (nonatomic, weak) id <SecViewControllerDelegate> delegate;
@end
