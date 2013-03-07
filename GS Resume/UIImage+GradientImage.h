//
//  UIImage+GradientImage.h
//  iRecruit
//
//  Created by Greg Shobe on 10/23/12.
//  Copyright (c) 2012 BSC. All rights reserved.
//
//  UIImage category to make a gradient image for use with [UIColor colorWithPatternImage:]

#import <UIKit/UIKit.h>

@interface UIImage (GradientImage)

+ (UIImage *)gradientImageWithFame:(CGRect)rect andColorArray:(NSArray*)colors;

@end
