//
//  GLKitViewController.m
//  GS Resume
//
//  Created by Greg S on 3/7/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#define self_glkView() ((GLKView*)self.view)
#define VIEW_WIDTH 703.0f
#define VIEW_HEIGHT 748.0f

#import "GLKitViewController.h"

#import "Square.h"

@interface GLKitViewController () {

    float aspect;
    float viewCenterX;
    float viewCenterY;
    Square *square;
    UIPanGestureRecognizer *panRecognizer;
}

@end

@implementation GLKitViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[GLKView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, VIEW_HEIGHT)];
    self.view.backgroundColor = [UIColor clearColor];
    self_glkView().context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:self_glkView().context];
    
    square = [[Square alloc] init];
    [square createBuffers];
    
    aspect = fabsf(VIEW_WIDTH / VIEW_HEIGHT);
    viewCenterX = VIEW_WIDTH/2.0f;
    viewCenterY = self.view.bounds.size.height/2.0f;
    
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [square drawSquareWithView:view inRect:rect];
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    [square translateAndRotateSquareWithAspectRation:aspect];
}

- (void)render:(CADisplayLink*)displayLink
{
    [self_glkView() display];
}

- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    
    square.point = CGPointMake((point.x - viewCenterX)/VIEW_WIDTH * 4.7f, -((point.y - viewCenterY)/VIEW_HEIGHT) * 5.0f);
}

- (void)dealloc
{
    [square deleteBuffers];
    
    self.view = nil;
    
    [EAGLContext setCurrentContext:nil];
}

@end
