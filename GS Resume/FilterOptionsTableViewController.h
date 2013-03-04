//
//  FilterOptionsTableViewController.h
//  GS Resume
//
//  Created by Greg S on 2/26/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterOptionsTableViewController : UITableViewController

- (void)setCallbackTarget:(id)target withCallbackSelector:(SEL)selector;

@end
