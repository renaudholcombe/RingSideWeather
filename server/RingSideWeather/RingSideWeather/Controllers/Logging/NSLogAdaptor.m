//
//  NSLogAdaptor.m
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "NSLogAdaptor.h"

@implementation NSLogAdaptor

@synthesize message;

-(id)initWithMessage:(NSString *)logMessage
{
    if(!(self = [super init]))
        return nil;
    
    [self setMessage:logMessage];
    return self;
}

-(void)main
{
    if(message != nil)
        NSLog(@"RingSideWeather: %@",message);
}

@end
