//
//  LogController.m
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "LogController.h"
#import "ThreadSafeQueue.h"

//Logging Adaptors
#import "NSLogAdaptor.h"
//#import "DatabaseLogAdaptor.h"



@implementation LogController


static ThreadSafeQueue *messageQueue;
static NSThread *operationThread;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        messageQueue = [[ThreadSafeQueue alloc] init];
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:1]; //keeping it simple for now
        operationThread = [[NSThread alloc] initWithTarget:self selector:@selector(createAndQueueLogOperations) object:nil];
        
//        dbController = DbController;
//        [self setDiagnosticsViewController:DVController];
        [operationThread start];
    }
    return self;
}
-(void) saveToLog:(NSString *)message
{
    [messageQueue enqueue:message];
}

-(void) createAndQueueLogOperations
{
    //this is where the adaptor logic is going to have to go.
    //this idea is that I'll go through and create some settings to determine where the logging goes.
    NSLog(@"start logging thread");
    while(2==2) //should be more sophisticated
    {
        while(messageQueue.count > 0)
        {
            NSString *message = [messageQueue dequeue];
            if(message != nil)
            {
                
               // [[self logViewController] setLogString:[[[self logViewController] logString] stringByAppendingFormat:@"\n%@",message]];
                NSDate *timeStamp = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];

                // [[self diagnosticsViewController] appendLogString:[NSString stringWithFormat:@"\n%@ : %@",[dateFormatter stringFromDate:timeStamp],message]];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"\n%@ : %@",[dateFormatter stringFromDate:timeStamp],message] forKey:@"LogString"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AppendLogStringForDisplay" object:self userInfo:userInfo];

                
               
                NSLogAdaptor *nslogAdaptor = [[NSLogAdaptor alloc] initWithMessage:message];
                [operationQueue addOperation:nslogAdaptor];
                
                //Pretty shitty practice, but I think I'm overloading the textview without this.
                //[NSThread sleepForTimeInterval:0.1];
            }
        }
        [NSThread sleepForTimeInterval:1];
    }
}


@end
