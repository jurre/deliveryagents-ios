//
//  DAGBaseService.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryAgentsAPIClient.h"

@interface DAGBaseService : NSObject

@property (nonatomic, strong)  DeliveryAgentsAPIClient *apiClient;

+ (instancetype)sharedService;

@end
