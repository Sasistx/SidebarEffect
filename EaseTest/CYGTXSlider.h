//
//  CYGTXSlider.h
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-22.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYGTXSlider : UIControl

@property (nonatomic, unsafe_unretained) CGFloat maximumValue;

@property (nonatomic, unsafe_unretained) CGFloat minimumValue;

@property (nonatomic, unsafe_unretained) CGFloat currentValue;

@property (nonatomic, unsafe_unretained) CGFloat cacheValue;

@property (nonatomic, unsafe_unretained) CGPoint buttonCenter;

@property (nonatomic, strong) UIImage* handleImageHightlight;

@property (nonatomic, strong) UIImage* handleImageNormal;

@property (nonatomic, strong) UIImage* cacheImage;

@property (nonatomic, strong) UIImage* trackImage;

@property (nonatomic, strong) UIImage* trackBackgroundImage;

@end
