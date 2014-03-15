//
//  SettingsViewController.m
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize wsPollingIntervalText;
@synthesize snowThresholdText;
@synthesize precipitationThresholdText;
@synthesize windSpeedThresholdText;
@synthesize redUpperBoundText;
@synthesize yellowUpperBoundText;
@synthesize clientIPText;

@synthesize summerModeButton;

@synthesize wsPollingIntervalStepper;
@synthesize snowThresholdStepper;
@synthesize precipitationThresholdStepper;
@synthesize windSpeedThresholdStepper;
@synthesize redUpperBoundStepper;
@synthesize yellowUpperBoundStepper;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Initialization code here.
    }
    
    return self;
}
- (IBAction)wsPollingIntervalStepperAction:(id)sender
{
    [wsPollingIntervalText setIntValue:[wsPollingIntervalStepper intValue]];
    [settingsController setPollingInterval:[wsPollingIntervalStepper intValue]];
}

- (IBAction)snowThresholdStepperAction:(id)sender
{
    [snowThresholdText setDoubleValue:[snowThresholdStepper doubleValue]];
    [settingsController setSnowThreshold:[snowThresholdStepper doubleValue]];
}

- (IBAction)precipitationThresholdStepperAction:(id)sender
{
    [precipitationThresholdText setIntValue:[precipitationThresholdStepper intValue]];
    [settingsController setPrecipitationThreshold:[precipitationThresholdStepper intValue]];
}

- (IBAction)windSpeedThresholdStepperAction:(id)sender
{
    [windSpeedThresholdText setIntValue:[windSpeedThresholdStepper intValue]];
    [settingsController setWindSpeedThreshold:[windSpeedThresholdStepper doubleValue]];
}

- (IBAction)redUpperBoundStepperAction:(id)sender
{
    [redUpperBoundText setIntValue:[redUpperBoundStepper intValue]];
    [settingsController setRedUpperBound:[redUpperBoundStepper intValue]];
}

- (IBAction)yellowUpperBoundStepperAction:(id)sender
{
    [yellowUpperBoundText setIntValue:[yellowUpperBoundStepper intValue]];
    [settingsController setYellowUpperBound:[yellowUpperBoundStepper intValue]];
}

- (IBAction)summerModeButtonAction:(id)sender {
    [settingsController setSummerMode:summerModeButton.state];
}

- (IBAction)wsPollingIntervalTextAction:(id)sender
{
    [wsPollingIntervalStepper setIntValue:[wsPollingIntervalText intValue]];
    [settingsController setPollingInterval:[wsPollingIntervalText intValue]];
}

- (IBAction)snowThresholdTextAction:(id)sender
{
    [snowThresholdStepper setDoubleValue:[snowThresholdText doubleValue]];
    [settingsController setSnowThreshold:[snowThresholdText doubleValue]];
}

- (IBAction)precipitationThresholdTextAction:(id)sender
{
    [precipitationThresholdStepper setIntValue:[precipitationThresholdText intValue]];
    [settingsController setPrecipitationThreshold:[precipitationThresholdText intValue]];
}

- (IBAction)windSpeedThresholdTextAction:(id)sender
{
    [windSpeedThresholdStepper setIntValue:[windSpeedThresholdText intValue]];
    [settingsController setWindSpeedThreshold:[windSpeedThresholdText doubleValue]];
}

- (IBAction)redUpperBoundTextAction:(id)sender
{
    [redUpperBoundStepper setIntValue:[redUpperBoundText intValue]];
    [settingsController setRedUpperBound:[redUpperBoundText intValue]];
}

- (IBAction)yellowUpperBoundTextAction:(id)sender
{
    [yellowUpperBoundStepper setIntValue:[yellowUpperBoundText intValue]];
    [settingsController setYellowUpperBound:[yellowUpperBoundText intValue]];
}

- (IBAction)clientIPTextAction:(id)sender {
    [settingsController setClientIP:[clientIPText stringValue]];
}

/*-(id)initWithSettingsController:(SettingsController *)sController
{
    self = [super init];
    if(self)
    {
        settingsController = sController;
        [self assignSettingsControls];
    }
    return self;
}*/

-(void)assignSettingsController:(SettingsController *)sController
{
    settingsController = sController;
    [self assignSettingsControls];
}

-(Settings *)settings
{
    return [settingsController userSettings];
}

-(void)setSettingValues:(NSMutableDictionary *)settingValues
{
    
}

-(void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    NSLog(keyPath);
    NSLog(value);
}

-(void)assignSettingsControls
{
    Settings *settings = [settingsController userSettings];
    [wsPollingIntervalText setIntValue:(int)settings.pollingInterval];
    [wsPollingIntervalStepper setIntValue:(int)settings.pollingInterval];
    [snowThresholdText setDoubleValue:settings.snowThreshold];
    [snowThresholdStepper setDoubleValue:settings.snowThreshold];
    [precipitationThresholdText setIntValue:(int)settings.precipitationThreshold];
    [precipitationThresholdStepper setIntValue:(int)settings.precipitationThreshold];
    [redUpperBoundText setIntValue:(int)settings.redUpperBound];
    [redUpperBoundStepper setIntValue:(int)settings.redUpperBound];
    [yellowUpperBoundText setIntValue:(int)settings.yellowUpperBound];
    [yellowUpperBoundStepper setIntValue:(int)settings.yellowUpperBound];
    [windSpeedThresholdText setDoubleValue:settings.windSpeedThreshold];
    [windSpeedThresholdStepper setDoubleValue:settings.windSpeedThreshold];
    NSLog(@"clientIP: %@",settings.clientIP);
    [clientIPText setStringValue:settings.clientIP];
    [summerModeButton setState:settings.summerMode];

}

@end
