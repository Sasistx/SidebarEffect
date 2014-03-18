//
//  CYGTXNavigationController.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-22.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "CYGTXNavigationController.h"

@interface CYGTXNavigationController () {

    NSMutableArray* _shotsArray;
    
    UIImageView* _shotImageView;
    UIView* _blackMaskView;
    UIView* _backgroundView;
    
    CGPoint startTouch;
    BOOL _isMoving;
}

@end

@implementation CYGTXNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //_shotsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 10, self.view.frame.size.height)];
//    [imageView setImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
//    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - touch event

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    UITouch* touch = [touches anyObject];
//    startTouch = [touch locationInView:KEY_WINDOW];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    
//    if ([self.viewControllers count] <= 1) {
//        return;
//    }
//    
//    UITouch* touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:KEY_WINDOW];
//    if (!_isMoving) {
//        if (currentPoint.x - startTouch.x > 10) {
//            _isMoving = YES;
//            if (!_backgroundView) {
//                
//                _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
//                [self.view.superview insertSubview:_backgroundView belowSubview:self.view];
//                
//                _blackMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
//                _backgroundView.backgroundColor = [UIColor blackColor];
//                [_backgroundView addSubview:_blackMaskView];
//            }
//            
//            if (_shotImageView) {
//                [_shotImageView removeFromSuperview];
//            }
//            _shotImageView = [[UIImageView alloc] initWithImage:[_shotsArray lastObject]];
//            [_backgroundView insertSubview:_shotImageView aboveSubview:_blackMaskView];
//        }
//        
//    }
//    
//    if (_isMoving) {
//        [self calculatePositionX:currentPoint.x - startTouch.x];
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesEnded:touches withEvent:event];
//    if ([self.viewControllers count] <= 1) {
//        return;
//    }
//    
//    UITouch* touch = [touches anyObject];
//    CGPoint endTouch = [touch locationInView:KEY_WINDOW];
//    
//    if (endTouch.x - startTouch.x > 50) {
//        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
//        [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
//            [self calculatePositionX:[UIScreen mainScreen].bounds.size.width];
//        } completion:^(BOOL finished) {
//            [self popViewControllerAnimated:NO];
//            CGRect frame = self.view.frame;
//            frame.origin.x = 0;
//            self.view.frame = frame;
//            _isMoving = NO;
//        }];
//    }else {
//        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
//        [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
//            [self calculatePositionX:0];
//        } completion:^(BOOL finished) {
//            _isMoving = NO;
//        }];
//    }
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesCancelled:touches withEvent:event];
//    
//    if ([self.viewControllers count] <= 1) {
//        return;
//    }
//    
//    UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
//    [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
//        [self calculatePositionX:0];
//    } completion:^(BOOL finished) {
//        _isMoving = NO;
//    }];
//}

- (void)dealloc
{
    
}

#pragma mark - calculate position

- (void)calculatePositionX:(CGFloat)shiftX
{
    shiftX = shiftX > 320 ? 320 : shiftX;
    shiftX = shiftX < 0 ? 0 : shiftX;
    
    CGFloat scale = (shiftX/6400)+0.95;
    CGFloat alpha = 0.4-(shiftX/800);
    
    [self.view setFrame:CGRectMake(shiftX, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    _shotImageView.transform = CGAffineTransformMakeScale(scale, scale);
    _blackMaskView.alpha = alpha;
}


#pragma mark - navigation method

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [_shotsArray addObject:[self getCapture]];
//    [super pushViewController:viewController animated:animated];
//}
//
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//    [_shotsArray removeLastObject];
//    return [super popViewControllerAnimated:animated];
//}

#pragma mark - get screen shot

- (UIImage*)getCapture
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.opaque, 0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
