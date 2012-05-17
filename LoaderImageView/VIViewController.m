//
//  VIViewController.m
//  LoaderImageView
//
//  Created by Anthony Alesia on 5/17/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "VIViewController.h"
#import "VILoaderImageView.h"

@interface VIViewController ()

@end

@implementation VIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    VILoaderImageView *imageView = [[VILoaderImageView alloc] initWithFrame:CGRectMake(100, 100, 250, 250)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2943/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
