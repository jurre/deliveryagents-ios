//
//  DAGJobPoller.m
//  CareAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGJobPoller.h"
#import "DAGJobService.h"

static const CGFloat DAGJobPollingInterval = 10.0f;

@interface DAGJobPoller ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DAGJobService *jobService;
@property CLLocationCoordinate2D location;

@end

@implementation DAGJobPoller

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
        _jobService = [DAGJobService sharedService];
        _location = location;
    }
    return self;
}

- (void)startPolling {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:DAGJobPollingInterval
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopPolling {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerFired:(NSTimer *)timer {
    [self.jobService fetchMessagesNearLocation:self.location completion:^(NSArray *result) {
        [self.delegate pollerDidFetchNewJobs:result];
    } failure:^(NSError *error) {
        NSLog(@"Error polling for jobs: %@", error);
    }];
}

@end
