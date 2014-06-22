//
//  DAGSessionService.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGSessionService.h"
#import "DeliveryAgentsAPIClient.h"

static NSString *const DAGAPIEndPointSession = @"sessions";

@implementation DAGSessionService

+ (instancetype)sharedService {
	static DAGSessionService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [DeliveryAgentsAPIClient sharedClient];
	});
	return _sharedService;
}

- (void)signInWithEmail:(NSString *)email
               password:(NSString *)password
             completion:(void (^)(DAGUser *user))completion
                failure:(void (^)(NSError *error))failure {
    NSDictionary *params = @{@"email": email, @"password": password};
    [self.apiClient POST:[self endpoint]
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     DAGUser *user = [self userFromResponse:responseObject];
                     self.currentUser = user;
                     completion(user);
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     failure(error);
                 }];
}

#pragma mark - Private

- (NSString *)endpoint {
    return [self.apiClient.baseURLString stringByAppendingPathComponent:DAGAPIEndPointSession];
}

- (DAGUser *)userFromResponse:(NSDictionary *)response {
    DAGUser *user = [[DAGUser alloc] init];
    user.email = response[@"user"][@"email"];
    return user;
}

@end



