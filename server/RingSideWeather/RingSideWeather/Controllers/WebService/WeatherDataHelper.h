//
//  WeatherDataHelper.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 5/8/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Settings.h"

@interface WeatherDataHelper : NSObject

-(NSString *)getWeatherURLStringFromWeather:(Weather *)weather withSettings:(Settings *)settings;

@end
