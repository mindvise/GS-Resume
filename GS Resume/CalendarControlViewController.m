//
//  TCSCalendarViewController.m
//  TCSCalendarView
//
//  Created by Greg Shobe on 1/3/13.
//  Copyright (c) 2013 TCS. All rights reserved.
//

//Macros for common date formats
//#define dateMMMMDDYYYY() [NSString stringWithFormat:@"%@ %d, %@", self.monthLabel.text, self.selectedDay, self.yearLabel.text]
//#define dateDDMMMMYYYY() [NSString stringWithFormat:@"%d %@, %@", self.selectedDay, self.monthLabel.text, self.yearLabel.text]
#define dateMMDDYYYY() [NSString stringWithFormat:@"%d/%d/%d", self.monthLabel.tag, self.selectedDay, self.yearLabel.tag]
//#define dateDDMMYYYY() [NSString stringWithFormat:@"%d/%d/%d", self.selectedDay, self.monthLabel.tag, self.yearLabel.tag]
//#define dateYYYYMMDD() [NSString stringWithFormat:@"%d%d%d", self.yearLabel.tag, self.monthLabel.tag, self.selectedDay]

#import "CalendarControlViewController.h"

const short int OffsetCalArray[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};

NSString* const monthNamesArray[] = {
    @"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"
};

@interface CalendarControlViewController() {
    
    short int firstDayOffset;
    short int daysInMonth;
    short int calendarSize;
    short int heightChange;
    BOOL isPopoverContentViewController;
    
    UIColor *dayColor;
    UIColor *todayColor;
    UIColor *selectedColor;
    UIColor *nondayColor;
    
    id callbackTarget;
    SEL callbackSelector;
}

@end

@implementation CalendarControlViewController


- (id)init
{
    self = [super init];
    if (self)
    {
        callbackTarget = nil;
        callbackSelector = nil;
        
        isPopoverContentViewController = NO;
    }
    
    return self;
}

//Init passing in a target and selector to send back information (usually selected date). Pass YES for isContentView if using in a UIPopoverController.
- (id)initWithTarget:(id)target andSelector:(SEL)selector asPopoverContentViewController:(BOOL)isContentViewController
{
    self = [super init];
    if (self)
    {
        callbackTarget = target;
        callbackSelector = selector;
        
        isPopoverContentViewController = isContentViewController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Edit these colors to change colors of the calendar.
    dayColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.0];
    todayColor = [UIColor colorWithRed:0.45 green:0.54 blue:0.65 alpha:1.0];
    selectedColor = [UIColor colorWithRed:0.0 green:0.46 blue:0.87 alpha:1.0];
    nondayColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
    
    self.contentSizeForViewInPopover = self.view.frame.size;
    
    //Get day, month, and year of current date.
    self.todayDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                 fromDate:[NSDate date]];
    
    //Calendar loads with current date as default selection.
    self.selectedDay = self.todayDate.day;
    self.monthLabel.tag = self.todayDate.month;
    self.yearLabel.text = [NSString stringWithFormat:@"%d", self.todayDate.year];
    self.yearLabel.tag = self.todayDate.year;
    
    calendarSize = 35;
    
    [self.calendarCollectionView registerNib:[UINib nibWithNibName:@"CalendarCellView" bundle:nil]
                  forCellWithReuseIdentifier:@"CalendarCell"];
    
    [self updateCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return calendarSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    UILabel *cellLabel = (UILabel *)cell.contentView.subviews[0];
    
    //Check if cell will represent a day on the updated calendar grid and set it to appropriate look.
    if (indexPath.row < (daysInMonth + firstDayOffset) && indexPath.row >= firstDayOffset)
    {
        cell.tag = indexPath.row - firstDayOffset + 1;
        cellLabel.text = [NSString stringWithFormat:@"%d", cell.tag];
        cell.userInteractionEnabled = YES;
        
        if (self.selectedDay == cell.tag)
        {
            cell.contentView.backgroundColor = selectedColor;
            cellLabel.textColor = [UIColor whiteColor];
            cellLabel.shadowColor = [UIColor blackColor];
        }
        else
        {
            if (self.todayDate.year == self.yearLabel.tag   &&
                self.todayDate.month == self.monthLabel.tag &&
                self.todayDate.day == cell.tag)
            {
                cell.contentView.backgroundColor = todayColor;
                cellLabel.textColor = [UIColor whiteColor];
                cellLabel.shadowColor = [UIColor blackColor];
            }
            else
            {
                cell.contentView.backgroundColor = dayColor;
                cellLabel.textColor = [UIColor blackColor];
                cellLabel.shadowColor = [UIColor lightGrayColor];
            }
        }
    }
    else
    {
        cellLabel.text = @"";
        cell.userInteractionEnabled = NO;
        cell.contentView.backgroundColor = nondayColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedDay != [collectionView cellForItemAtIndexPath:indexPath].tag)
    {
        short int previousSelectedDay = self.selectedDay;
        self.selectedDay = [collectionView cellForItemAtIndexPath:indexPath].tag;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            [collectionView performBatchUpdates:^{
                
                [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:(self.selectedDay + firstDayOffset - 1) inSection:0], [NSIndexPath indexPathForItem:(previousSelectedDay + firstDayOffset - 1) inSection:0]]];
            
            } completion:^(BOOL finished) {

                [self doCallback];
            }];
        }];
    }
}

