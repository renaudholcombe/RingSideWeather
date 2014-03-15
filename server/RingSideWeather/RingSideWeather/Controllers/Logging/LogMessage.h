//
//  LogMessage.h
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/21/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LogMessage : NSManagedObject

@property (nonatomic, retain) NSString * logMessage;
@property (nonatomic, retain) NSDate * timeStamp;

@end
