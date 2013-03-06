//
//  PhotoManipulationViewController.m
//  GS Resume
//
//  Created by Greg S on 2/20/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "PhotoManipulationViewController.h"
#import "FilterOptionsTableViewController.h"

@interface PhotoManipulationViewController () {
    
    UIImage *image;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIButton *imageButton;
    __weak IBOutlet UILabel *takePhotoLabel;
    
    UIPopoverController *filterPopover;
}


- (IBAction)takePicturePressed:(UIBarButtonItem *)sender;
- (IBAction)imageButtonPressed:(UIButton *)sender;

@end

@implementation PhotoManipulationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicturePressed:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
    {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        
        camera.delegate = self;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.allowsEditing = YES;
        camera.showsCameraControls = YES;
        
        camera.wantsFullScreenLayout = YES;
        [self presentViewController:camera animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is Not Available" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        alert = nil;
    }
}

- (IBAction)imageButtonPressed:(UIButton *)sender
{
    if (imageView.image != nil)
    {
        FilterOptionsTableViewController *contentViewController = [[FilterOptionsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [contentViewController setCallbackTarget:self withCallbackSelector:@selector(applyFilter:)];
        
        filterPopover = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
        [filterPopover presentPopoverFromRect:imageView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [takePhotoLabel removeFromSuperview];
    takePhotoLabel = nil;
    
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyFilter:(CIFilter*)filter
{
    if (filter == nil)
    {
        imageView.image = image;
    }
    else
    {
        CIImage *ciImage = [CIImage imageWithCGImage:imageView.image.CGImage];
        
        [filter setValue:ciImage forKey:kCIInputImageKey];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CGImageRef cgImage = [context createCGImage:filter.outputImage fromRect:[filter.outputImage extent]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            imageView.image = [UIImage imageWithCGImage:cgImage];
            
            CGImageRelease(cgImage);
        }];
        
        context = nil;
        filter = nil;
    }
}

@end
