//
//  CalendarViewController.m
//  GS Resume
//
//  Created by Greg S on 2/20/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "CalendarViewController.h"

#import "CalendarControlViewController.h"

@interface CalendarViewController () {
    
    __weak IBOutlet UILabel *dateSelectedLabel;
    CalendarControlViewController *calendar;
}

- (IBAction)dateValueChanged:(UIDatePicker *)sender;

@end

@implementation CalendarViewController

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
    
    calendar = [[CalendarControlViewController alloc] initWithTarget:self andSelector:@selector(calendarControlDateSelected:) asPopoverContentViewController:NO];
    
    CGRect frame = calendar.view.frame;
    frame.origin.x = 363;
    frame.origin.y = 155;
    calendar.view.frame = frame;
    
    [self.view addSubview:calendar.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calendarControlDateSelected:(NSString*)selectedDate
{
    dateSelectedLabel.text = selectedDate;
}

- (IBAction)dateValueChanged:(UIDatePicker *)sender
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit) fromDate:sender.date];
    
    dateSelectedLabel.text = [NSString stringWithFormat:@"%d/%d/%d", components.month, components.day, components.year];
}
@end
