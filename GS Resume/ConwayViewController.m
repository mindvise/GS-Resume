//
//  ConwayViewController.m
//  GS Resume
//
//  Created by Greg S on 2/19/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "ConwayViewController.h"

#import "ConwayInfoModalViewController.h"

@interface ConwayViewController () {
    
    __weak IBOutlet UICollectionView *lifeGridCollectionView;
    
    short lifeArray [14][13];
    short lifeArrayForCalc [14][13];
    
    NSTimer *lifeTimer;
    __weak IBOutlet UIBarButtonItem *clearBarButton;
    __weak IBOutlet UIBarButtonItem *generationBarButton;
}

@end

@implementation ConwayViewController

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
    
    [lifeGridCollectionView registerNib:[UINib nibWithNibName:@"CellView" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 13;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *cellLabel = cell.contentView.subviews[0];
    
    if (lifeArray[indexPath.row][indexPath.section] == 0)
    {
        cellLabel.text = @"";
    }
    else
    {
        cellLabel.text = @"👾";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (lifeArray[indexPath.row][indexPath.section] == 0)
    {
        lifeArray[indexPath.row][indexPath.section] = 1;
    }
    else
    {
        lifeArray[indexPath.row][indexPath.section] = 0;
    }
    
    generationBarButton.tag = 0;
    generationBarButton.title = @"Generation: 0";
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - Game of Life Calculation

- (void)calculateNextGeneration
{
    for (int y = 0; y < 13; y++)
    {
        for (int x = 0; x < 14; x++)
        {
            short numberLivingAroundCell = 0;
            
            if (y == 0)
            {
                if (x == 0)
                {
                    numberLivingAroundCell += lifeArray[13][12];
                    numberLivingAroundCell += lifeArray[0][12];
                    numberLivingAroundCell += lifeArray[1][12];
                    
                    numberLivingAroundCell += lifeArray[13][0];
                    numberLivingAroundCell += lifeArray[1][0];
                    
                    numberLivingAroundCell += lifeArray[13][1];
                    numberLivingAroundCell += lifeArray[0][1];
                    numberLivingAroundCell += lifeArray[1][1];
                }
                else if (x == 13)
                {
                    numberLivingAroundCell += lifeArray[12][12];
                    numberLivingAroundCell += lifeArray[13][12];
                    numberLivingAroundCell += lifeArray[0][12];
                    
                    numberLivingAroundCell += lifeArray[12][0];
                    numberLivingAroundCell += lifeArray[0][0];
                    
                    numberLivingAroundCell += lifeArray[12][1];
                    numberLivingAroundCell += lifeArray[13][1];
                    numberLivingAroundCell += lifeArray[0][1];
                }
                else
                {
                    numberLivingAroundCell += lifeArray[x-1][12];
                    numberLivingAroundCell += lifeArray[x][12];
                    numberLivingAroundCell += lifeArray[x+1][12];
                    
                    numberLivingAroundCell += lifeArray[x-1][0];
                    numberLivingAroundCell += lifeArray[x+1][0];
                    
                    numberLivingAroundCell += lifeArray[x-1][1];
                    numberLivingAroundCell += lifeArray[x][1];
                    numberLivingAroundCell += lifeArray[x+1][1];
                }
            }
            else if (y == 12)
            {
                if (x == 0)
                {
                    numberLivingAroundCell += lifeArray[13][11];
                    numberLivingAroundCell += lifeArray[0][11];
                    numberLivingAroundCell += lifeArray[1][11];
                    
                    numberLivingAroundCell += lifeArray[13][12];
                    numberLivingAroundCell += lifeArray[1][12];
                    
                    numberLivingAroundCell += lifeArray[13][0];
                    numberLivingAroundCell += lifeArray[0][0];
                    numberLivingAroundCell += lifeArray[1][0];
                }
                else if (x == 13)
                {
                    numberLivingAroundCell += lifeArray[12][11];
                    numberLivingAroundCell += lifeArray[13][11];
                    numberLivingAroundCell += lifeArray[0][11];
                    
                    numberLivingAroundCell += lifeArray[12][12];
                    numberLivingAroundCell += lifeArray[0][12];
                    
                    numberLivingAroundCell += lifeArray[12][0];
                    numberLivingAroundCell += lifeArray[13][0];
                    numberLivingAroundCell += lifeArray[0][0];
                }
                else
                {
                    numberLivingAroundCell += lifeArray[x-1][11];
                    numberLivingAroundCell += lifeArray[x][11];
                    numberLivingAroundCell += lifeArray[x+1][11];
                    
                    numberLivingAroundCell += lifeArray[x-1][12];
                    numberLivingAroundCell += lifeArray[x+1][12];
                    
                    numberLivingAroundCell += lifeArray[x-1][0];
                    numberLivingAroundCell += lifeArray[x][0];
                    numberLivingAroundCell += lifeArray[x+1][0];
                }
            }
            else if (x == 0)
            {
                numberLivingAroundCell += lifeArray[13][y-1];
                numberLivingAroundCell += lifeArray[x][y-1];
                numberLivingAroundCell += lifeArray[x+1][y-1];
                
                numberLivingAroundCell += lifeArray[13][y];
                numberLivingAroundCell += lifeArray[x+1][y];
                
                numberLivingAroundCell += lifeArray[13][y+1];
                numberLivingAroundCell += lifeArray[x][y+1];
                numberLivingAroundCell += lifeArray[x+1][y+1];
            }
            else if (x == 13)
            {
                numberLivingAroundCell += lifeArray[x-1][y-1];
                numberLivingAroundCell += lifeArray[x][y-1];
                numberLivingAroundCell += lifeArray[0][y-1];
                
                numberLivingAroundCell += lifeArray[x-1][y];
                numberLivingAroundCell += lifeArray[0][y];
                
                numberLivingAroundCell += lifeArray[x-1][y+1];
                numberLivingAroundCell += lifeArray[x][y+1];
                numberLivingAroundCell += lifeArray[0][y+1];
            }
            else
            {
                numberLivingAroundCell += lifeArray[x-1][y-1];
                numberLivingAroundCell += lifeArray[x][y-1];
                numberLivingAroundCell += lifeArray[x+1][y-1];
                
                numberLivingAroundCell += lifeArray[x-1][y];
                numberLivingAroundCell += lifeArray[x+1][y];
                
                numberLivingAroundCell += lifeArray[x-1][y+1];
                numberLivingAroundCell += lifeArray[x][y+1];
                numberLivingAroundCell += lifeArray[x+1][y+1];
            }
            
            if (numberLivingAroundCell == 3)
            {
                lifeArrayForCalc[x][y] = 1;
            }
            else if (numberLivingAroundCell == 2 && lifeArray[x][y] == 1)
            {
                lifeArrayForCalc[x][y] = 1;
            }
            else
            {
                lifeArrayForCalc[x][y] = 0;
            }
        }
    }
    
    for (int y = 0; y < 13; y++)
    {
        for (int x = 0; x < 14; x++)
        {
            lifeArray[x][y] = lifeArrayForCalc[x][y];
        }
    }
    
    generationBarButton.tag++;
    generationBarButton.title = [NSString stringWithFormat:@"Generation: %d", generationBarButton.tag];
    
    [lifeGridCollectionView reloadData];
}

#pragma mark - Game of Life Controls

- (IBAction)clearPressed:(UIBarButtonItem *)sender
{
    for (int y = 0; y < 13; y++)
    {
        for (int x = 0; x < 14; x++)
        {
            lifeArray[x][y] = 0;
        }
    }
    
    generationBarButton.tag = 0;
    generationBarButton.title = @"Generation: 0";
    
    [lifeGridCollectionView reloadData];
}

- (IBAction)startStopPressed:(UIBarButtonItem *)sender
{
    if (sender.tag == 0)
    {
        lifeGridCollectionView.userInteractionEnabled = NO;
        
        sender.title = @"Stop";
        sender.tag = 1;
        
        clearBarButton.enabled = NO;
        
        lifeTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(calculateNextGeneration) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:lifeTimer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [lifeTimer invalidate];
        lifeTimer = nil;
        
        sender.title = @"Start";
        sender.tag = 0;
        
        clearBarButton.enabled = YES;
        
        lifeGridCollectionView.userInteractionEnabled = YES;
    }
}

- (IBAction)rulesButtonPressed:(UIBarButtonItem *)sender
{
    ConwayInfoModalViewController *rulesView = [[ConwayInfoModalViewController alloc] init];
    
    rulesView.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:rulesView animated:YES completion:nil];
    
    rulesView = nil;
}

@end
