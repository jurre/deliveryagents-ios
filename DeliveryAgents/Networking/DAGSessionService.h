//
//  DAGSessionService.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAGBaseService.h"
#import "DAGUser.h"

@interface DAGSessionService : DAGBaseService

@property (nonatomic, strong) DAGUser *currentUser;
@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, copy) NSString *emailAddress;

- (void)signInWithEmail:(NSString *)email
               password:(NSString *)password
             completion:(void (^)(DAGUser *user))completion
                failure:(void (^)(NSError *error))failure;

@end
