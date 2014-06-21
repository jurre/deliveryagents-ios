#import "AFHTTPRequestOperationManager.h"

static NSString *const DAGAPIBaseURL = @"http://localhost:3000/api/";

@interface DeliveryAgentsAPIClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *authToken;

+ (DeliveryAgentsAPIClient *)sharedClient;

- (NSString *)baseURLString;

@end
