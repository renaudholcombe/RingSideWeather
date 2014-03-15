//
//  WeatherWebServiceController.h
//  RingSideWeather
//
//  Created by Renaud Holcombe on 12/30/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"
#import "SettingsController.h"
#import "LogController.h"

//protocol definition for weather passing
@protocol WeatherWebServiceControllerDelegate <NSObject>
-(void)newWeatherReceived:(Weather *)weather;
@end
//protocol definition end

@interface WeatherWebServiceController : NSObject <ParseOperationDelegate>
{
    NSURLConnection *weatherConnection;
    NSMutableData *weatherData;
    NSMutableData *tempWeatherData;
    NSOperationQueue *operationQueue; //copying from the 'Seismic' example project.  Not sure that I'll need it, but just dropping it in there for good measure.
    NSDate *lastDataDate;
    LogController *logController;
    SettingsController *settingsController;

    
    
}

@property id<WeatherWebServiceControllerDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *weatherConnection;
@property (nonatomic, retain) NSMutableData *weatherData;
@property (nonatomic, retain) NSMutableData *tempWeatherData;
@property (nonatomic, retain) NSOperationQueue *operationQueue;
@property (nonatomic, retain) NSDate *lastDataDate;
@property (nonatomic, retain) LogController *logController;

-(id)initWithLogController:(LogController *)logger withSettingsController:(SettingsController *) settingsHelper;
-(NSMutableData *)getWeatherData;
-(NSDate *)getLastDataDate;
-(void)forceWeatherRefresh;
-(void)startPollingThread;

@end
