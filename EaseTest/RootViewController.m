//
//  RootViewController.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-21.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () {

    UIView* _topView;
    UIView* _tmpView;
    
    UIImageView* _maskingView;
    
    CGPoint prePoint;
    BOOL _isClosed;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _isClosed = YES;
    _controllerArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 5; i++) {
        SecViewController* svc = [[SecViewController alloc] init];
        //GTXSwipeViewController* svc = [[GTXSwipeViewController alloc] init];
        NSInteger red = arc4random()%256;
        NSInteger green = arc4random()%256;
        NSInteger blue = arc4random()%256;
        [svc.view setBackgroundColor:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f]];
        [svc.view setFrame:self.view.frame];
        [svc.view setTag:200+i];
        //[svc.shotsArray addObject:[self getCapture]];
        [_controllerArray addObject:svc];
        [svc setDelegate:(id)self];
    }
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    
    _maskingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    [_maskingView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_maskingView];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    [_topView setBackgroundColor:[UIColor clearColor]];
    [_topView setTag:100];
    SecViewController* svc = [_controllerArray objectAtIndex:0];
    _tmpView = svc.view;
    [_topView addSubview:_tmpView];
    [self.view addSubview:_topView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delgate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_controllerArray count];
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
    [_tmpView removeFromSuperview];
    SecViewController* svc = [_controllerArray objectAtIndex:indexPath.row];
    _tmpView = svc.view;
    [_topView addSubview:_tmpView];
    UIViewAnimationOptions option = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
    [UIView transitionWithView:_topView duration:0.3f options:option animations:^{
        _topView.transform = CGAffineTransformIdentity;
        [_topView setFrame:CGRectMake(0, 0, _topView.frame.size.width, _topView.frame.size.height)];
    } completion:Nil];
}

#pragma mark - button delegate

- (void)topItemDidClicked
{
    UIViewAnimationOptions option = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
    if (_topView.frame.origin.x > 150) {
        [UIView transitionWithView:_topView duration:0.3f options:option animations:^{
            [_topView setFrame:CGRectMake(200, _topView.frame.origin.y, _topView.frame.size.width, _topView.frame.size.height)];
            _topView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        } completion:Nil];
    }else {
        [UIView transitionWithView:_topView duration:0.3f options:option animations:^{
            _topView.transform = CGAffineTransformIdentity;
            [_topView setFrame:CGRectMake(0, 0, _topView.frame.size.width, _topView.frame.size.height)];
        } completion:Nil];
    }
    
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    prePoint = [touch locationInView:KEY_WINDOW];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    CGPoint nextPoint = [touch locationInView:KEY_WINDOW];
    CGFloat horShift = nextPoint.x - prePoint.x ;
    CGFloat currentPointX = _topView.frame.origin.x + horShift;
    if (currentPointX < 0) {
        currentPointX = 0;
    }
    CGFloat alpha = 200-currentPointX;
    alpha = alpha < 0 ? 0 : alpha;
    
    [_topView setFrame:CGRectMake(currentPointX, _topView.frame.origin.y, _topView.frame.size.width, _topView.frame.size.height)];
    _topView.transform = CGAffineTransformMakeScale(1 - currentPointX/600, 1 - currentPointX/600);
    
    
    [_maskingView setAlpha:(alpha/320.0f)];
    prePoint = nextPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_topView.frame.origin.x >= 130) {
        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
        [UIView transitionWithView:_topView duration:0.2 options:option animations:^{
            [_topView setFrame:CGRectMake(200, _topView.frame.origin.y, _topView.frame.size.width, _topView.frame.size.height)];
            _topView.transform = CGAffineTransformMakeScale(0.7, 0.7);
            [_maskingView setAlpha:0];
        } completion:^(BOOL finished) {
            
        }];
    }else if (_topView.frame.origin.x < 130) {
        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
        [UIView transitionWithView:_topView duration:0.2 options:option animations:^{
            _topView.transform = CGAffineTransformIdentity;
            [_topView setFrame:CGRectMake(0, 0, _topView.frame.size.width, _topView.frame.size.height)];
            
            [_maskingView setAlpha:200/320.0f];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (UIImage*)getCapture
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.opaque, 0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