#pragma mark - Calendar Controls

- (IBAction)previousYearPressed:(UIButton*)sender
{
    self.yearLabel.text = [NSString stringWithFormat:@"%d", --self.yearLabel.tag];

    [self shiftRight:sender];
    
    [self updateCalendar];
}

- (IBAction)nextYearPressed:(UIButton*)sender
{
    self.yearLabel.text = [NSString stringWithFormat:@"%d", ++self.yearLabel.tag];
    
    [self shiftLeft:sender];
    
    [self updateCalendar];
}

- (IBAction)previousMonthPressed:(UIButton*)sender
{
    if (self.monthLabel.tag == 1)
    {
        self.monthLabel.tag = 12;
        
        self.yearLabel.text = [NSString stringWithFormat:@"%d", --self.yearLabel.tag];
    }
    else
    {
        self.monthLabel.tag--;
    }
    
    [self shiftRight:sender];
    
    [self updateCalendar];
}

- (IBAction)nextMonthPressed:(UIButton*)sender
{
    if (self.monthLabel.tag == 12)
    {
        self.monthLabel.tag = 1;
        
        self.yearLabel.text = [NSString stringWithFormat:@"%d", ++self.yearLabel.tag];
    }
    else
    {
        self.monthLabel.tag++;
    }
    
    [self shiftLeft:sender];
    
    [self updateCalendar];
}

- (IBAction)shiftLeft:(UIButton *)sender
{
    if (sender != nil)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            sender.frame = CGRectMake(sender.frame.origin.x - 5, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
        }];
    }
}

- (IBAction)shiftRight:(UIButton *)sender
{
    if (sender != nil)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            sender.frame = CGRectMake(sender.frame.origin.x + 5, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
        }];
    }
}

#pragma mark - Calendar Update

- (void)updateCalendar
{
    [self calculateFirstDayOffset];
    [self calculateDaysInMonth];
    
    [self adjustCalendarSize];
    
    //If current day selected is greater than the last day in a calendar, adjust it to last day of calendar.
    if (self.selectedDay > daysInMonth)
    {
        self.selectedDay -= self.selectedDay - daysInMonth;
    }

    [self.calendarCollectionView reloadData];
    [self doCallback];
}

//Sets the size of the grid the calendar uses. Also adjusts height if this number increased or decreased.
//Calendar grid size varies between 35 and 42 depending on the number of weeks the days in the month span.
- (void)adjustCalendarSize
{
    short int previousCalendarSize = calendarSize;
    calendarSize = (daysInMonth + firstDayOffset > 35) ? 42 : 35;
    
    if (calendarSize == previousCalendarSize)
    {
        heightChange = 0;
    }
    else if (calendarSize > previousCalendarSize)
    {
        heightChange = +44;
    }
    else
    {
        heightChange = -44;
    }
    
    if (heightChange != 0)
    {
        [UIView animateWithDuration:0.4 animations:^{
            
            if (isPopoverContentViewController)
            {
                CGSize size = self.contentSizeForViewInPopover;
                size.height +=  heightChange;
                self.contentSizeForViewInPopover = size;
            }
            else
            {
                CGRect frameView = self.view.frame;
                frameView.size.height += heightChange;
                self.view.frame = frameView;
                
                //CGRect frameSuperView = self.view.superview.frame;
                //frameSuperView.size.height += heightChange;
                //self.view.superview.frame = frameSuperView;
            }
        }];
    }
}

#pragma mark - Calendar Calculations

//Get the day of the week the first of the month falls on. Sunday is 0. Saturday is 6.
- (void)calculateFirstDayOffset
{
    int x = self.yearLabel.tag - (self.monthLabel.tag < 3);
    firstDayOffset = (x + x/4 - x/100 + x/400 + OffsetCalArray[self.monthLabel.tag-1] + 1) % 7;
}

//Mostly a simple look up. Days in February must be calculated due to leap years.
- (void)calculateDaysInMonth
{
    self.monthLabel.text = monthNamesArray[self.monthLabel.tag - 1];
    
    switch (self.monthLabel.tag)
    {
        case 2:
            if (self.yearLabel.tag % 400 == 0)
            {
                daysInMonth = 29;
            }
            else if (self.yearLabel.tag % 100 == 0)
            {
                daysInMonth = 28;
            }
            else if (self.yearLabel.tag % 4 == 0)
            {
                daysInMonth = 29;
            }
            else
            {
                daysInMonth = 28;
            }
            break;
            
        case 4:
        case 6:
        case 9:
        case 11:
            daysInMonth = 30;
            break;
            
        default:
            daysInMonth = 31;
            break;
    }
}

#pragma mark - Callback

//Edit callback to send desired data to target.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)doCallback
{
    [callbackTarget performSelector:callbackSelector withObject:dateMMDDYYYY()];
}
#pragma clang diagnostic pop

@end
