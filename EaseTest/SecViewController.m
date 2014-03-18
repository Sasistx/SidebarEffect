//
//  SecViewController.m
//  EaseTest
//
//  Created by cyou-Mac-003 on 13-5-21.
//  Copyright (c) 2013年 cyou-Mac-003. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController () 

@end

@implementation SecViewController

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
    
    UINavigationBar* naviagtionBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:nil];
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(itemDidSelected:)];
    [item setLeftBarButtonItem:buttonItem];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(next:)];
    [item setRightBarButtonItem:nextItem];
    
    [naviagtionBar pushNavigationItem:item animated:YES];
    
    [self.view addSubview:naviagtionBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UIImage*)getCapture
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.opaque, 0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
