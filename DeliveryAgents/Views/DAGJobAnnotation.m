//
//  DAGJobAnnotation.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGJobAnnotation.h"

@interface DAGJobAnnotation()

@property (nonatomic, strong) DAGJob *job;

@end

@implementation DAGJobAnnotation

- initWithJob:(DAGJob *)job {
    self = [super init];
    if (self) {
        self.job = job;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return self.job.location;
}

- (NSString *)title {
    return self.job.clientName;
}


@end
