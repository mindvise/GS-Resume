//
//  ConwayInfoModalViewController.m
//  GS Resume
//
//  Created by Greg S on 2/27/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "ConwayInfoModalViewController.h"

@interface ConwayInfoModalViewController ()

@end

@implementation ConwayInfoModalViewController

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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
