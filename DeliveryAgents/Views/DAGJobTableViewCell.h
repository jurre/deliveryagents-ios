//
//  DAGJobTableViewCell.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 22/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAGJobTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *clientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;

@end
