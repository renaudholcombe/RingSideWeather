//
//  SettingsController.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "SettingsController.h"

@implementation SettingsController

@synthesize userSettings = settings;

-(id)initWithLogController:(LogController *)logger
{
    self = [super init];
    if(self != nil)
    {
        logController = logger;

        //need to load the settings here.
        standardUserDefaults = [NSUserDefaults standardUserDefaults];

        keys = [NSArray arrayWithObjects: SETTING_WSINTERVAL, SETTING_SNOWTHRESHOLD, SETTING_PRECIPITATIONTHRESHOLD, SETTING_WINDSPEEDTHRESHOLD, SETTING_REDUPPERBOUND, SETTING_YELLOWUPPERBOUND, SETTING_CLIENTIP, SETTING_SUMMERMODE,nil];

        settingValues = [[NSMutableDictionary alloc] init];
        
        [self loadSettingsFromUserDefaults];
    }
    [logController saveToLog:@"SettingsController initialized."];
    return self;
}

-(void)loadSettingsFromUserDefaults
{
    for (NSString *keyString in keys) {
        if(standardUserDefaults)
        {
            if(![standardUserDefaults objectForKey:keyString])
                [standardUserDefaults setObject:@"0" forKey:keyString];
            [settingValues setObject:[standardUserDefaults objectForKey:keyString] forKey:keyString];
        }


    }
    [self populateSettings];

}
-(void)populateSettings
{
    settings = [[Settings alloc] initWithSettingsDictionary:settingValues];
    
}


-(Settings *)userSettings
{
    return settings;
}

#pragma mark set methods
-(void)setPollingInterval:(int)pollingInterval
{
    if(standardUserDefaults && pollingInterval != settings.pollingInterval)
    {
        settings.pollingInterval = pollingInterval;
        [standardUserDefaults setObject:[NSNumber numberWithInt:pollingInterval] forKey:SETTING_WSINTERVAL];

    }
}
-(void)setSnowThreshold:(double)snowThreshold
{
    if(standardUserDefaults && snowThreshold != settings.snowThreshold)
    {
        settings.snowThreshold = snowThreshold;
        [standardUserDefaults setObject:[NSDecimalNumber numberWithDouble:snowThreshold] forKey:SETTING_SNOWTHRESHOLD];
    }
}
-(void)setPrecipitationThreshold:(int)precipitationThreshold
{
    if(standardUserDefaults && precipitationThreshold != settings.precipitationThreshold)
    {
        settings.precipitationThreshold = precipitationThreshold;
        [standardUserDefaults setObject:[NSNumber numberWithInt:precipitationThreshold] forKey:SETTING_PRECIPITATIONTHRESHOLD];
    }
}
-(void)setRedUpperBound:(int)redUpperBound
{
    if(standardUserDefaults && redUpperBound != settings.redUpperBound)
    {
        settings.redUpperBound=redUpperBound;
        [standardUserDefaults setObject:[NSNumber numberWithInt:redUpperBound] forKey:SETTING_REDUPPERBOUND];
    }
}
-(void)setYellowUpperBound:(int)yellowUpperBound
{
    if(standardUserDefaults && yellowUpperBound != settings.yellowUpperBound)
    {
        settings.yellowUpperBound = yellowUpperBound;
        [standardUserDefaults setObject:[NSNumber numberWithInt:yellowUpperBound] forKey:SETTING_YELLOWUPPERBOUND];
    }
}
-(void)setWindSpeedThreshold:(double)windSpeedThreshold
{
    if(standardUserDefaults && windSpeedThreshold != settings.windSpeedThreshold)
    {
        settings.windSpeedThreshold = windSpeedThreshold;
        [standardUserDefaults setObject:[NSDecimalNumber numberWithDouble:windSpeedThreshold] forKey:SETTING_WINDSPEEDTHRESHOLD];
    }
}
-(void)setClientIP:(NSString *)clientIP
{
    if(standardUserDefaults && ![clientIP isEqualToString:settings.clientIP])
    {
        settings.clientIP = clientIP;
        [standardUserDefaults setObject:clientIP forKey:SETTING_CLIENTIP];
    }
}
-(void)setSummerMode:(bool)summerMode
{
    if(standardUserDefaults && !summerMode==settings.summerMode)
    {
        settings.summerMode = summerMode;
        [standardUserDefaults setObject:[NSNumber numberWithBool:summerMode] forKey:SETTING_SUMMERMODE];
    }
}


@end
