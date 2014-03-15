//
//  SettingsController.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "LogController.h"
#import "Constants.h"

@interface SettingsController :NSObject
{
@private Settings *settings;
    LogController *logController;
    NSMutableDictionary *settingValues;
    NSUserDefaults *standardUserDefaults;
    NSArray *keys;


}

@property (readonly) Settings *userSettings;


-(id)initWithLogController:(LogController *)logger;
//-(NSMutableDictionary *) settingValues;


-(void)setPollingInterval:(int)pollingInterval;
-(void)setSnowThreshold:(double)snowThreshold;
-(void)setPrecipitationThreshold:(int)precipitationThreshold;
-(void)setRedUpperBound:(int)redUpperBound;
-(void)setYellowUpperBound:(int)yellowUpperBound;
-(void)setWindSpeedThreshold:(double)windSpeedThreshold;
-(void)setClientIP:(NSString *)clientIP;
-(void)setSummerMode:(bool)summerMode;


@end
