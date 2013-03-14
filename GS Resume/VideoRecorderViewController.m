//
//  VideoRecorderViewController.m
//  GS Resume
//
//  Created by Gregory Shobe on 3/5/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "VideoRecorderViewController.h"

@interface VideoRecorderViewController () {
    
    MPMoviePlayerController *moviePlayer;
    __weak IBOutlet UIView *videoContainerView;
    __weak IBOutlet UILabel *recordVideoLabel;
}

@end

@implementation VideoRecorderViewController

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
    
    moviePlayer = [[MPMoviePlayerController alloc] init];
    moviePlayer.view.backgroundColor = [UIColor clearColor];
    moviePlayer.shouldAutoplay = NO;
    moviePlayer.view.frame = CGRectMake(0, 86, 703, 502);
    [self.view addSubview:moviePlayer.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordStopPressed:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        camera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        
        camera.allowsEditing = NO;
        camera.delegate = self;
        
        [self presentViewController:camera animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Available" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        alert = nil;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    __weak VideoRecorderViewController *selfRef = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
        {
            NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
            
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
            {
                UISaveVideoAtPathToSavedPhotosAlbum(moviePath, selfRef, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }];
}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Could Not Be Saved" message:@""
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    else
    {
        recordVideoLabel.hidden = YES;
        
        moviePlayer.view.backgroundColor = [UIColor blackColor];
        moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        moviePlayer.contentURL = [[NSURL alloc] initFileURLWithPath:videoPath];
        
        [moviePlayer prepareToPlay];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved Video To Camera Roll" message:@""
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
}

@end
