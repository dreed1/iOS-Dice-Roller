//
//  RootViewController.m
//  Dice Roller
//
//  Created by Dan Reed on 8/14/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dieSides = 6;
    [segmentControl addTarget:self
                       action:@selector(changeDieSides)
             forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:1];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(spinLoop) userInfo:nil repeats:YES];
    [self.navigationItem setTitle:@"Dice Roller"];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsView)]];
}

- (void) viewWillAppear:(BOOL)animated{
    [self startAccelerometer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - accelerometer delegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    float threshold = 1.0f;
    if(acceleration.x > threshold){
        spinTime = acceleration.x;
        stillSpinning = YES;
    }
    else if(acceleration.y >threshold){
        spinTime = acceleration.y;
        stillSpinning = YES;
    }
    else if(acceleration.z >threshold){
        spinTime = acceleration.z;
        stillSpinning = YES;
    }
}

#pragma mark - accelerometer helper methods

- (void)startAccelerometer {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval = 0.25;
}

- (void)stopAccelerometer {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = nil;
}

#pragma mark - spin loop methods
- (void) spinLoop{
    if (stillSpinning){
        spinTime -= 0.05f;
        if(spinTime <=0){
            spinTime =0;
            stillSpinning = NO;
            [self stopDie];
        }
        else{
            [self spinDie];
        }
    }
}

- (void) spinDie{
    [statusLabel setText:@"Rolling Die!"];
    currentDieValue = arc4random()%dieSides +1;
    [valueLabel setText:[NSString stringWithFormat:@"%d", currentDieValue]];
}

- (void) stopDie{
    [statusLabel setText:@"Shake to Roll!"];
    currentDieValue = arc4random()%dieSides +1;
    [valueLabel setText:[NSString stringWithFormat:@"%d", currentDieValue]];
    if(currentDieValue ==dieSides){
        [statusLabel setText:@"Fuck Yeah! Natural 20!"];
    }
    else if(currentDieValue == 1){
        [statusLabel setText:@"Awww, too bad.... NERD!"];
    }
}

- (void) changeDieSides{
    dieSides = [[segmentControl titleForSegmentAtIndex:segmentControl.selectedSegmentIndex]intValue];
}

- (void) presentSettingsView{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"LOL, Idiot!" message:@"I tricked you, there is no settings menu. Feel stupid about it." delegate:nil cancelButtonTitle:@"Yes, I am an idiot" otherButtonTitles: nil];
    [alert show];
}

@end
