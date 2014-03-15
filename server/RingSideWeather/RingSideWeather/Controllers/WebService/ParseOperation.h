//
//  ParseOperation.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

//Delegate protocol definition
@protocol ParseOperationDelegate <NSObject>
-(void)xmlParsedintoWeather:(Weather *) weather;
@end
//delegate protocol end

@interface ParseOperation : NSOperation <NSXMLParserDelegate>
{
    NSData *weatherData;
    
    @private
    Weather *currentWeatherObject;
    NSMutableArray *currentParseBatch;
    NSMutableString *currentParsedCharacterData;
    
    NSString *currentElement;
    
    BOOL accumulatingParsedCharacterData;
    BOOL didAboutParsing;
    NSUInteger parsedWeatherCounter; //probably don't need this.
    
    //parsing helpers
    bool parsingTemperature;
    bool parsingWindSpeed;
    bool parsingSnow;
    bool parsingPrecipitation;
}

@property id<ParseOperationDelegate> delegate;

@property (copy, readonly) NSData *weatherData;
@property (nonatomic, retain) NSMutableArray *currentParseBatch;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
@property (nonatomic, retain) Weather *currentWeatherObject;
@property (nonatomic, retain) NSString *currentElement;

@property (nonatomic, assign) bool parsingTemperature;
@property (nonatomic, assign) bool parsingWindSpeed;
@property (nonatomic, assign) bool parsingSnow;
@property (nonatomic, assign) bool parsingPrecipitation;

-(id)initWithData:(NSData *)wData withRainThreshhold:(double)rainThreshhold withSnowThreshhold:(double)snowThreshhold;

@end
