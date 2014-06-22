//
//  DAGApplyViewController.h
//  CareAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DAGJob.h"

@interface DAGApplyViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *clientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UITextView *summaryTextView;

- (IBAction)apply:(id)sender;

@property (nonatomic, strong) DAGJob *job;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@end
