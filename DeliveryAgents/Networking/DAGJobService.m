//
//  DAGJobService.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGJobService.h"
#import "DAGJob.h"
#import "DAGSessionService.h"

@implementation DAGJobService

+ (instancetype)sharedService {
	static DAGJobService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [DeliveryAgentsAPIClient sharedClient];
	});
	return _sharedService;
}

- (void)fetchMessagesNearLocation:(CLLocationCoordinate2D)location
                       completion:(void (^)(NSArray *))completion
                          failure:(void (^)(NSError *))failure {
    NSDictionary *params = @{ @"lat" : @(location.latitude), @"long": @(location.longitude) };
    NSLog(@"Fetching messages for location: %f, %f", location.latitude, location.longitude);
    [self.apiClient GET:self.endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion([self jobsFromResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)applyForJob:(DAGJob *)job completion:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    NSDictionary *params = @{
        @"email" : [[DAGSessionService sharedService] currentUser].email,
        @"job_id" : job.jobId
    };

    [self.apiClient POST:self.endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

#pragma mark - Private

- (NSString *)endpoint {
    return [self.apiClient.baseURLString stringByAppendingPathComponent:DAGApiEndpointJobs];
}

- (NSArray *)jobsFromResponse:(id)response {
    NSArray *jobDictionaries = response[@"jobs"];
    NSMutableArray *jobs = [[NSMutableArray alloc] initWithCapacity:jobDictionaries.count];
    for (NSDictionary *jobDictionary in jobDictionaries) {
        [jobs addObject:[self jobFromDictionary:jobDictionary]];
    }
    return [jobs copy];
}

- (DAGJob *)jobFromDictionary:(NSDictionary *)dictionary {
    DAGJob *job = [[DAGJob alloc] init];
    job.jobId = dictionary[@"id"];
    job.clientName = dictionary[@"client_name"];
    job.location = CLLocationCoordinate2DMake([dictionary[@"lat"] doubleValue], [dictionary[@"lon"] doubleValue]);
    job.date = [self dateFromISO8601String:dictionary[@"date"]];
    job.addressName = dictionary[@"address_name"];
    job.summary = dictionary[@"description"];
    return job;
}

- (NSDate *)dateFromISO8601String:(NSString *)dateString {

    NSDate *dateFromString = [[self dateFormatter] dateFromString:dateString];
    return dateFromString;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }
    return dateFormatter;
}

@end
