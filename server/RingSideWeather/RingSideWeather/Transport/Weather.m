//
//  Weather.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize weatherDate;
@synthesize temperature;
@synthesize isRaining;
@synthesize isSnowing;
@synthesize windSpeedMPH;



-(id)initWithRainThreshold:(double)rainAmount withSnowThreshhold:(double)snowAmount
{
    self = [super init];
    if(self != nil)
    {
        temperatureArray = [[NSMutableArray alloc] init];
        maxPrecipitationChanceArray = [[NSMutableArray alloc] init];
        snowAmountArray = [[NSMutableArray alloc] init];
        windSpeedKnotsArray = [[NSMutableArray alloc] init];
        weatherDate = [NSDate date];
        rainThreshhold = rainAmount;
        snowThreshhold = snowAmount;
    }
    return self;

}

-(void)addTemperatureObject:(NSInteger)object
{
    NSLog([NSString stringWithFormat:@"Added temp: %ld",object]);
    [temperatureArray addObject:[NSNumber numberWithInteger:object]];
}

-(void)addMaxPrecipitationChanceObject:(NSInteger)object
{
    [maxPrecipitationChanceArray addObject:[NSNumber numberWithInteger:object]];
}
-(void)addSnowAmountObject:(double)object
{
    [snowAmountArray addObject:[NSNumber numberWithInteger:object]];
}
-(void)addWindSpeedKnotsObject:(double)object
{
    [windSpeedKnotsArray addObject:[NSNumber numberWithInteger:object]];
}
-(int)temperature
{
    int temp = 0;
    for (int count = 0; count<[temperatureArray count]; count++)
    {
        temp += [[temperatureArray objectAtIndex:count] integerValue];
    }
    //I get that I'm losing precision, but I can't imagine the swings will be that much.
    temp = ([temperatureArray count]==0)?0:temp/[temperatureArray count];
    return temp;
}
-(bool)isSnowing
{
    for (int count=0; count<[snowAmountArray count]; count++)
    {
        if([[snowAmountArray objectAtIndex:count] doubleValue] > snowThreshhold)
            return true;
    }
    return false;
}
-(bool)isRaining
{
    for(int count = 0;count<[maxPrecipitationChanceArray count]; count++)
    {
        if([[maxPrecipitationChanceArray objectAtIndex:count] doubleValue] > rainThreshhold)
            return true;
    }
    return false;
}
-(double)windSpeedMPH
{
    double windSpeed = 0;
    for (int count = 0; count < [windSpeedKnotsArray count]; count++) {
        windSpeed += ([[windSpeedKnotsArray objectAtIndex:count] doubleValue] * 1.151);
        //Theoretically, this is the right conversion factor for knots to MPH
    }
    windSpeed = ([windSpeedKnotsArray count]==0)?0:windSpeed/[windSpeedKnotsArray count];
    return windSpeed;
}
-(void)setWeatherDate:(NSDate *)wDate
{
    [self setWeatherDate:wDate];
}

-(NSString *)toString
{
    NSString *weatherString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    weatherString = [NSString stringWithFormat:@"Weather Object\nweatherDate:%@\ntemperature:%ld\nwindSpeedMPH:%f\nisRaining:%d\nisSnowing:%d\n",
                     [formatter stringFromDate:[self weatherDate]],
                     self.temperature,
                     self.windSpeedMPH,
                     self.isRaining,
                     self.isSnowing
                     ];
    return weatherString;
}

#pragma mark string properties

-(NSString *)tempString
{
    return [NSString localizedStringWithFormat:@"%d",self.temperature];
}
-(NSString *)rainingString
{
    if(self.isRaining)
        return @"Yes";
    else
        return @"No";
}
-(NSString *)snowingString
{
    if(self.isSnowing)
        return @"Yes";
    else
        return @"No";
}
-(NSString *)windSpeedString
{
    return [NSString localizedStringWithFormat:@"%.2F", self.windSpeedMPH];
}
-(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.zzz"];
    return [dateFormatter stringFromDate:self.weatherDate];
}

@end
