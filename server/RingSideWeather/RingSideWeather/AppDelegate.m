//
//  AppDelegate.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/23/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize tabView;
@synthesize logController = _logController;
@synthesize weatherWSController = _weatherWSController;
@synthesize settingsController = _settingsController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSTabViewItem *item = [[self tabView] tabViewItemAtIndex:2];
    [item setView:[[self diagnosticsViewController] view]];

    item = [[self tabView] tabViewItemAtIndex:1];
    [item setView:[[self settingsViewController] view]];
    [[self settingsViewController] assignSettingsController:[self settingsController]];
    [[self settingsViewController] assignSettingsControls];

    item = [[self tabView] tabViewItemAtIndex:0];
    [item setView:[[self weatherViewController] view]];
    
    // Insert code here to initialize your application
    [[self logController] saveToLog:@"Starting LogController"];
    [[self diagnosticsViewController] assignWeatherWSController:[self weatherWSController]];
    [[self diagnosticsViewController] assignLogController:[self logController]];
    [[self weatherWSController] startPollingThread];
}

#pragma mark webservice delegate methods
/*-(void)newWeatherReceived:(Weather *)weather
{
    [[self weatherViewController] assignWeather:weather];
}
*/

#pragma mark Properties

-(LogController *) logController
{
    if(_logController == nil)
    {
        _logController = [[LogController alloc] init];
    }
    return _logController;
}

-(WeatherWebServiceController *)weatherWSController
{
    if(_weatherWSController == nil)
    {
        _weatherWSController = [[WeatherWebServiceController alloc] initWithLogController:[self logController] withSettingsController:[self settingsController]];
//        [_weatherWSController setDelegate:self];
    }
    return _weatherWSController;
}

-(SettingsController *)settingsController
{
    if(_settingsController == nil)
    {
        _settingsController = [[SettingsController alloc] initWithLogController:[self logController]];
    }
    return _settingsController;
}

@end
