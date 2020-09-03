//
//  ViewController2.m
//  RunloopMore1
//
//  Created by xiekunpeng on 2020/7/14.
//  Copyright © 2020 xboker. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     解决界面拖动时NSTimer失效的问题;
     正常情况下, NSTimer都是添加在DefaultMode模式下; 一旦界面拖动时Runloop就会切换模式到TrackingMode模式下, NSTimer就会暂时失效;
     解决方案:将NStimer添加到Runloop的CommonMode模式下;
     */
    static NSInteger i = 1;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"执行次数:  %ld", i ++);
    }];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
 }




@end
