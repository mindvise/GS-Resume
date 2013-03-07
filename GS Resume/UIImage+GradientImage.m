//
//  UIImage+GradientImage.m
//  iRecruit
//
//  Created by Greg Shobe on 10/23/12.
//  Copyright (c) 2012 BSC. All rights reserved.
//

#import "UIImage+GradientImage.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@implementation UIImage (GradientImage)

+ (UIImage *)gradientImageWithFame:(CGRect)rect andColorArray:(NSArray*)colors
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    gradient.colors = colors;
    gradient.shouldRasterize = YES;
    
    UIGraphicsBeginImageContextWithOptions(gradient.bounds.size, YES, 0.0);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
