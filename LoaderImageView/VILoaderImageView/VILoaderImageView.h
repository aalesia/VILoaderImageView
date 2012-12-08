//
//  VILoaderImageView.h
//  LoaderImageView
//
//  Created by Anthony Alesia on 5/17/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface VILoaderImageView : UIImageView
{

}

@property (strong, nonatomic) UIColor *indicatorColor;
+ (NSOperationQueue *)getQueue;
+ (void)cacheImage:(NSString *)imageURLString completion:(void (^)(UIImage *image))completion;

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl animated:(BOOL)animated;

- (void)setImageUrl:(NSString *)imageUrl;
- (void)setImageUrl:(NSString *)imageUrl animated:(BOOL)animated;
- (void)setImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)defaultImage;
- (void)setImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)defaultImage animated:(BOOL)animated;
- (void)setImageUrlClearingCache:(NSString *)imageUrl animated:(BOOL)animated;
- (void)setImageUrl:(NSString *)imageUrl completion:(void (^)(UIImage *image))completion;

- (void)startIndicatorAnimating;
- (void)stopIndicatorAnimating;

- (void)cancel;

@end
