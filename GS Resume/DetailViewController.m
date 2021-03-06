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

    __weak IBOutlet UILabel *homeLabel;
    __weak IBOutlet UITextView *homeTextView;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
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
        if (self.navigationController.viewControllers.count > 1)
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
        
        switch (selection)
        {
            case 1:
                [self.navigationController pushViewController:[[PhotoManipulationViewController alloc] init] animated:NO];
                break;
                
            case 2:
                [self.navigationController pushViewController:[[CalendarViewController alloc] init] animated:NO];
                break;
                
            case 3:
                [self.navigationController pushViewController:[[BinaryClockViewController alloc] init] animated:NO];
                break;
                
            case 4:
                [self.navigationController pushViewController:[[VideoRecorderViewController alloc] init] animated:NO];
                break;
                
            case 5:
                [self.navigationController pushViewController:[[MapViewController alloc] init] animated:NO];
                break;
                
            case 6:
                [self.navigationController pushViewController:[[ConwayViewController alloc] init] animated:NO];
                break;
                
            case 7:
                [self.navigationController pushViewController:[[GLKitViewController alloc] init] animated:NO];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Mail view

- (void)showMailerView
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:@[@"gs.dev@outlook.com"]];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Send Mail"
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
