//
//  OpenGLViewController.m
//  GS Resume
//
//  Created by Greg S on 3/14/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "OpenGLViewController.h"

#import "GLKitViewController.h"

@interface OpenGLViewController () {
    
    GLKitViewController *glKitViewController;
}

@end

@implementation OpenGLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    glKitViewController = [[GLKitViewController alloc] init];
    
    [self.view addSubview:glKitViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cleanUpContext
{
    [glKitViewController cleanUpContext];
}

@end
