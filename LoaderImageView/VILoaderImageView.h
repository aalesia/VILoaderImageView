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

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl animated:(BOOL)animated;
- (void)setImageUrl:(NSString *)imageUrl;
- (void)setImageUrl:(NSString *)imageUrl animated:(BOOL)animated;

@end
