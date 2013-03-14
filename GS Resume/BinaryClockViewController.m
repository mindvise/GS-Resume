//
//  BinaryClockViewController.m
//  GS Resume
//
//  Created by Greg S on 2/26/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "BinaryClockViewController.h"

@interface BinaryClockViewController () {
    
    __weak IBOutlet UILabel *s1dot;
    __weak IBOutlet UILabel *s2dot;
    __weak IBOutlet UILabel *s4dot;
    __weak IBOutlet UILabel *s8dot;
    __weak IBOutlet UILabel *s16dot;
    __weak IBOutlet UILabel *s32dot;
    
    __weak IBOutlet UILabel *m1dot;
    __weak IBOutlet UILabel *m2dot;
    __weak IBOutlet UILabel *m4dot;
    __weak IBOutlet UILabel *m8dot;
    __weak IBOutlet UILabel *m16dot;
    __weak IBOutlet UILabel *m32dot;
    
    __weak IBOutlet UILabel *h1dot;
    __weak IBOutlet UILabel *h2dot;
    __weak IBOutlet UILabel *h4dot;
    __weak IBOutlet UILabel *h8dot;
    __weak IBOutlet UILabel *h16dot;
    
    __weak IBOutlet UILabel *timeOfDayLabel;
    __weak IBOutlet UIView *dotsContainerView;
    
    int seconds;
    int minutes;
    int hours;
    
    NSTimer *timer;
    
    UIColor *litFill;
    UIColor *unlitFill;
    
    BOOL is24Hour;
}


@end

@implementation BinaryClockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    litFill = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueColor.png"]];
    unlitFill = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor.png"]];
    
    timeOfDayLabel.tag = 0;
    
    is24Hour = NO;
    
    h16dot.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startClock12Hour];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self startClock12Hour];
}

- (void)didReceiveMemoryWarning
{
    litFill = nil;
    unlitFill = nil;
    
    [timer invalidate];
    timer = nil;
    
    dotsContainerView = nil;
    
    [super didReceiveMemoryWarning];
}

//get current time from OS
- (void)initTime12Hour
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                                                   fromDate:[NSDate date]];
    
    seconds = components.second;
    minutes = components.minute;
    hours = components.hour;
    
    if (hours == 0)
    {
        hours = 12;
        timeOfDayLabel.text = @"AM";
        timeOfDayLabel.tag = 0;
    }
    else if (hours > 12)
    {
        hours -= 12;
        timeOfDayLabel.text = @"PM";
        timeOfDayLabel.tag = 1;
    }
    else
    {
        timeOfDayLabel.text = @"AM";
        timeOfDayLabel.tag = 0;
    }
}

//adjust time each timer tick
- (void)adjustTime12Hour
{
    [self incrementTime12Hour];
    
    [self lightDots];
}

//increase time by one second
- (void)incrementTime12Hour
{
    if (seconds == 59)
    {
        seconds = 0;
        
        if (minutes == 59)
        {
            minutes = 0;
            
            if (hours == 12)
            {
                hours = 1;
                
                if (timeOfDayLabel.tag == 1)
                {
                    timeOfDayLabel.text = @"AM";
                    timeOfDayLabel.tag = 0;
                }
                else
                {
                    timeOfDayLabel.text = @"PM";
                    timeOfDayLabel.tag = 1;
                }
            }
            else
            {
                hours++;
            }
        }
        else
        {
            minutes++;
        }
    }
    else
    {
        seconds++;
    }
}

//set time when app first loads or becomes active
- (void)setTime12Hour
{
    [self initTime12Hour];
    
    [self lightDots];
}

- (void)lightDots
{
    int secondsCopy = seconds;
    int minutesCopy = minutes;
    int hoursCopy = hours;
    
    //set seconds
    for (int i = 0; i < 6; i++)
    {
        if (secondsCopy & 1)
        {
            switch (i)
            {
                case 0:
                    s1dot.textColor = litFill;
                    break;
                    
                case 1:
                    s2dot.textColor = litFill;
                    break;
                    
                case 2:
                    s4dot.textColor = litFill;
                    break;
                    
                case 3:
                    s8dot.textColor = litFill;
                    break;
                    
                case 4:
                    s16dot.textColor = litFill;
                    break;
                    
                case 5:
                    s32dot.textColor = litFill;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            switch (i)
            {
                case 0:
                    s1dot.textColor = unlitFill;
                    break;
                    
                case 1:
                    s2dot.textColor = unlitFill;
                    break;
                    
                case 2:
                    s4dot.textColor = unlitFill;
                    break;
                    
                case 3:
                    s8dot.textColor = unlitFill;
                    break;
                    
                case 4:
                    s16dot.textColor = unlitFill;
                    break;
                    
                case 5:
                    s32dot.textColor = unlitFill;
                    break;
                    
                default:
                    break;
            }
        }
        secondsCopy >>= 1;
    }
    
    //set minutes
    for (int i = 0; i < 6; i++)
    {
        if (minutesCopy & 1)
        {
            switch (i)
            {
                case 0:
                    m1dot.textColor = litFill;
                    break;
                    
                case 1:
                    m2dot.textColor = litFill;
                    break;
                    
                case 2:
                    m4dot.textColor = litFill;
                    break;
                    
                case 3:
                    m8dot.textColor = litFill;
                    break;
                    
                case 4:
                    m16dot.textColor = litFill;
                    break;
                    
                case 5:
                    m32dot.textColor = litFill;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            switch (i)
            {
                case 0:
                    m1dot.textColor = unlitFill;
                    break;
                    
                case 1:
                    m2dot.textColor = unlitFill;
                    break;
                    
                case 2:
                    m4dot.textColor = unlitFill;
                    break;
                    
                case 3:
                    m8dot.textColor = unlitFill;
                    break;
                    
                case 4:
                    m16dot.textColor = unlitFill;
                    break;
                    
                case 5:
                    m32dot.textColor = unlitFill;
                    break;
                    
                default:
                    break;
            }
        }
        
        minutesCopy >>= 1;
    }
    
    //set hours
    for (int i = 0; i < 4; i++)
    {
        if (hoursCopy & 1)
        {
            switch (i)
            {
                case 0:
                    h1dot.textColor = litFill;
                    break;
                    
                case 1:
                    h2dot.textColor = litFill;
                    break;
                    
                case 2:
                    h4dot.textColor = litFill;
                    break;
                    
                case 3:
                    h8dot.textColor = litFill;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            switch (i)
            {
                case 0:
                    h1dot.textColor = unlitFill;
                    break;
                    
                case 1:
                    h2dot.textColor = unlitFill;
                    break;
                    
                case 2:
                    h4dot.textColor = unlitFill;
                    break;
                    
                case 3:
                    h8dot.textColor = unlitFill;
                    break;
                    
                default:
                    break;
            }
        }
        hoursCopy >>= 1;
    }
}

- (void)startClock12Hour
{
    [self setTime12Hour];
    
    timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(adjustTime12Hour) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)stopClock12Hour
{
    [timer invalidate];
    timer = nil;
}

@end
