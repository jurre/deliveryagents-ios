//
//  DAGJobPoller.h
//  CareAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAGJob.h"

@protocol DAGJobPollerDelegate <NSObject>

@required
- (void)pollerDidFetchNewJobs:(NSArray *)newJobs;

@end

@interface DAGJobPoller : NSObject

@property (nonatomic, weak) id<DAGJobPollerDelegate> delegate;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location;

- (void)startPolling;
- (void)stopPolling;

@end