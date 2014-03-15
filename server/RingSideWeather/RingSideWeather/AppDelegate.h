//
//  AppDelegate.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/23/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DiagnosticsViewController.h"
#import "SettingsViewController.h"
#import "WeatherViewController.h"
#import "LogController.h"
#import "SettingsController.h"
#import "WeatherWebServiceController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
   // @private LogController *logController;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTabView *tabView;

@property (retain) IBOutlet DiagnosticsViewController *diagnosticsViewController;
@property (retain) IBOutlet SettingsViewController *settingsViewController;
@property (retain) IBOutlet WeatherViewController *weatherViewController;
@property (strong, nonatomic) LogController *logController;
@property (strong, nonatomic) WeatherWebServiceController *weatherWSController;
@property (strong, nonatomic) SettingsController *settingsController;

@end
