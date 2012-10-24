//
//  RootViewController.h
//  Dice Roller
//
//  Created by Dan Reed on 8/14/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIAccelerometerDelegate>{
    double spinTime;
    BOOL stillSpinning;
    int dieSides;
    int currentDieValue;
    
    IBOutlet UILabel *valueLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UISegmentedControl *segmentControl;
}

- (void) startAccelerometer;
- (void) stopAccelerometer;

- (void) spinLoop;

- (void) spinDie;
- (void) stopDie;

- (void) changeDieSides;

- (void) presentSettingsView;

@end
