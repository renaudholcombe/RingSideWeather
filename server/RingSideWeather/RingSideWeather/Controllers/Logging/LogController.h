//
//  LogController.h
//  EquilateralBlaster
//
//  Created by Renaud Holcombe on 9/16/12.
//  Copyright (c) 2012 Renaud Holcombe. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DatabaseController.h"
//#import "LogViewController.h"

@interface LogController : NSObject {
    NSOperationQueue *operationQueue;
//@private DatabaseController *dbController;
  //  LogViewController *logViewController;
   // DiagnosticsViewController *diagnosticsViewController;
    
}

//@property (atomic, retain) LogViewController *logViewController;

//-(id) initWithDiagnosticsViewController: (DiagnosticsViewController *)DVController;
-(void) saveToLog:(NSString *) message;

@end
