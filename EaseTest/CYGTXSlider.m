//
//  CYGTXSlider.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-22.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "CYGTXSlider.h"

@implementation CYGTXSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //UISlider
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

#pragma mark - configure

- (void)configureView
{
    _maximumValue = 1.0f;
    _minimumValue = 0.0f;
    _cacheValue = 0.0f;
    _currentValue = 0.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - layout

- (void)layoutSubviews
{
    
}

@end
