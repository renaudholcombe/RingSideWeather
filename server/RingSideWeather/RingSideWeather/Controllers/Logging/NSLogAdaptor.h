//
//  NSLogAdaptor.h
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLogAdaptor : NSOperation {
    NSString *message;
}

@property (retain) NSString *message;
-(id)initWithMessage:(NSString *) message;

@end
