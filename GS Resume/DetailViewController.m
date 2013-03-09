//
//  DetailViewController.m
//  GS Resume
//
//  Created by Greg S on 2/19/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "DetailViewController.h"

#import "Constants.h"
#import "PhotoManipulationViewController.h"
#import "CalendarViewController.h"
#import "BinaryClockViewController.h"
#import "VideoRecorderViewController.h"
#import "MapViewController.h"
#import "ConwayViewController.h"
#import "GLKitViewController.h"

@interface DetailViewController () {
    
    UIViewController *selectedViewController;
    __weak IBOutlet UILabel *homeLabel;
    __weak IBOutlet UITextView *homeTextView;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setDetailView:(int)selection
{
    if (selection == NUMBER_OF_ROWS - 1)
    {
        [self showMailerView];
    }
    else
    {
        [selectedViewController.view removeFromSuperview];
        selectedViewController = nil;
        
        switch (selection)
        {
            case 0:
                [self.navigationItem setTitle:@"Home"];
                homeLabel.hidden = NO;
                homeTextView.hidden = NO;
                break;
                
            case 1:
                [self.navigationItem setTitle:@"Photo Manipulation"];
                selectedViewController = [[PhotoManipulationViewController alloc] init];
                break;
                
            case 2:
                [self.navigationItem setTitle:@"Calendar"];
                selectedViewController = [[CalendarViewController alloc] init];
                break;
                
            case 3:
                [self.navigationItem setTitle:@"Binary Clock"];
                selectedViewController = [[BinaryClockViewController alloc] init];
                break;
                
            case 4:
                [self.navigationItem setTitle:@"Video Record"];
                selectedViewController = [[VideoRecorderViewController alloc] init];
                break;
                
            case 5:
                [self.navigationItem setTitle:@"Find Address"];
                selectedViewController = [[MapViewController alloc] init];
                break;
                
            case 6:
                [self.navigationItem setTitle:@"Conway's Game of Life"];
                selectedViewController = [[ConwayViewController alloc] init];
                break;
                
            case 7:
                [self.navigationItem setTitle:@"OpenGL ES"];
                selectedViewController = [[GLKitViewController alloc] init];
                homeLabel.hidden = YES;
                homeTextView.hidden = YES;
                break;
                
            default:
                break;
        }
        
        [self.view addSubview:selectedViewController.view];
    }
}

#pragma mark - Mail view

- (void)showMailerView
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:@[@"gs.dev@hotmail.com"]];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Sent Mail"
                                                        message:@"Your device does not support email or Mail app has not been setup."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			//NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			//NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			//NSLog(@"Mail failed: the email message was log saved or queued, possibly due to an error");
			break;
		default:
			//NSLog(@"Mail not sent");
			break;
	}
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
