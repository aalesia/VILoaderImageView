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
    
    VILoaderImageView *imageView = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 84, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2943/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView];
    
    VILoaderImageView *imageView1 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 84, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3770/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView1];
    
    VILoaderImageView *imageView2 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 84, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3634/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView2];
    
    VILoaderImageView *imageView3 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 84, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3468/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView3];
    
    VILoaderImageView *imageView4 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 84, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3124/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView4];
    
    VILoaderImageView *imageView5 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 284, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3111/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView5];
    
    VILoaderImageView *imageView6 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 284, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2945/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView6];
    
    VILoaderImageView *imageView7 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 284, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2894/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView7];
    
    VILoaderImageView *imageView8 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 284, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2602/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView8];
    
    VILoaderImageView *imageView9 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 284, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2585/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView9];
    
    VILoaderImageView *imageView10 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 484, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/1731/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView10];
    
    VILoaderImageView *imageView11 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 484, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/2300/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView11];
    
    VILoaderImageView *imageView12 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 484, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/1951/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView12];
    
    VILoaderImageView *imageView13 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 484, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/1944/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView13];
    
    VILoaderImageView *imageView14 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 484, 200, 200)
                                                                   imageUrl:@"http://media.threadless.com//imgs/products/3773/636x460design_01.jpg" 
                                                                   animated:YES];
    [self.view addSubview:imageView14];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
