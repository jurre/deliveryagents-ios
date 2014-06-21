#import "AFHTTPRequestOperationManager.h"

static NSString *const DAGAPIBaseURL = @"localhost:3000/api/";

@interface DeliveryAgentsAPIClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *authToken;

+ (DeliveryAgentsAPIClient *)sharedClient;

- (void)setBaseURL:(NSString *)url;

- (NSString *)baseURLString;

@end
