//
//  DAGJobAnnotation.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAGJob.h"

@interface DAGJobAnnotation : NSObject <MKAnnotation>

- initWithJob:(DAGJob *)job;

@end
