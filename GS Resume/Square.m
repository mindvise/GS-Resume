//
//  Square.m
//  GS Resume
//
//  Created by Greg S on 3/11/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "Square.h"

typedef struct {
    CGFloat position[3];
    CGFloat color[4];
} Vertex;

@interface  Square() {
    
    Vertex vertices[4];
    GLubyte indices[6];
    GLuint vertexBuffer;
    GLuint indexBuffer;
    GLKBaseEffect *effect;
}

@end

@implementation Square

- (id)init
{
    self = [super init];
    if (self)
    {
        vertices[0].position[0] =  1;  vertices[1].position[0] = 1;  vertices[2].position[0] = -1;  vertices[3].position[0] = -1;
        vertices[0].position[1] = -1;  vertices[1].position[1] = 1;  vertices[2].position[1] =  1;  vertices[3].position[1] = -1;
        vertices[0].position[2] =  0;  vertices[1].position[2] = 0;  vertices[2].position[2] =  0;  vertices[3].position[2] =  0;
        
        vertices[0].color[0] = 1;      vertices[1].color[0] = 0;     vertices[2].color[0] = 0;      vertices[3].color[0] = 1;
        vertices[0].color[1] = 0;      vertices[1].color[1] = 0;     vertices[2].color[1] = 1;      vertices[3].color[1] = 1;
        vertices[0].color[2] = 0;      vertices[1].color[2] = 1;     vertices[2].color[2] = 0;      vertices[3].color[2] = 0;
        vertices[0].color[3] = 1;      vertices[1].color[3] = 1;     vertices[2].color[3] = 1;      vertices[3].color[3] = 1;
        
        indices[0] = 0;  indices[1] = 1;  indices[2] = 2;
        indices[3] = 2;  indices[4] = 3;  indices[5] = 0;
        
        _point = CGPointMake(0.0f, 0.0f);
        _rotation = 0.0f;
        _scale = 1.0f;
        
        effect = [[GLKBaseEffect alloc] init];
    }
    
    return self;
}

- (void)createBuffers
{
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}

- (void)deleteBuffers
{
    glDeleteBuffers(1, &vertexBuffer);
    glDeleteBuffers(1, &indexBuffer);
}

- (void)drawSquareWithView:(GLKView *)view inRect:(CGRect)rect
{
    [effect prepareToDraw];
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, color));
    
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, 0);
}

- (void)updateSquareModelWithAspectRatio:(float)aspect
{
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f);
    effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(self.point.x, self.point.y, -4.0f);
    
    if (self.rotation > 360)
    {
        self.rotation -= 360;
    }
    else if (self.rotation < -360)
    {
        self.rotation += 360;
    }
    
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(self.rotation), 0.0f, 0.0f, 1.0f);
    
    if (self.scale < 0.5f)
    {
        self.scale = 0.5f;
    }
    else if (self.scale > 2.0f)
    {
        self.scale = 2.0f;
    }
    
    modelViewMatrix = GLKMatrix4Scale(modelViewMatrix, self.scale, self.scale, 0.0f);
    
    effect.transform.modelviewMatrix = modelViewMatrix;
}

@end
