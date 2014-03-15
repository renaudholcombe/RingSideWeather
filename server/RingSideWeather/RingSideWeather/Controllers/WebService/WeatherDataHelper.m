//
//  WeatherDataHelper.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 5/8/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import "WeatherDataHelper.h"

@implementation WeatherDataHelper

-(NSString *)getWeatherURLStringFromWeather:(Weather *)weather withSettings:(Settings *)settings
{
    NSString *urlString = [NSString stringWithFormat:@"%d%d", weather.isRaining, weather.isSnowing];

    if(weather.windSpeedMPH > settings.windSpeedThreshold)
        urlString = [NSString stringWithFormat:@"%@%d",urlString,1];
    else
        urlString = [NSString stringWithFormat:@"%@%d",urlString,0];
    if(settings.summerMode)
    {
        if(weather.temperature < settings.redUpperBound)
            if(weather.temperature < settings.yellowUpperBound)
                urlString = [NSString stringWithFormat:@"%d%@",0,urlString];
            else
                urlString = [NSString stringWithFormat:@"%d%@",1,urlString];
        else
            urlString = [NSString stringWithFormat:@"%d%@",2,urlString];
    } else
    {
        if(weather.temperature < settings.yellowUpperBound)
            if(weather.temperature < settings.redUpperBound)
                urlString = [NSString stringWithFormat:@"%d%@",2,urlString];
            else
                urlString = [NSString stringWithFormat:@"%d%@",1,urlString];
            else
                urlString = [NSString stringWithFormat:@"%d%@",0,urlString];
    }
    urlString = [NSString stringWithFormat:@"http://%@/%@",settings.clientIP,urlString];
    return urlString;
}

@end
