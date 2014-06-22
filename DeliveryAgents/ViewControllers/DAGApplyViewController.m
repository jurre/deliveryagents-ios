//
//  DAGApplyViewController.m
//  CareAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGApplyViewController.h"
#import "DAGJobAnnotation.h"
#import "DAGJobService.h"
#import "CRToast.h"

@interface DAGApplyViewController ()

@end

@implementation DAGApplyViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;
    [self updateLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    self.locationManager = nil;
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)removeAllAnnotations {
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
}

- (void)setJobDetails {
    self.clientNameLabel.text = self.job.clientName;
    self.addressNameLabel.text = self.job.addressName;
    CLLocationDistance distance = [self.currentLocation distanceFromLocation:[[CLLocation alloc] initWithCoordinate:self.job.location altitude:0 horizontalAccuracy:0 verticalAccuracy:0 timestamp:nil]];
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2fkm", distance / 1000];
    self.summaryTextView.text = self.job.summary;
    self.dateLabel.text = self.job.date;
}

- (IBAction)apply:(id)sender {
    [[DAGJobService sharedService] applyForJob:self.job completion:^{
        [CRToastManager showNotificationWithOptions:@{kCRToastTextKey : @"Successfully applied!",
                                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                                      kCRToastBackgroundColorKey : [UIColor colorWithRed:0.539 green:0.866 blue:0.397 alpha:1.000]} completionBlock:nil];
    } failure:^(NSError *error) {
        [CRToastManager showNotificationWithOptions:@{kCRToastTextKey : @"Something went wrong :( Please try again.",
                                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                                      kCRToastBackgroundColorKey : [UIColor colorWithRed:0.866 green:0.232 blue:0.213 alpha:1.000]} completionBlock:nil];
    }];
}

# pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations lastObject];
    [self addAnnotation];
    [self setJobDetails];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 1500, 1500);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

    [self.locationManager stopUpdatingLocation];

}

- (void)addAnnotation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.job.location.latitude longitude:self.job.location.longitude];
    [self zoomToLocation:location radius:1000];
    DAGJobAnnotation *annotation = [[DAGJobAnnotation alloc] initWithJob:self.job];
    [self.mapView addAnnotation:annotation];
}

# pragma mark - MKMapView Delegate

- (void)zoomToLocation:(CLLocation *)location radius:(CGFloat)radius {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius * 2, radius * 2);
    [self.mapView setRegion:region animated:YES];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

@end
