//
//  DAGJobsViewController.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGJobsViewController.h"
#import "DAGJobService.h"
#import "DAGJob.h"
#import "DAGJobAnnotation.h"
#import "DAGJobTableViewCell.h"

static NSString *const DAGJobCellIdentifier  = @"DAGJobCell";

@interface DAGJobsViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray *jobs;

@end

@implementation DAGJobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.hidesBackButton = YES;

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
    self.mapView.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableHeaderView:self.mapView];
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

# pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations lastObject];
    [self fetchJobsForLocation:self.currentLocation];
    [self zoomToLocation:self.currentLocation radius:1000];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 1500, 1500);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

    [self.locationManager stopUpdatingLocation];

}

- (void)fetchJobsForLocation:(CLLocation *)location {
    [[DAGJobService sharedService] fetchMessagesNearLocation:location.coordinate completion:^(NSArray *result) {
        self.jobs = result;
        [self.tableView reloadData];
        [self addAnnotations];
        NSLog(@"%@", self.jobs);
    } failure:^(NSError *error) {
        NSLog(@"Oh no, you done goofed! %@", error);
    }];
}

- (void)addAnnotations {
    for (DAGJob *job in self.jobs) {
        DAGJobAnnotation *annotation = [[DAGJobAnnotation alloc] initWithJob:job];
        [self.mapView addAnnotation:annotation];
        NSLog(@"Added annotation: lat: %f lon: %f", job.location.latitude, job.location.longitude);
    }
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

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DAGJob *job = self.jobs[indexPath.row];
    DAGJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DAGJobCellIdentifier];
    cell.clientNameLabel.text = job.clientName;
    CLLocationDistance distance = [self.currentLocation distanceFromLocation:[[CLLocation alloc] initWithCoordinate:job.location altitude:0 horizontalAccuracy:0 verticalAccuracy:0 timestamp:nil]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%0.2fkm", distance / 1000];
    cell.dateLabel.text = [self.dateFormatter stringFromDate:job.date];
    return cell;
}

#pragma mark - Private

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    }
    return dateFormatter;
}

@end
