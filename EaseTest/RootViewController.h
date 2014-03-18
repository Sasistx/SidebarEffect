//
//  RootViewController.h
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-21.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SecViewController.h"
@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {

    NSMutableArray* _controllerArray;
}
@property (nonatomic, strong) NSMutableArray* controllerArray;
@end
