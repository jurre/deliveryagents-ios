#import "DeliveryAgentsAPIClient.h"

@interface DeliveryAgentsAPIClient ()

@end

@implementation DeliveryAgentsAPIClient

+ (instancetype)sharedClient {
	static DeliveryAgentsAPIClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedClient = [[self alloc] init];
	});

	return _sharedClient;
}

- (NSURL *)baseURL {
    return [NSURL URLWithString:DAGAPIBaseURL];
}

- (NSString *)baseURLString {
    return [self.baseURL absoluteString];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *, id))success
                                                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {

    NSMutableURLRequest *mutableRequest = [request mutableCopy];

    if (self.authToken) {
        [mutableRequest addValue:self.authToken forHTTPHeaderField:@"Authorization"];
    }

    return [super HTTPRequestOperationWithRequest:mutableRequest
                                          success:success
                                          failure:failure];
}

@end
