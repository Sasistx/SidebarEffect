//
//  GTXSwipeViewController.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-23.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "GTXSwipeViewController.h"

@interface GTXSwipeViewController () {

    CGPoint startTouch;
    BOOL _isMoving;
    
    UIImageView* _shotImageView;
    UIView* _blackMaskView;
    UIView* _backgroundView;
    
    CYGTXTableView* tableview;
}

@end

@implementation GTXSwipeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.shotsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UINavigationBar* naviagtionBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:nil];
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(itemDidSelected:)];
    [item setLeftBarButtonItem:buttonItem];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(next:)];
    [item setRightBarButtonItem:nextItem];
    
    [naviagtionBar pushNavigationItem:item animated:YES];
    
    [self.view addSubview:naviagtionBar];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 10, self.view.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
    [self.view addSubview:imageView];
    
    tableview = [[CYGTXTableView alloc] initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height-64)];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    [tableview setTouchDelagate:self];
    [self.view addSubview:tableview];
    
    UIBarButtonItem* itemButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(itemDidClicked:)];
    self.navigationItem.rightBarButtonItem = itemButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - swipe event

- (void)swipeTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    startTouch = [touch locationInView:KEY_WINDOW];
}

- (void)swipeTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint endTouch = [touch locationInView:KEY_WINDOW];
    [tableview setScrollEnabled:YES];
    if (endTouch.x - startTouch.x > 50 || self.view.frame.origin.x > 100) {
        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
        [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
            [self calculateViewPositionX:[UIScreen mainScreen].bounds.size.width];
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
            _isMoving = NO;
        }];
    }else {
        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
        [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
            [self calculateViewPositionX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
        }];
    }

}

- (void)swipeTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:KEY_WINDOW];
    if (!_isMoving) {
        if (currentPoint.x - startTouch.x > 10) {
            _isMoving = YES;
            [tableview setScrollEnabled:NO];
            if (!_backgroundView) {
                
                _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
                [self.view.superview insertSubview:_backgroundView belowSubview:self.view];
                
                _blackMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
                _backgroundView.backgroundColor = [UIColor blackColor];
                [_backgroundView addSubview:_blackMaskView];
            }
            
            if (_shotImageView) {
                [_shotImageView removeFromSuperview];
            }
            _shotImageView = [[UIImageView alloc] initWithImage:[self.shotsArray lastObject]];
            [_backgroundView insertSubview:_shotImageView aboveSubview:_blackMaskView];
        }
        
    }
    
    if (_isMoving) {
        [self calculateViewPositionX:currentPoint.x - startTouch.x];
    }
}

- (void)swipeTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tableview setScrollEnabled:YES];
    UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
    [UIView transitionWithView:self.view duration:0.3 options:option animations:^{
        [self calculateViewPositionX:0];
    } completion:^(BOOL finished) {
        _isMoving = NO;
    }];
}

- (void)calculateViewPositionX:(CGFloat)shiftX
{
    shiftX = shiftX > 320 ? 320 : shiftX;
    shiftX = shiftX < 0 ? 0 : shiftX;
    
    CGFloat scale = (shiftX/6400)+0.95;
    CGFloat alpha = 0.4-(shiftX/800);
    
    [self.view setFrame:CGRectMake(shiftX, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    _shotImageView.transform = CGAffineTransformMakeScale(scale, scale);
    _blackMaskView.alpha = alpha;
}

#pragma mark - touch delegate

- (void)tableViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self swipeTouchesBegan:touches withEvent:event];
}

- (void)tableViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self swipeTouchesEnded:touches withEvent:event];
}

- (void)tableViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self swipeTouchesMoved:touches withEvent:event];
}

- (void)tableViewTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self swipeTouchesCancelled:touches withEvent:event];
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"cellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - item clicked

- (void)itemDidClicked:(id)sender
{
    GTXSwipeViewController* svc = [[GTXSwipeViewController alloc] init];
    [svc.shotsArray addObject:[self getCapture] ];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - button click

- (void)itemDidSelected:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(topItemDidClicked)]) {
        [self.delegate performSelector:@selector(topItemDidClicked)];
    }
}

- (void)next:(id)sender
{
    //ThirdViewController* tvc = [[ThirdViewController alloc] init];
    GTXSwipeViewController* tvc = [[GTXSwipeViewController alloc] init];
    [tvc.shotsArray addObject:[self getCapture]];
    UINavigationController* controller = (CYGTXNavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [controller pushViewController:tvc animated:YES];
}


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
