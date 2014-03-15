//
//  SendToClientOperation.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 5/8/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import "SendToClientOperation.h"

@implementation SendToClientOperation

-(id)initWithURLString:(NSString *)URLString
{
    self = [super init];
    if(self)
    {
        retryCount = 0;
        urlString = URLString;
    }
    return self;
}

-(void)main
{
    //do the web service stuff
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Sending to client!");
    NSLog(@"urlString: %@", urlString);
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:true];


}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
        NSLog(@"Successful communication with client!");
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    connection = nil;

    NSLog(@"Failure to communicate with client!");
}

@end
