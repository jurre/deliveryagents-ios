//
//  DAGSessionViewController.m
//  DeliveryAgents
//
//  Created by Jurre Stender on 21/06/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

#import "DAGSessionViewController.h"

static NSString *const DAGSegueIdentifierSignin = @"DAGSegueIdentifierSignin";

@interface DAGSessionViewController ()

@end

@implementation DAGSessionViewController
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		_apiClient = [DeliveryAgentsAPIClient sharedClient];
        _sessionService = [DAGSessionService sharedService];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInButton.enabled = false;
    self.emailTextField.text = self.sessionService.emailAddress;
}

- (IBAction)signInButtonTapped:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self setSignInFieldsEnabled:NO];

    void (^completion)() = ^{
        [self setSignInFieldsEnabled:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };

    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;

    self.sessionService.emailAddress = email;

    [self.sessionService signInWithEmail:email password:password completion:^(DAGUser *user) {
        self.emailTextField.text = @"";
        self.passwordTextField.text = @"";

        self.apiClient.authToken = user.authenticationToken;
        completion();
        [self performSegueWithIdentifier:DAGSegueIdentifierSignin sender:self];
    } failure:^(NSError *error) {
        completion();

//        [CRToastManager showNotificationWithMessage:@"You done goofed. Try again." completionBlock:nil];
        NSLog(@"Failed signing in: %@", error);

    }];
}

- (void)setSignInFieldsEnabled:(BOOL)enabled {
    self.emailTextField.enabled = enabled;
    self.passwordTextField.enabled = enabled;
    self.signInButton.enabled = enabled;
}


- (IBAction)textfieldDidChange:(UITextField *)textField {
    BOOL emailEntered = [self textFieldIsSet:self.emailTextField];
    BOOL passwordEntered = [self textFieldIsSet:self.passwordTextField];
    self.signInButton.enabled = emailEntered && passwordEntered;
}

- (BOOL)textFieldIsSet:(UITextField *)textField {
    return textField.text && textField.text.length > 0;
}

@end
