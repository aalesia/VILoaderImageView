//
//  VILoaderImageView.m
//  LoaderImageView
//
//  Created by Anthony Alesia on 5/17/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "VILoaderImageView.h"
#import "UIImage+Decompression.h"

#define TMP NSTemporaryDirectory()

//Set to -1 to never recache a cached image.

#define LENGTH_OF_CACHE                 86400

#define PREDECOMPRESS                   1

#define LOCAL_CACHE_MAX_ITEMS           50

#define MAX_CONCURRENT_OPERATIONS       5

@interface VILoaderImageView ()
{
    BOOL* cancelledPtr;
}

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

+ (UIImage *)getCachedImage:(NSString *)imageURLString;
+ (void)cacheImage:(NSString *)imageURLString completion:(void (^)(UIImage *image))completion;
@end

@implementation VILoaderImageView

@synthesize activityIndicator = _activityIndicator;

static NSOperationQueue *_queue = nil;
static NSMutableArray *_localCache = nil;


+ (NSOperationQueue *)getQueue
{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:MAX_CONCURRENT_OPERATIONS];
    });
    
    return _queue;
}

+ (NSMutableArray *)getCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _localCache = [[NSMutableArray alloc]init];
    });
    
    return _localCache;
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

- (void)cancel
{
    if (cancelledPtr) {
        *cancelledPtr = YES;
    }
}

#pragma mark - Instance Methods

+ (UIImage*)checkForImageInLocalCache:(NSString *)imageName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@)", imageName];
    NSMutableArray *locallyCached = [VILoaderImageView getCache];
    
    NSArray *results = [[VILoaderImageView getCache] filteredArrayUsingPredicate:predicate];
    
    if ([results count] == 1) {
        NSLog(@"Cache hit");
        NSDictionary*imageDict = [results objectAtIndex:0];
        
        [locallyCached removeObject:imageDict];
        [locallyCached addObject:imageDict];
        
        return [imageDict objectForKey:@"image"];
        
    }else if([results count] == 0){
        return nil;
    }else{
        return [[results objectAtIndex:0]objectForKey:imageName];
        NSLog(@"Multiple images in cache");
    }
}

+ (void)checkAndRemoveExistingEntry:(NSString*)key
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@)", key];
    NSMutableArray *locallyCached = [VILoaderImageView getCache];
    
    NSArray *results = [[VILoaderImageView getCache] filteredArrayUsingPredicate:predicate];
    
    if ([results count] == 1) {
        NSLog(@"Cache hit");
        NSDictionary*imageDict = [results objectAtIndex:0];
        
        [locallyCached removeObject:imageDict];
    }
    
}

+ (void)addImageToLocalCache:(UIImage*)image withKey:(NSString*)key
{
    [VILoaderImageView checkAndRemoveExistingEntry:key];
    
    NSMutableArray *locallyCached = [VILoaderImageView getCache];
    if (locallyCached.count >= LOCAL_CACHE_MAX_ITEMS) {
        [locallyCached removeObjectAtIndex:0];
    }
    
    NSDictionary *imageDict = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", key, @"name", nil];
    [locallyCached addObject:imageDict];
}

- (void)setImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)defaultImage
{
    [self setImageUrl:imageUrl defaultImage:defaultImage animated:NO];
}

- (void)setImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)defaultImage animated:(BOOL)animated
{
    self.image = defaultImage;
    
    [self setImageUrl:imageUrl animated:animated];
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self setImageUrl:imageUrl animated:NO];
}

- (void)setImageUrl:(NSString *)imageUrl animated:(BOOL)animated
{
    __block BOOL cancelled = NO;
    __block UIImage *image;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        image = [VILoaderImageView getCachedImage:imageUrl];
    });
        if (image != nil) {
            self.image = image;
        } else {
            [[VILoaderImageView getQueue] addOperationWithBlock:^{
                if (_activityIndicator == nil) {
                    [self startIndicatorAnimating];
                }
                
                [VILoaderImageView cacheImage:imageUrl completion:^(UIImage *image) {
                    [self stopIndicatorAnimating];
                    if (!cancelled) {
                        if (animated) {
                            [self animateImage:image];
                        } else {
                            self.image = image;
                        }
                    }
                }];
            }];
            cancelledPtr = &cancelled;
        }
}

