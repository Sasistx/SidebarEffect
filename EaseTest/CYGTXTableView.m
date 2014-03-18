//
//  CYGTXTableView.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-23.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "CYGTXTableView.h"

@implementation CYGTXTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.touchDelagate && [self.touchDelagate respondsToSelector:@selector(tableViewTouchesBegan:withEvent:)]) {
        [self.touchDelagate performSelector:@selector(tableViewTouchesBegan:withEvent:) withObject:touches withObject:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.touchDelagate && [self.touchDelagate respondsToSelector:@selector(tableViewTouchesEnded:withEvent:)]) {
        [self.touchDelagate performSelector:@selector(tableViewTouchesEnded:withEvent:) withObject:touches withObject:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (self.touchDelagate && [self.touchDelagate respondsToSelector:@selector(tableViewTouchesMoved:withEvent:)]) {
        [self.touchDelagate performSelector:@selector(tableViewTouchesMoved:withEvent:) withObject:touches withObject:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (self.touchDelagate && [self.touchDelagate respondsToSelector:@selector(tableViewTouchesCancelled:withEvent:)]) {
        [self.touchDelagate performSelector:@selector(tableViewTouchesCancelled:withEvent:) withObject:touches withObject:event];
    }
}


@end
