//
//  DAGJobService.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGBaseService.h"
#import <MapKit/MapKit.h>

static NSString *const DAGApiEndpointJobs = @"jobs";

@interface DAGJobService : DAGBaseService

- (void)fetchMessagesNearLocation:(CLLocationCoordinate2D)location
                       completion:(void (^)(NSArray *result))completion
                          failure:(void (^)(NSError *error))failure;

@end
