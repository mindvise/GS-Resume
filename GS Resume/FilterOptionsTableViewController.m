//
//  FilterOptionsTableViewController.m
//  GS Resume
//
//  Created by Greg S on 2/26/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "FilterOptionsTableViewController.h"

@interface FilterOptionsTableViewController () {
    
    __weak id callbackTarget;
    SEL callbackSelector;
}

@end

@implementation FilterOptionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.contentSizeForViewInPopover = self.view.frame.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Image Filters";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Sepia";
            break;
            
        case 1:
            cell.textLabel.text = @"Vignette";
            break;
            
        case 2:
            cell.textLabel.text = @"Invert Colors";
            break;
            
        case 3:
            cell.textLabel.text = @"Posterize";
            break;
            
        case 4:
            cell.textLabel.text = @"Gloom";
            break;
            
        case 5:
            cell.textLabel.text = @"Gaussian Blur";
            break;
            
        case 6:
            cell.textLabel.text = @"Alter Perspective";
            break;
            
        case 7:
            cell.textLabel.text = @"Pixellate";
            break;
            
        case 8:
            cell.textLabel.text = @"White Point Adjust";
            break;
            
        case 9:
            cell.textLabel.text = @"Reset Image";
            break;
            
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CIFilter *filter;
    
    switch (indexPath.row)
    {
        case 0:
            filter = [CIFilter filterWithName:@"CISepiaTone"];
            [filter setDefaults];
            break;
        
        case 1:
            filter = [CIFilter filterWithName:@"CIVignette" keysAndValues:@"inputRadius", [NSNumber numberWithFloat:0.5],
                                                                          @"inputIntensity", [NSNumber numberWithFloat:1.0], nil];
            break;
            
        case 2:
            filter = [CIFilter filterWithName:@"CIColorInvert" keysAndValues:nil];
            break;
            
        case 3:
            filter = [CIFilter filterWithName:@"CIColorPosterize"];
            [filter setDefaults];
            break;
            
        case 4:
            filter = [CIFilter filterWithName:@"CIGloom" keysAndValues:@"inputRadius", [NSNumber numberWithFloat:5.0],
                                                                       @"inputIntensity", [NSNumber numberWithFloat:1.0], nil];
            break;
            
        case 5:
            filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputRadius", [NSNumber numberWithFloat:4.0], nil];
            break;
            
        case 6:
            filter = [CIFilter filterWithName:@"CIPerspectiveTransform" keysAndValues:@"inputTopLeft", [CIVector vectorWithX:40 Y:445],
                                                                                      @"inputTopRight", [CIVector vectorWithX:500 Y:500],
                                                                                      @"inputBottomRight", [CIVector vectorWithX:550 Y:40],
                                                                                      @"inputBottomLeft", [CIVector vectorWithX:30 Y:30], nil];
            break;
            
        case 7:
            filter = [CIFilter filterWithName:@"CIPixellate" keysAndValues:@"inputScale", [NSNumber numberWithFloat:8.0],
                                                                           @"inputCenter", [CIVector vectorWithX:292 Y:310], nil];
            break;
            
        case 8:
            filter = [CIFilter filterWithName:@"CIWhitePointAdjust" keysAndValues:@"inputColor", [CIColor colorWithRed:1.0 green:0.7 blue:0.7], nil];
            break;
            
        case 9:
            filter = nil;
            break;
        
        default:
            break;
    }
    
    [[[NSThread alloc] initWithTarget:callbackTarget selector:callbackSelector object:filter] start];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Set Callback

- (void)setCallbackTarget:(id)target withCallbackSelector:(SEL)selector
{
    callbackTarget = target;
    callbackSelector = selector;
}

@end
