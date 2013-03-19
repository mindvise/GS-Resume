//
//  MasterViewController.m
//  GS Resume
//
//  Created by Greg S on 2/19/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "UIImage+GradientImage.h"
#import "Constants.h"

@interface MasterViewController () {
    
    UIColor *cellColor;
    UIColor *highlightColor;
    int selectedRow;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedRow = 0;
    
//    cellColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithFame:CGRectMake(0, 0, 320, 44) andColorArray:@[
//                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
//                                                (id)[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f].CGColor,
//                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]]];
    
//    highlightColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithFame:CGRectMake(0, 0, 320, 44) andColorArray:@[
//                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
//                                                     (id)[UIColor colorWithRed:0.55f green:0.65f blue:0.95f alpha:1.0f].CGColor,
//                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]]];
    
    CGFloat locations[4];
    locations[0] = 0.0f;
    locations[1] = 0.3f;
    locations[2] = 0.4f;
    locations[3] = 0.97f;
    
    cellColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithSize:CGSizeMake(320, 44)
                                                                     andColorArray:@[
                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
                                                (id)[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f].CGColor,
                                                (id)[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f].CGColor,
                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]
                                                                withColorLocations:locations]];
    
    highlightColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithSize:CGSizeMake(320, 44)
                                                                     andColorArray:@[
                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,                                                 
                                                     (id)[UIColor colorWithRed:0.6f green:0.7f blue:1.0f alpha:1.0f].CGColor,
                                                     (id)[UIColor colorWithRed:0.5f green:0.6f blue:0.9f alpha:1.0f].CGColor,
                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]
                                                                withColorLocations:locations]];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row == selectedRow)
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.shadowColor = [UIColor clearColor];
        cell.contentView.backgroundColor = highlightColor;
    }
    else
    {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.contentView.backgroundColor = cellColor;
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"🏡 Home";
            break;
            
        case 1:
            cell.textLabel.text = @"📷 Photo Manipulation";
            break;
            
        case 2:
            cell.textLabel.text = @"📅 Calendar";
            break;
            
        case 3:
            cell.textLabel.text = @"⌚ Binary Clock";
            break;
            
        case 4:
            cell.textLabel.text = @"📹 Record Video";
            break;
            
        case 5:
            cell.textLabel.text = @"📌 Find Address";
            break;
        
        case 6:
            cell.textLabel.text = @"👾 Conway's Game of Life";
            break;
            
        case 7:
            cell.textLabel.text = @"💻 OpenGL ES";
            break;
            
        default:
            cell.textLabel.text = @"📧 Email Developer";
            break;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == NUMBER_OF_ROWS - 1)
    {
        [self.detailViewController setDetailView:NUMBER_OF_ROWS - 1];
    }
    else
    {
        if (indexPath.row != selectedRow)
        {
            int previousSelectedRow = selectedRow;
            selectedRow = indexPath.row;
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            if (previousSelectedRow > -1)
            {
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:previousSelectedRow inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [self.detailViewController setDetailView:selectedRow];
        }
    }
}

@end
