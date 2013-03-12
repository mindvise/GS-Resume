//
//  Square.h
//  GS Resume
//
//  Created by Greg S on 3/11/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Square : NSObject

@property CGPoint point;
@property CGFloat rotation;
@property CGFloat scale;

- (void)createBuffers;
- (void)deleteBuffers;
- (void)drawSquareWithView:(GLKView *)view inRect:(CGRect)rect;
- (void)updateSquareModelWithAspectRatio:(float)aspect;

@end
