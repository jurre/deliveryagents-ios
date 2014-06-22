//
//  DAGUser.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGUser : NSObject

@property (nonatomic, copy) NSString *authenticationToken;
@property (nonatomic, copy) NSString *email;

@end
