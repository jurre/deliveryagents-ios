//
//  DAGJob.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGBaseService.h"
#import <MapKit/MapKit.h>

@interface DAGJob : DAGBaseService

@property (nonatomic, strong) NSString *clientName;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSDate *date;

@end
