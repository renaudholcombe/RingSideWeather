//
//  DiagnosticsViewController.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/23/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WeatherWebServiceController.h"

@class LogController;

@interface DiagnosticsViewController : NSViewController

//@property (strong) IBOutlet NSView *diagnosticsView;

@property (retain, atomic) IBOutlet NSTextView *weatherTextView;
@property (retain, atomic) IBOutlet NSTextView *logTextView;
@property (weak) IBOutlet NSButton *getWeatherButton;
@property (weak) IBOutlet NSButton *clearLogButton;
@property (weak) IBOutlet NSButton *displayWeatherButton;

@property (strong, nonatomic) WeatherWebServiceController *weatherWSController;
@property (strong, nonatomic) LogController *logController;

-(IBAction)getWeatherClick:(id)sender;
-(IBAction)clearLogClick:(id)sender;
-(IBAction)displayWeatherClick:(id)sender;

-(void)appendLogString:(NSString *)logString;
-(void)assignWeatherWSController:(WeatherWebServiceController *)weatherWSController;
-(void)assignLogController:(LogController *)logController;

@end
