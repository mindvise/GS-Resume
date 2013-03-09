//
//  GLKitViewController.m
//  GS Resume
//
//  Created by Greg S on 3/7/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#define self_glkView() ((GLKView*)self.view)

#import "GLKitViewController.h"

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    {{1, -1, 0}, {1, 0, 0, 1}},
    {{1, 1, 0}, {0, 1, 0, 1}},
    {{-1, 1, 0}, {0, 0, 1, 1}},
    {{-1, -1, 0}, {0, 0, 0, 1}}
};

const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0
};

@interface GLKitViewController () {

    float aspect;
    float rotation;
    float viewCenterX;
    float viewCenterY;
    CGPoint point;
    GLuint vertexBuffer;
    GLuint indexBuffer;
    
    GLKBaseEffect *effect;
    UIPanGestureRecognizer *panRecognizer;
}

@end

@implementation GLKitViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[GLKView alloc] initWithFrame:CGRectMake(0, 0, 703, 748)];
    self.view.backgroundColor = [UIColor clearColor];
    self_glkView().context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    viewCenterX = self.view.bounds.size.width/2;
    viewCenterY = self.view.bounds.size.height/2;
    
    self.delegate = self;
    self.preferredFramesPerSecond = 60;

    point = CGPointMake(0.0f, 0.0f);
    
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupGL];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self tearDownGL];
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self_glkView().context];
    effect = [[GLKBaseEffect alloc] init];
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self_glkView().context];
    
    glDeleteBuffers(1, &vertexBuffer);
    glDeleteBuffers(1, &indexBuffer);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [effect prepareToDraw];
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Color));
    
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f);
    effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(point.x, point.y, -4.0f);
    rotation += 1;
    
    if (rotation > 360)
    {
        rotation -= 360;
    }
    
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 0, 1);
    effect.transform.modelviewMatrix = modelViewMatrix;
}

- (void)render:(CADisplayLink*)displayLink
{
    [self_glkView() display];
}

- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
    point = [gestureRecognizer locationInView:self.view];
    
    point = CGPointMake((point.x - viewCenterX)/self.view.bounds.size.width * 5, -((point.y - viewCenterY)/self.view.bounds.size.height) * 5);
    
    //NSLog(@"%f, %f", (point.x - viewCenterX)/self.view.bounds.size.width * 5, -((point.y - viewCenterY)/self.view.bounds.size.height) * 5);
}

@end
