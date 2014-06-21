//
//  DAGBaseService.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGBaseService.h"

@implementation DAGBaseService


+ (instancetype)sharedService {
    [NSException raise:@"Implement in subclass" format:@"This method should be implemented by subclasses only"];
    return nil;
}

@end
