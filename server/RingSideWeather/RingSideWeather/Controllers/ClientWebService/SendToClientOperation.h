//
//  SendToClientOperation.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 5/8/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface SendToClientOperation : NSOperation<NSURLConnectionDelegate>
{
    int retryCount;
    NSString *urlString;
    NSURLConnection *connection;
}

-(id)initWithURLString:(NSString *)URLString;
@end
