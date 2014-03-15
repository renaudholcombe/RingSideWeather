//
//  Queue.h
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadSafeQueue : NSObject {
@private NSMutableArray* internalArray;
}

@property (readonly) int count;
@property (strong, atomic) NSMutableArray *internalArray;

-(void)enqueue: (id)object;
-(id)dequeue;
-(void)clear;

@end
