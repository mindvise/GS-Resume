//
//  TCSCalendarViewController.h
//  TCSCalendarView
//
//  Created by Greg Shobe on 1/3/13.
//  Copyright (c) 2013 TCS. All rights reserved.
//
//  yearLabel's tag holds the int value of the year
//  monthLabel's tag holds the int value of the month
//  selectedDay is the day selected by the user
//  todayDate is the current/now date in NSDateComponents form
//

#import <UIKit/UIKit.h>


@interface CalendarControlViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    
    short int firstDayOffset;
    NSArray *monthNamesArray;
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

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (strong, nonatomic) NSDateComponents *todayDate;
@property short int selectedDay;

- (id)initWithTarget:(id)target andSelector:(SEL)selector asPopoverContentViewController:(BOOL)isContentViewController;

- (IBAction)previousYearPressed:(UIButton*)sender;
- (IBAction)nextYearPressed:(UIButton*)sender;
- (IBAction)previousMonthPressed:(UIButton*)sender;
- (IBAction)nextMonthPressed:(UIButton*)sender;
- (IBAction)shiftLeft:(UIButton *)sender;
- (IBAction)shiftRight:(UIButton *)sender;
- (void)updateCalendar;


@end
