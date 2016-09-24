//
//  ViewController.h
//  TigerFlic
//
//  Created by Isshu Rakusai on 9/22/16.
//  Copyright © 2016 Isshu Rakusai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <fliclib/fliclib.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController<SCLFlicManagerDelegate, SCLFlicButtonDelegate>

@property NSUInteger count;
@property CFTimeInterval startTime;
@property NSMutableDictionary *sounds;
@property NSMutableDictionary *counts;
@property NSMutableDictionary *startTimes;

- (void)loadSound:(NSString *) name;
- (void)playSound:(NSString *) name;

@end

