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

@property (nonatomic, strong) NSNumber *jobId;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *addressName;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, copy) NSString *date;

@end
