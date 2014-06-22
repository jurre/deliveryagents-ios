//
//  DAGJobService.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGJobService.h"
#import "DAGJob.h"

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
    job.clientName = dictionary[@"client"][@"name"];
    job.location = CLLocationCoordinate2DMake([dictionary[@"location"][@"lat"] doubleValue], [dictionary[@"location"][@"lon"] doubleValue]);
    job.date = [self dateFromISO8601String:dictionary[@"date"]];
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
