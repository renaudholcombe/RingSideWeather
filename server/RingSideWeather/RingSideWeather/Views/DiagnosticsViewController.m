//
//  DiagnosticsViewController.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/23/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "DiagnosticsViewController.h"
#import "LogController.h"

/*@interface DiagnosticsViewController ()

@end
*/
@implementation DiagnosticsViewController

@synthesize weatherTextView = _weatherTextView;
@synthesize logTextView = _logTextView;
@synthesize getWeatherButton = _getWeatherButton;
@synthesize clearLogButton = _clearLogButton;
@synthesize logController = _logController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [[[self logTextView] textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:@"Quick initWithNib"]];
    return self;
}

-(id) init{
    self = [super init];
    
    return self;
}
-(IBAction)displayWeatherClick:(id)sender
{
    [[self logController] saveToLog:@"CLICK: displayWeather"];
    NSString *weatherString = [[NSString alloc] initWithData:[[self weatherWSController] getWeatherData]encoding:NSASCIIStringEncoding];
            [[self weatherTextView] setString:weatherString];
}

-(IBAction)getWeatherClick:(id)sender
{
    [[self logController] saveToLog:@"CLICK: getWeather"];
    [[self weatherWSController] forceWeatherRefresh];

}

-(IBAction)clearLogClick:(id)sender
{
    [self clearLog];
    [[self logController] saveToLog:@"Log cleared."];
}

-(void)assignWeatherWSController:(WeatherWebServiceController *)weatherWSController
{
    [self setWeatherWSController:weatherWSController];
}

-(void)assignLogController:(LogController *)logController
{
    [self setLogController:logController];
}

-(void)loadView
{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendLogString:) name:@"AppendLogStringForDisplay" object:nil];
}

-(void)appendLogString:(NSNotification *)notification{

    dispatch_sync(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            NSString *logString = [[notification userInfo] objectForKey:@"LogString"];
            [self appendLogStringInternal:logString];
        }
    });
}

-(void)clearLog
{
    [[self logTextView] setString:@""];
}

-(void)appendLogStringInternal:(NSString *)logString
{
    NSRange theEnd=NSMakeRange([[[self logTextView] string] length],0);
    theEnd.location+=[logString length];
    
    // Smart Scrolling
    if (NSMaxY([[self logTextView] visibleRect]) == NSMaxY([[self logTextView] bounds])) {
        // Append string to textview and scroll to bottom
        [[[self logTextView] textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:logString]] ;
        [[self logTextView] scrollRangeToVisible:theEnd];
    }else{
        // Append string to textview
        [[[self logTextView] textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:logString]];
    }
    
}

#pragma mark Properties

-(NSTextView *)logTextView
{
    if(_logTextView == nil)
    {
        _logTextView = [[NSTextView alloc] init];
        [_logTextView setString:@"Initializing Logging View!"];
    }
    return _logTextView;
}

-(void) setLogTextView:(NSTextView *)logTextView
{
    _logTextView = logTextView;
}

@end
