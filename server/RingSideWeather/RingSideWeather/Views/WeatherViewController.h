//
//  WeatherViewController.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 3/21/13.
//  Copyright (c) 2013 Renaud Holcombe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Weather.h"

@interface WeatherViewController : NSViewController

@property (weak) IBOutlet NSTextField *temperatureLabel;
@property (weak) IBOutlet NSTextField *precipitationLabel;
@property (weak) IBOutlet NSTextField *snowfallLabel;
@property (weak) IBOutlet NSTextField *windSpeedLabel;
@property (weak) IBOutlet NSTextField *lastPollDateLabel;

-(void)assignWeather:(Weather *)weather;

@end
