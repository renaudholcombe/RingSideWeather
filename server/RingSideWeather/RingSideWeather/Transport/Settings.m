//
//  Settings.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "Settings.h"
#import "Constants.h"

@implementation Settings

@synthesize pollingInterval;
@synthesize snowThreshold;
@synthesize precipitationThreshold;
@synthesize redUpperBound;
@synthesize yellowUpperBound;
@synthesize windSpeedThreshold;
@synthesize clientIP;
@synthesize summerMode;

-(id)initWithPollingInterval:(int)pollInterval andSnowThreshold:(double)snowThresh andprecipitationThreshold:(int)precipThresh andRedUpperBound:(int)redBound andYellowUpperBound:(int)yellowBound andWindSpeedThreshold:(double)windSpeedThresh andClientIP:(NSString *)IP andSummerMode:(bool)isSummerMode
{
    self = [super init];
    if(self != nil)
    {
        pollingInterval = pollInterval;
        snowThreshold = snowThresh;
        precipitationThreshold = precipThresh;
        redUpperBound = redBound;
        yellowUpperBound = yellowBound;
        windSpeedThreshold = windSpeedThresh;
        clientIP = IP;
        summerMode = isSummerMode;
        
    }
    return self;
}

-(id)initWithSettingsDictionary:(NSMutableDictionary *)settingsDictionary
{
    self = [super init];
    if (self != nil)
    {
        [self populateFromDictionary:settingsDictionary];
    }
    return self;
}

-(void)populateFromDictionary:(NSMutableDictionary *)settingsDictionary
{
    pollingInterval = [[settingsDictionary objectForKey:SETTING_WSINTERVAL] intValue];
    snowThreshold = [[settingsDictionary objectForKey:SETTING_SNOWTHRESHOLD] doubleValue];
    precipitationThreshold = [[settingsDictionary objectForKey:SETTING_PRECIPITATIONTHRESHOLD] intValue];
    redUpperBound = [[settingsDictionary objectForKey:SETTING_REDUPPERBOUND] intValue];
    yellowUpperBound = [[settingsDictionary objectForKey:SETTING_YELLOWUPPERBOUND] intValue];
    windSpeedThreshold = [[settingsDictionary objectForKey:SETTING_WINDSPEEDTHRESHOLD] doubleValue];
    if([[settingsDictionary objectForKey:SETTING_CLIENTIP] isEqualToString:@""])
        clientIP = @"0";
    else
        clientIP = [settingsDictionary objectForKey:SETTING_CLIENTIP];
    summerMode = ([[settingsDictionary objectForKey:SETTING_SUMMERMODE] doubleValue] == 0)? false: true;

    NSLog(@"ClientIP - Settings.m : %@", clientIP);
}
-(NSDictionary *)settingValues
{
    //return [self populateDictionary];
    return nil;
}

-(NSDictionary *)populateDictionary
{
    NSMutableDictionary *settingsDictionary = [[NSMutableDictionary alloc] init];
    [settingsDictionary setObject:[NSNumber numberWithInt:pollingInterval] forKey:SETTING_WSINTERVAL];
    [settingsDictionary setObject:[NSDecimalNumber numberWithDouble:snowThreshold] forKey:SETTING_SNOWTHRESHOLD];
    [settingsDictionary setObject:[NSNumber numberWithInt:precipitationThreshold] forKey:SETTING_PRECIPITATIONTHRESHOLD];
    [settingsDictionary setObject:[NSNumber numberWithInt:redUpperBound] forKey:SETTING_REDUPPERBOUND];
    [settingsDictionary setObject:[NSNumber numberWithInt:yellowUpperBound] forKey:SETTING_YELLOWUPPERBOUND];
    [settingsDictionary setObject:[NSDecimalNumber numberWithDouble:windSpeedThreshold] forKey:SETTING_WINDSPEEDTHRESHOLD];
    [settingsDictionary setObject:clientIP forKey:SETTING_CLIENTIP];
    [settingsDictionary setObject:[NSNumber numberWithBool:summerMode] forKey:SETTING_SUMMERMODE];

    NSArray *SETTING_KEYARRAY = [NSArray arrayWithObjects:SETTING_WSINTERVAL,SETTING_SNOWTHRESHOLD, SETTING_PRECIPITATIONTHRESHOLD, SETTING_WINDSPEEDTHRESHOLD, SETTING_REDUPPERBOUND, SETTING_YELLOWUPPERBOUND, SETTING_CLIENTIP,SETTING_SUMMERMODE, nil];

    return [settingsDictionary dictionaryWithValuesForKeys:SETTING_KEYARRAY];
}

@end
