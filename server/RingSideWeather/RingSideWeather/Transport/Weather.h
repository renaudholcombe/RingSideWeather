//
//  Weather.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
{
    @private NSDate *weatherDate;
/*        NSUInteger temperature;
        NSUInteger maxPrecipitationChance;
        double snowAmount;
        double windSpeedKnots;
        NSUInteger apparentTemperature;
  */
    NSMutableArray *temperatureArray;
    NSMutableArray *maxPrecipitationChanceArray;
    NSMutableArray *snowAmountArray;
    NSMutableArray *windSpeedKnotsArray;
    double rainThreshhold;
    double snowThreshhold;
}

@property (readonly) NSDate *weatherDate;
@property (readonly) int temperature;
@property (readonly) bool isRaining;
@property (readonly) bool isSnowing;
@property (readonly) double windSpeedMPH;
@property (readonly) NSString *tempString;
@property (readonly) NSString *rainingString;
@property (readonly) NSString *snowingString;
@property (readonly) NSString *windSpeedString;
@property (readonly) NSString *dateString;



-(id)initWithRainThreshold:(double)rainAmount withSnowThreshhold:(double)snowAmount;
-(void)addTemperatureObject:(NSInteger )object;
-(void)addMaxPrecipitationChanceObject:(NSInteger)object;
-(void)addSnowAmountObject:(double)object;
-(void)addWindSpeedKnotsObject:(double)object;
-(NSString *)toString;
-(NSString *)toURLString;




@end
