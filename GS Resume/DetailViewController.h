//
//  DetailViewController.h
//  GS Resume
//
//  Created by Greg S on 2/19/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
