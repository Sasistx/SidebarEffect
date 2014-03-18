//
//  GTXSwipeViewController.h
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-23.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYGTXTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "CYGTXNavigationController.h"
@protocol GTXSwipeViewControllerDelegate <NSObject>
@required
- (void)topItemDidClicked;
@end

@interface GTXSwipeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CYGTXTableViewDelegate>

@property (nonatomic, strong) NSMutableArray* shotsArray;
@property (nonatomic, weak) id <GTXSwipeViewControllerDelegate> delegate;
@end
