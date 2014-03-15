//
//  WeatherViewController.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 3/21/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import "WeatherViewController.h"

@implementation WeatherViewController

@synthesize temperatureLabel, precipitationLabel, snowfallLabel, windSpeedLabel, lastPollDateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newWeatherReceived:) name:@"NewWeatherReceived" object:nil];
}

-(void)newWeatherReceived: (NSNotification *)notification
{
    Weather *newWeather = [[notification userInfo] objectForKey:@"NewWeatherData"];
    [self assignWeather:newWeather];
}

-(void)assignWeather:(Weather *)weather
{
    [temperatureLabel setStringValue:weather.tempString];
    [precipitationLabel setStringValue:weather.rainingString];
    [snowfallLabel setStringValue:weather.snowingString];
    [windSpeedLabel setStringValue:weather.windSpeedString];
    [lastPollDateLabel setStringValue:weather.dateString];
}

@end
