//
//  SettingsViewController.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/31/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Settings.h"
#import "SettingsController.h"
#import "Constants.h"

@interface SettingsViewController : NSViewController
{
@private SettingsController *settingsController;
}

@property (weak) IBOutlet NSTextField *wsPollingIntervalText;
@property (weak) IBOutlet NSTextField *snowThresholdText;
@property (weak) IBOutlet NSTextField *precipitationThresholdText;
@property (weak) IBOutlet NSTextField *windSpeedThresholdText;
@property (weak) IBOutlet NSTextField *redUpperBoundText;
@property (weak) IBOutlet NSTextField *yellowUpperBoundText;
@property (weak) IBOutlet NSTextField *clientIPText;
@property (weak) IBOutlet NSButton *summerModeButton;


@property (weak) IBOutlet NSStepper *wsPollingIntervalStepper;
@property (weak) IBOutlet NSStepper *snowThresholdStepper;
@property (weak) IBOutlet NSStepper *precipitationThresholdStepper;
@property (weak) IBOutlet NSStepper *windSpeedThresholdStepper;
@property (weak) IBOutlet NSStepper *redUpperBoundStepper;
@property (weak) IBOutlet NSStepper *yellowUpperBoundStepper;

@property (retain, nonatomic) Settings *settings;

- (IBAction)wsPollingIntervalStepperAction:(id)sender;
- (IBAction)snowThresholdStepperAction:(id)sender;
- (IBAction)precipitationThresholdStepperAction:(id)sender;
- (IBAction)windSpeedThresholdStepperAction:(id)sender;
- (IBAction)redUpperBoundStepperAction:(id)sender;
- (IBAction)yellowUpperBoundStepperAction:(id)sender;
- (IBAction)summerModeButtonAction:(id)sender;

- (IBAction)wsPollingIntervalTextAction:(id)sender;
- (IBAction)snowThresholdTextAction:(id)sender;
- (IBAction)precipitationThresholdTextAction:(id)sender;
- (IBAction)windSpeedThresholdTextAction:(id)sender;
- (IBAction)redUpperBoundTextAction:(id)sender;
- (IBAction)yellowUpperBoundTextAction:(id)sender;
- (IBAction)clientIPTextAction:(id)sender;


//-(id)initWithSettingsController:(SettingsController *)sController;
-(void)assignSettingsController:(SettingsController *)sController;
-(void)assignSettingsControls;

@end
