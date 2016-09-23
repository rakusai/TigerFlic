//
//  ViewController.m
//  TigerFlic
//
//  Created by Isshu Rakusai on 9/22/16.
//  Copyright © 2016 Isshu Rakusai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"view did load");
    
    NSString *app_id = @"4032e602-be74-4103-bc9f-aa0538e2e72b";
    NSString *app_secret = @"8ea7013a-ae38-4392-b344-08e3aeafb6bb";

    [SCLFlicManager configureWithDelegate:self defaultButtonDelegate:self appID:app_id appSecret:app_secret backgroundExecution:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)flicManager:(SCLFlicManager *)manager didGrabFlicButton:(SCLFlicButton *)button withError:(NSError *)error; {
    if (error) {
        NSLog(@"Could not grab: %@", error);
    }
    
    // un-comment the following line if you need lower click latency for your application
    // this will consume more battery so don't over use it
    button.lowLatency = YES;
}

- (void) flicButton:(SCLFlicButton *) button didReceiveButtonDown:(BOOL) queued age: (NSInteger) age; {
    NSLog(@"Yey, it works");
}

@end
