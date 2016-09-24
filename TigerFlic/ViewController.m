//
//  ViewController.m
//  TigerFlic
//
//  Created by Isshu Rakusai on 9/22/16.
//  Copyright © 2016 Isshu Rakusai. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

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
    
    self.count = 0;
    
    self.counts = [[NSMutableDictionary alloc] init];
    self.startTimes = [[NSMutableDictionary alloc] init];
    self.sounds = [[NSMutableDictionary alloc] init];
    
    //AVFoundationのインスタンス
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    //カテゴリの設定
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    //AVFoundation利用開始
    [audioSession setActive:YES error:nil];
    
    
    //効果音ファイル読み込み
    NSArray *soundNames = @[@"panch_jabu11",
                            @"bun02",
                            @"panchi03",
                            @"panchi07",
                            @"panchi10",
                            @"taoreru09",
                            @"zuza01",
                            @"kick-low1",
                            @"kick-middle1",
                            @"kick-high1",
                            @"punch-middle2",
                            @"punch-high1",
                            @"punch-high2",
                            @"tackle1",
                            @"down1",
                            @"katana-gesture1",
                            @"katana-clash1",
                            @"katana-clash2",
                            @"katana-clash3",
                            @"katana-slash1",
                            @"katana-slash2",
                            @"katana-slash3",
                            @"katana-slash5",
                            @"sword-gesture1",
                            @"sword-clash1",
                            @"sword-clash4",
                            @"sword-slash1"
                            ];
    
    for (NSString *name in soundNames) {
        if (name) {
            [self loadSound: name];
        }
    }
}

- (void)loadSound:(NSString *) name; {
    //NSLog(@"loadSound: %@", name);
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVAudioPlayer * sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    [self.sounds setObject:sound forKey:name];
}

- (void)playSound:(NSString *) name; {
    AVAudioPlayer *sound = [self.sounds objectForKey:name];
    sound.currentTime = 0;
    sound.volume = 1 - (arc4random_uniform(1000) % 3) / 10;
    [sound play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 

- (IBAction)grab:(id)sender; {
    [[SCLFlicManager sharedManager] grabFlicFromFlicAppWithCallbackUrlScheme:@"TigerFlic"];
}

- (void)flicManager:(SCLFlicManager *)manager didGrabFlicButton:(SCLFlicButton *)button withError:(NSError *)error; {
    if (error) {
        NSLog(@"Could not grab: %@", error);
        return;
    }

    NSLog(@"didGrabFlicButton: %@", button);

    // un-comment the following line if you need lower click latency for your application
    // this will consume more battery so don't over use it
    button.lowLatency = YES;
}

- (void) flicButton:(SCLFlicButton *) button didReceiveButtonDown:(BOOL) queued age: (NSInteger) age; {
    
    if (age > 0) {
        return;
    }

    bool sword = false;
    NSString *name = button.name;
    if ([name isEqualToString: @"F018cdoF"] || [name isEqualToString: @"F022cb3w"]) {
        sword = true;
    }

    NSNumber *stNumber = [self.startTimes objectForKey:name];
    CFTimeInterval startTime = [stNumber doubleValue];
    
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    startTime = CACurrentMediaTime();
    [self.startTimes setObject:[NSNumber numberWithDouble:startTime] forKey:name];

    NSNumber *stCount = [self.counts objectForKey:name];
    int count = [stCount intValue];
    
    if (elapsedTime > 1.0) {
        count = 0;
    }
    count += 1;

    [self.counts setObject:[NSNumber numberWithInt:count] forKey:name];

    NSLog(@"btn: %@: time %f count %d age:%ld", name, (double)elapsedTime, count, age);
    
    int play = 0;

    if (elapsedTime < 0.3) {
        play = 5 + arc4random_uniform(1000) % 2;
    }
    else if (count == 1) {
        play = arc4random_uniform(1000) % 2;
    }
    else if (count >= 2) {
        play = 2 + arc4random_uniform(1000) % 3;
    }
    
    if (sword) {
        switch (play) {
            case 0:
                [self playSound: @"katana-gesture1"];
                break;
            case 1:
                [self playSound: @"katana-clash1"];
                break;
            case 2:
                [self playSound: @"katana-clash2"];
                break;
            case 3:
                [self playSound: @"katana-clash3"];
                break;
            case 4:
                [self playSound: @"katana-slash5"];
                break;
            case 5:
                [self playSound: @"katana-slash2"];
                break;
            case 6:
                [self playSound: @"katana-slash3"];
                break;
        }
    } else {
        switch (play) {
            case 0:
                [self playSound: @"kick-low1"];
                break;
            case 1:
                [self playSound: @"punch-middle2"];
                break;
            case 2:
                [self playSound: @"panchi03"];
                break;
            case 3:
                [self playSound: @"kick-middle1"];
                break;
            case 4:
                [self playSound: @"punch-high1"];
                break;
            case 5:
                [self playSound: @"tackle1"];
                break;
            case 6:
                [self playSound: @"kick-high1"];
                break;
        }
    }
}

@end
