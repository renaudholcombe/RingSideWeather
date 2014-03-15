//
//  ParseOperation.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "ParseOperation.h"

static NSString *elementWindSpeed = @"wind-speed";
static NSString *elementSnow = @"precipitation"; //this probabably hits all types of 'rain', but there's also a type="snow" attribute
static NSString *elementPrecipitation = @"probability-of-precipitation";
static NSString *elementTemperature = @"temperature"; //Need to use to type="apparent" tag on this one.

@implementation ParseOperation

@synthesize delegate;
@synthesize weatherData;
@synthesize currentParseBatch;
@synthesize currentParsedCharacterData;
@synthesize currentWeatherObject;
@synthesize currentElement;

@synthesize parsingTemperature;
@synthesize parsingWindSpeed;
@synthesize parsingSnow;
@synthesize parsingPrecipitation;

-(id)initWithData:(NSData *)wData withRainThreshhold:(double)rainThreshhold withSnowThreshhold:(double)snowThreshhold
{
    self = [super init];
    if(self != nil)
    {
        weatherData = [wData copy];
        self.currentWeatherObject = [[Weather alloc] initWithRainThreshold:rainThreshhold withSnowThreshhold:snowThreshhold];
        self.parsingTemperature = false;
        self.parsingPrecipitation = false;
        self.parsingSnow = false;
        self.parsingWindSpeed = false;
        //[self.currentWeatherObject setWeatherDate:[NSDate date]];
    }
    return self;
}

-(void)main
{
    self.currentParseBatch = [NSMutableArray array];
    self.currentParsedCharacterData = [NSMutableString string];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[self weatherData]];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark Parser Methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //[[self currentParsedCharacterData] initWithString:elementName];
    self.currentElement = [elementName copy];
    NSLog([NSString stringWithFormat:@"Starting with Element %@",elementName]);
    
    if([[self currentElement] isEqualToString:elementPrecipitation])
        self.parsingPrecipitation = true;
    if([[self currentElement] isEqualToString:elementSnow])
        self.parsingSnow = true;
    if([[self currentElement] isEqualToString:elementTemperature])
    {
        if([[attributeDict valueForKey:@"type"] isEqualToString:@"apparent"])
            self.parsingTemperature = true;
    }
    if([[self currentElement] isEqualToString:elementWindSpeed])
        self.parsingWindSpeed = true;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    if([formatter numberFromString:string]==nil)
        return;
    if(parsingPrecipitation && [[self currentElement] isEqualToString:@"value"])
        [[self currentWeatherObject] addMaxPrecipitationChanceObject:[string integerValue]];
    if(parsingSnow && [[self currentElement] isEqualToString:@"value"])
        [[self currentWeatherObject] addSnowAmountObject:[string doubleValue]];
    if(parsingTemperature && [[self currentElement] isEqualToString:@"value"])
        [[self currentWeatherObject] addTemperatureObject:[string integerValue]];
    if(parsingWindSpeed && [[self currentElement] isEqualToString:@"value"])
        [[self currentWeatherObject] addWindSpeedKnotsObject:[string doubleValue]];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:elementPrecipitation])
        parsingPrecipitation = false;
    if([elementName isEqualToString:elementSnow])
        parsingSnow = false;
    if([elementName isEqualToString:elementWindSpeed])
        parsingWindSpeed = false;
    if([elementName isEqualToString:elementTemperature])
        parsingTemperature = false; //sloppy, but I think I can get away with it.
    if([elementName isEqualToString:@"dwml"]) //This is the end of the document.
    {
        Weather *tempWeather = [self currentWeatherObject];
        NSLog(@"Finished parsing document");
        NSLog([[self currentWeatherObject] toString]);
        [delegate xmlParsedintoWeather:tempWeather];
    }
}
@end
