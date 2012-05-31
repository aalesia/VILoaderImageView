//
//  VIViewController.m
//  LoaderImageView
//
//  Created by Anthony Alesia on 5/17/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "VIViewController.h"
#import "VILoaderImageView.h"

#define DELAY           10.0

@interface VIViewController ()

@property (nonatomic, strong) NSArray *images;

@end

@implementation VIViewController

@synthesize images = _images;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _images = [self imagesArray];
    
    VILoaderImageView *imageView = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 84, 200, 200) 
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView
               afterDelay:DELAY];
    
    VILoaderImageView *imageView1 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 84, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView1];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView1
               afterDelay:DELAY];
    
    VILoaderImageView *imageView2 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 84, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView2];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView2
               afterDelay:DELAY];
    
    VILoaderImageView *imageView3 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 84, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView3];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView3
               afterDelay:DELAY];
    
    VILoaderImageView *imageView4 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 84, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView4];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView4
               afterDelay:DELAY];
    
    VILoaderImageView *imageView5 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 284, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView5];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView5
               afterDelay:DELAY];
    
    VILoaderImageView *imageView6 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 284, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView6];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView6
               afterDelay:DELAY];
    
    VILoaderImageView *imageView7 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 284, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView7]; 
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView7
               afterDelay:DELAY];
    
    VILoaderImageView *imageView8 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 284, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView8];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView8
               afterDelay:DELAY];
    
    VILoaderImageView *imageView9 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 284, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView9];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView9
               afterDelay:DELAY];
    
    VILoaderImageView *imageView10 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(12, 484, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView10];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView10
               afterDelay:DELAY];
    
    VILoaderImageView *imageView11 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(212, 484, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView11];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView11
               afterDelay:DELAY];
    
    VILoaderImageView *imageView12 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(412, 484, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView12];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView12
               afterDelay:DELAY];
    
    VILoaderImageView *imageView13 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(612, 484, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView13];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView13
               afterDelay:DELAY];
    
    VILoaderImageView *imageView14 = [[VILoaderImageView alloc] initWithFrame:CGRectMake(812, 484, 200, 200)
                                                                   imageUrl:[self urlForCurrentIndex] 
                                                                   animated:YES];
    [self.view addSubview:imageView14];
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView14
               afterDelay:DELAY];
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

#pragma mark - Instance Methods

- (NSArray *)imagesArray
{
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:2943],
            [NSNumber numberWithInt:3770],
            [NSNumber numberWithInt:3634],
            [NSNumber numberWithInt:3468],
            [NSNumber numberWithInt:3124],
            [NSNumber numberWithInt:3111],
            [NSNumber numberWithInt:2945],
            [NSNumber numberWithInt:2894],
            [NSNumber numberWithInt:2602],
            [NSNumber numberWithInt:2585],
            [NSNumber numberWithInt:1731],
            [NSNumber numberWithInt:2300],
            [NSNumber numberWithInt:1951],
            [NSNumber numberWithInt:1944],
            [NSNumber numberWithInt:3773],
            [NSNumber numberWithInt:3812],
            [NSNumber numberWithInt:3772],
            [NSNumber numberWithInt:3771],
            [NSNumber numberWithInt:844],
            [NSNumber numberWithInt:3713],
            [NSNumber numberWithInt:2588],
            [NSNumber numberWithInt:2954],
            [NSNumber numberWithInt:2966],
            [NSNumber numberWithInt:2260],
            [NSNumber numberWithInt:2347],
            [NSNumber numberWithInt:2985],
            [NSNumber numberWithInt:3257],
            [NSNumber numberWithInt:3121],
            [NSNumber numberWithInt:2059],
            [NSNumber numberWithInt:2253], nil];
}

- (void)changeImageForImageView:(VILoaderImageView *)imageView
{
    [imageView setImageUrl:[self urlForCurrentIndex] animated:YES];
    
    [self performSelector:@selector(changeImageForImageView:)
               withObject:imageView
               afterDelay:DELAY];
}

- (NSString *)urlForCurrentIndex
{
    int index = arc4random() % [_images count];
    
    return [NSString stringWithFormat:@"http://media.threadless.com//imgs/products/%@/636x460design_01.jpg", [[_images objectAtIndex:index] stringValue]];
}

@end
