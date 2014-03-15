//
//  Settings.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
{
/*@private NSInteger *pollingInterval;
    double snowThreshold;
    NSInteger *precipitationThreshold;
    NSInteger *redUpperBound;
    NSInteger *yellowUpperBound;
    double windSpeedThreshold;
  */
}

@property(atomic) int pollingInterval;
@property(atomic) double snowThreshold;
@property(atomic) int precipitationThreshold;
@property(atomic) int redUpperBound;
@property(atomic) int yellowUpperBound;
@property(atomic) double windSpeedThreshold;
@property(atomic) NSString *clientIP;
@property(atomic) bool summerMode;

@property(readonly) NSDictionary *settingValues;

-(id)initWithPollingInterval:(int)pollInterval andSnowThreshold:(double)snowThresh andprecipitationThreshold:(int)precipThresh andRedUpperBound:(int)redBound andYellowUpperBound:(int)yellowBound andWindSpeedThreshold:(double)windSpeedThresh andClientIP:(NSString *)IP andSummerMode:(bool) isSummerMode;

-(id)initWithSettingsDictionary:(NSMutableDictionary *)settingsDictionary;

@end
