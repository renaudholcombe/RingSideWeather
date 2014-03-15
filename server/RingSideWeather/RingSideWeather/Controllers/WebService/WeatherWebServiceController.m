//
//  WeatherWebServiceController.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "WeatherWebServiceController.h"
#import <CFNetwork/CFNetwork.h>
//#import "LogController.h"
#import "WeatherDataHelper.h"
#import "SendToClientOperation.h"

@implementation WeatherWebServiceController

@synthesize weatherConnection = _weatherConnection;
@synthesize weatherData = _weatherData;
@synthesize operationQueue = _operationQueue;
@synthesize lastDataDate = _lastDataDate;
@synthesize logController = _logController;
@synthesize tempWeatherData = _tempWeatherData;
@synthesize delegate;

-(id)initWithLogController:(LogController *)logger withSettingsController:(SettingsController *)settingsHelper
{
    self = [super init];
    if(self != nil)
    {
        //initialize all the objects
        [self setLogController:logger];
        [self setWeatherConnection:[[NSURLConnection alloc] init]];
        [self setWeatherData:[[NSMutableData alloc] init]];
        [self setOperationQueue:[NSOperationQueue new]];
        settingsController = settingsHelper;
        
    }
    return self; 
}
-(NSMutableData *)getWeatherData
{
    @synchronized([self weatherData])
    {
        return [self weatherData];
    }
}

-(NSDate *)getLastDataDate
{
    @synchronized([self lastDataDate])
    {
        return [self lastDataDate];
    }
}

-(void)startPollingThread
{
    Settings *settings = settingsController.userSettings;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [self runWeatherThreadOnInterval:settings.pollingInterval];
    });
}

-(void)runWeatherThreadOnInterval:(int)intervalInHours
{
    int sleepInterval = intervalInHours * 60 * 60; //making it seconds
    //making a smaller interval just for testing purposes
//    int sleepInterval = 60 * 5;
    while(true) //to infinity and beyond!
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            @autoreleasepool {
                [self forceWeatherRefresh];
            }
        });

        [NSThread sleepForTimeInterval:sleepInterval];
    }
}

-(void)forceWeatherRefresh
{
    [[self logController] saveToLog:@"Starting weather data refresh."];

    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    NSDate *tomorrow = [calendar dateByAddingComponents:components toDate:today options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH'%3A'mm'%3A'ss"];
    
    NSString *todayString = [dateFormatter stringFromDate:today];
    NSString *tomorrowString = [dateFormatter stringFromDate:tomorrow];
    
    //These should probably be settings.
    static double longitude = -71.11;
    static double latitude = 42.33;
    
    NSString *feedURL = [NSString stringWithFormat:@"http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=NDFDgen&lat=%f&lon=%f&product=time-series&begin=%@&end=%@&Unit=e&temp=temp&pop12=pop12&appt=appt&Submit=Submit&snow=snow&wspd=wspd&pop12=pop12&wwa=wwa", latitude, longitude, todayString, tomorrowString];
    
    [[self logController] saveToLog:@"Requesting weather data with URL:"];
    [[self logController] saveToLog:feedURL];
    [self setTempWeatherData:[[NSMutableData alloc]init]];
    
    NSURLRequest *weatherURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: feedURL]];
    
    [self setWeatherConnection:[[NSURLConnection alloc] initWithRequest:weatherURLRequest delegate:self]];
    
    if([self weatherConnection]==nil)
    {
        [[self logController] saveToLog:@"Failed to create weather connection object!"];
    }
}

-(void)sendWeatherDataToClient:(Weather *)weather
{
    WeatherDataHelper *helper = [[WeatherDataHelper alloc] init];
    Settings *settings = [settingsController userSettings];
    SendToClientOperation *sendOperation = [[SendToClientOperation alloc] initWithURLString:[helper getWeatherURLStringFromWeather:weather withSettings:settings]];

    [self.operationQueue addOperation:sendOperation];
}

#pragma mark Connection Events

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self tempWeatherData] appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[self logController] saveToLog:[error localizedDescription]];
    [self setTempWeatherData:nil];
    [self setWeatherConnection:nil];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[self logController]saveToLog:@"Finished loading weather data."];
    [self setWeatherConnection:nil];

    @synchronized([self weatherData])
    {
        [self setWeatherData:nil];
        [self setWeatherData:[[NSMutableData alloc] initWithData:[self tempWeatherData]]];
    }
    @synchronized([self lastDataDate])
    {
        [self setLastDataDate:[NSDate date]];
    }
    [self setTempWeatherData:nil];
    //throw the parsing logic here
    Settings *settings = settingsController.userSettings;
    ParseOperation *parseOperation = [[ParseOperation alloc] initWithData:[self weatherData] withRainThreshhold:settings.precipitationThreshold withSnowThreshhold:settings.snowThreshold];
    [parseOperation setDelegate:self];

    [self.operationQueue addOperation:parseOperation];
}

#pragma mark ParseOperationDelegate methods

-(void)xmlParsedintoWeather:(Weather *)weather
{
    NSLog(@"Received weather object from operation!");
    NSLog(@"%@",[weather toString]);
    //kick it over to the delegate!
    //kick it over to the notification center
    //[delegate newWeatherReceived:weather];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:weather forKey:@"NewWeatherData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewWeatherReceived" object:self userInfo:userInfo];
    [self sendWeatherDataToClient:weather];
}

#pragma mark Properties


@end
