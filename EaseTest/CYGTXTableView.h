//
//  CYGTXTableView.h
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-23.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYGTXTableViewDelegate <NSObject>

@required

- (void)tableViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableViewTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface CYGTXTableView : UITableView

@property (nonatomic, weak) id <CYGTXTableViewDelegate> touchDelagate;

@end
