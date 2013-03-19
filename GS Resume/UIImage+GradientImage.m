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

//Creates a UIImage from a drawn gradient layer. Gradient flows top to bottom.
+ (UIImage *)gradientImageWithFame:(CGRect)rect andColorArray:(NSArray*)colors
{
    UIImage *image = nil;
    
    if (colors > 0)
    {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = rect;
        gradient.colors = colors;
        
        UIGraphicsBeginImageContextWithOptions(gradient.bounds.size, YES, 0.0);
        [gradient renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        gradient = nil;
    }
    
    return image;
}

//Creates a UIImage from a drawn gradient. Gradient flows left to right.
+ (UIImage *)gradientImageWithSize:(CGSize)size andColorArray:(NSArray*)colors withColorLocations:(CGFloat*)locations
{
    UIImage *image = nil;
    
    if (colors > 0)
    {
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, (__bridge CFArrayRef)(colors), locations);
        
        UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
        CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradientRef, CGPointMake(0, 0), CGPointMake(size.width, size.height), kCGGradientDrawsAfterEndLocation);
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGGradientRelease(gradientRef);
        CGColorSpaceRelease(colorSpaceRef);
    }
    
    return image;
}

@end
