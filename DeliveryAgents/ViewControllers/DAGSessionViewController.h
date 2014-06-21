//
//  DAGSessionViewController.h
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryAgentsAPIClient.h"
#import "DAGSessionService.h"

@interface DAGSessionViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;

@property (nonatomic, strong) DeliveryAgentsAPIClient *apiClient;
@property (nonatomic, strong) DAGSessionService *sessionService;

- (IBAction)signInButtonTapped:(id)sender;

- (IBAction)textfieldDidChange:(UITextField *)textField;

@end
