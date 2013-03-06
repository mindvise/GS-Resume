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

@interface MasterViewController () {
//    NSMutableArray *_objects;
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
    
    cellColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithFame:CGRectMake(0, 0, 320, 44) andColorArray:@[
                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
                                                (id)[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f].CGColor,
                                                (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]]];
    
    highlightColor = [UIColor colorWithPatternImage:[UIImage gradientImageWithFame:CGRectMake(0, 0, 320, 44) andColorArray:@[
                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
                                                     (id)[UIColor colorWithRed:0.55f green:0.65f blue:0.95f alpha:1.0f].CGColor,
                                                     (id)[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor]]];
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row == selectedRow)
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.shadowColor = [UIColor lightGrayColor];
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
            cell.textLabel.text = @"📹 Video Record";
            break;
            
        case 5:
            cell.textLabel.text = @"📌 Find Address";
            break;
        
        case 6:
            cell.textLabel.text = @"👾 Conway's Game of Life";
            break;
            
        case 7:
            cell.textLabel.text = @"📧 Email Developer";
            break;
            
        default:
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
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
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
    if (indexPath.row == 7)
    {
        [self.detailViewController setDetailView:7];
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