- (void)setImageUrlClearingCache:(NSString *)imageUrl animated:(BOOL)animated
{

    __block BOOL cancelled = NO;
    [[VILoaderImageView getQueue] addOperationWithBlock:^{
        if (_activityIndicator == nil) {
            [self startIndicatorAnimating];
        }
        
        [VILoaderImageView recacheImage:imageUrl completion:^(UIImage *image) {
            [self stopIndicatorAnimating];
            if (!cancelled) {
                if (animated) {
                    [self animateImage:image];
                } else {
                    self.image = image;
                }
            }
        }];
    }];
    cancelledPtr = &cancelled;
    
}

- (void)startIndicatorAnimating
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                       self.frame.size.width,
                                                                                       self.frame.size.height)];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [_activityIndicator startAnimating];
        [self addSubview:_activityIndicator];
    });
}

- (void)stopIndicatorAnimating
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_activityIndicator stopAnimating];
        [_activityIndicator removeFromSuperview];
        _activityIndicator = nil;
    });
}

#pragma mark - Private Methods

#pragma mark - Instance Methods

- (void)animateImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.2];
        [animation setType:kCATransitionFade];
        [animation setSubtype:kCATransitionFade];
        
        [[self layer] addAnimation:animation forKey:@"DisplayView"];
    });
}

#pragma mark - Class Methods

+ (void)recacheImage:(NSString*)imageURLString completion:(void (^)(UIImage *image))completion
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
        
        NSFileManager*fm = [NSFileManager defaultManager];
        
        // Check for file existence
        if([fm fileExistsAtPath:uniquePath])
        {
            [fm removeItemAtPath:uniquePath error:nil];
        }
        
        image = [VILoaderImageView writeFile:imageURL toPath:uniquePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(image);
            }
        });
        
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    });

}

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
        
        NSFileManager*fm = [NSFileManager defaultManager];
        
        // Check for file existence
        if(![fm fileExistsAtPath:uniquePath])
        {
            image = [VILoaderImageView writeFile:imageURL toPath:uniquePath];
            
        }else{
            
            NSDictionary*attrs = [fm attributesOfItemAtPath:uniquePath error:nil];
            NSDate *date = (NSDate*)[attrs objectForKey: NSFileCreationDate];

            if ([date timeIntervalSinceNow] < LENGTH_OF_CACHE && LENGTH_OF_CACHE != -1){
                [fm removeItemAtPath:uniquePath error:nil];
                image = [VILoaderImageView writeFile:imageURL toPath:uniquePath];
            }else{
                image = [VILoaderImageView getCachedImage:uniquePath];
            }

        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(image);
            }
        });
        
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    });
}

+ (UIImage*)writeFile:(NSURL*)imageURL toPath:(NSString*)uniquePath
{

    NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage* image = [[UIImage alloc] initWithData: data];
    
    [VILoaderImageView addImageToLocalCache:image withKey:[[uniquePath componentsSeparatedByString:@"/"] lastObject]];
    
    if([[imageURL absoluteString] rangeOfString:@".jpg" options:NSCaseInsensitiveSearch].location != NSNotFound || [[imageURL absoluteString] rangeOfString:@".jpeg" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        [UIImagePNGRepresentation(image) writeToFile:uniquePath atomically: YES];
        
    }
    else {
        [UIImageJPEGRepresentation(image, .2) writeToFile:uniquePath atomically: YES];
    }
    
    return image;

}

+ (UIImage *)getCachedImage:(NSString *)imageURLString
{
    NSString *filename = [[imageURLString stringByReplacingOccurrencesOfString:@":" withString:@""]
                          stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    UIImage *image = nil;
    
    //Check for a local cached version
    image = [VILoaderImageView checkForImageInLocalCache:filename];
    
    if (image == nil) {
        // Check for a hard cached version
        if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath]) {
            
            image = (PREDECOMPRESS?[UIImage imageWithContentsOfFile: uniquePath]:
                                        [[UIImage alloc] initWithContentsOfFileDecompressed: uniquePath]);
            
        }
    }
	
    return image;
}

@end
