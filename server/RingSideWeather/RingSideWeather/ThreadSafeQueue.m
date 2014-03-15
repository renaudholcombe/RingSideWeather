//
//  Queue.m
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "ThreadSafeQueue.h"

@implementation ThreadSafeQueue

@synthesize count;
@synthesize internalArray = _internalArray;


-(id) init
{
    if(self = [super init])
    {
        count = 0;
    }
    return self;
}

-(void)enqueue:(id)object
{
    @synchronized([self internalArray]){
        [[self internalArray] addObject:object];
        count = (int)[[self internalArray] count];
    }
}

-(id)dequeue
{
    id object = nil;
    {
        @synchronized([self internalArray]){
            if([self internalArray].count > 0)
            {
                object = [[self internalArray] objectAtIndex:0];
                [[self internalArray] removeObjectAtIndex:0];
                count = (int)[[self internalArray] count];
                
            }
        }
    }
    return object;
}

-(void)clear
{
    {
        @synchronized([self internalArray]){
            [[self internalArray] removeAllObjects];
        }
    }
}

-(void) setInternalArray:(NSMutableArray *)array
{
        _internalArray = array;
}

-(NSMutableArray *)internalArray
{
        if(_internalArray == nil)
        {
            _internalArray = [[NSMutableArray alloc] init];
        }
    return _internalArray;
}

@end
