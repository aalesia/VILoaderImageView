//
//  VILoaderImageView.m
//  LoaderImageView
//
//  Created by Anthony Alesia on 5/17/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "VILoaderImageView.h"

#define TMP NSTemporaryDirectory()
#define MAX_CONCURRENT_OPERATIONS       5

@interface VILoaderImageView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

+ (UIImage *)getCachedImage:(NSString *)imageURLString;
+ (void)cacheImage:(NSString *)imageURLString completion:(void (^)(UIImage *image))completion;
@end

@implementation VILoaderImageView

@synthesize activityIndicator = _activityIndicator;

static NSOperationQueue *_queue = nil;

+ (NSOperationQueue *)getQueue
{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:MAX_CONCURRENT_OPERATIONS];
    });
    
    return _queue;
}

#pragma mark - Public Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl
{
    return [self initWithFrame:frame imageUrl:imageUrl animated:NO];
}

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl animated:(BOOL)animated
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setImageUrl:imageUrl animated:animated];
    }
    return self;
}

#pragma mark - Instance Methods

- (void)setImageUrl:(NSString *)imageUrl
{
    [self setImageUrl:imageUrl animated:NO];
}

- (void)setImageUrl:(NSString *)imageUrl animated:(BOOL)animated
{
    UIImage *image = [VILoaderImageView getCachedImage:imageUrl];
    
    if (image != nil) {
        self.image = image;
    } else {
        [[VILoaderImageView getQueue] addOperationWithBlock:^{
            _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                                           self.frame.size.width,
                                                                                           self.frame.size.height)];
            _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [_activityIndicator startAnimating];
            [self addSubview:_activityIndicator];
            
            [VILoaderImageView cacheImage:imageUrl completion:^(UIImage *image) {
                [_activityIndicator stopAnimating];
                [_activityIndicator removeFromSuperview];
                _activityIndicator = nil;
                
                if (animated) {
                    [self animateImage:image];
                } else {
                    self.image = image;
                }
            }];
        }];
    }
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)animateImage:(UIImage *)image
{
    self.image = image;
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.2];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFade];
    
    [[self layer] addAnimation:animation forKey:@"DisplayView"];
}

#pragma mark - Class Methods

+ (void)cacheImage:(NSString *)imageURLString completion:(void (^)(UIImage *image))completion
{
    __block UIBackgroundTaskIdentifier bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        
        // Generate a unique path to a resource representing the image you want
        NSString *filename = [[imageURLString stringByReplacingOccurrencesOfString:@":" withString:@""]
                              stringByReplacingOccurrencesOfString:@"/" withString:@""];
        
        NSString *uniquePath = [TMP stringByAppendingPathComponent:filename];
        UIImage *image = nil;
        
        // Check for file existence
        if(![[NSFileManager defaultManager] fileExistsAtPath:uniquePath])
        {
            NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
            image = [[UIImage alloc] initWithData: data];
            
            if([imageURLString rangeOfString:@".jpg" options:NSCaseInsensitiveSearch].location != NSNotFound || 
               [imageURLString rangeOfString:@".jpeg" options:NSCaseInsensitiveSearch].location != NSNotFound
               ) {
                [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
            } else {
                [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
        
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    });
}

+ (UIImage *)getCachedImage:(NSString *)imageURLString
{
    NSString *filename = [[imageURLString stringByReplacingOccurrencesOfString:@":" withString:@""]
                          stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    UIImage *image = nil;
    
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath]) {
        image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
	
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
