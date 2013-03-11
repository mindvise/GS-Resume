//
//  MapViewController.m
//  GS Resume
//
//  Created by Greg S on 3/1/13.
//  Copyright (c) 2013 Shobe. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () {
    
    __weak IBOutlet UITextField *addressField;
    __weak IBOutlet MKMapView *mapView;
}

@end

@interface MapAnnotation : NSObject <MKAnnotation> 

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;

@end

@implementation MapAnnotation

@end

@implementation MapViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)searchButtonPressed:(UIBarButtonItem *)sender
{
    [addressField resignFirstResponder];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressField.text
     
    completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil)
        {
            if (mapView.annotations.count > 0)
            {
                [mapView removeAnnotation:mapView.annotations[0]];
            }
            
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta=0.1;
            span.longitudeDelta=0.1;
            region.span = span;
            
            MapAnnotation *annotation = [[MapAnnotation alloc] init];
            CLPlacemark *placemark = placemarks[0];
            annotation.coordinate = placemark.location.coordinate;
            
            if (placemark.areasOfInterest.count > 0)
            {
                annotation.title = placemark.areasOfInterest[0];
            }
            else
            {
                annotation.title = @"Searched Address";
            }
            
            annotation.subtitle = [NSString stringWithFormat:@"%@, %@, %@ %@", placemark.addressDictionary[@"Street"],
                                                                               placemark.addressDictionary[@"City"],
                                                                               placemark.addressDictionary[@"State"],
                                                                               placemark.addressDictionary[@"ZIP"]];
            
            region.center = annotation.coordinate;
            
            [mapView addAnnotation:annotation];
            [mapView setRegion:region animated:TRUE];
            [mapView regionThatFits:region];
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable To Find Address" message:@"Please check the address and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            alert = nil;
        }
    }];
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    
}

@end
