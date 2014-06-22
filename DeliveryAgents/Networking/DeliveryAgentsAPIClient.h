#import "AFHTTPRequestOperationManager.h"
#import "ip_address.h"

#ifdef DEBUG
//static NSString * const DAGAPIBaseURL = LOCAL_IP_ADDRESS;
static NSString *const DAGAPIBaseURL = @"http://lvh.me:3003/api";
#else
static NSString *const DAGAPIBaseURL = @"http://localhost:3000/api/";
#endif

@interface DeliveryAgentsAPIClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *authToken;

+ (DeliveryAgentsAPIClient *)sharedClient;

- (NSString *)baseURLString;

@end
