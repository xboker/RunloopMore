//
//  ViewController1.m
//  RunloopMore1
//
//  Created by xiekunpeng on 2020/7/14.
//  Copyright © 2020 xboker. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     Runloop各个状态的含义
     */
    ///创建一个Observer
    CFRunLoopObserverRef CFObserver = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                NSLog(@"Runloop即将进入Runloop: kCFRunLoopEntry");
                break;
            }
               case kCFRunLoopBeforeTimers: {
                   NSLog(@"Runloop即将处理Timer: kCFRunLoopBeforeTimers");
                   break;
               }
                case kCFRunLoopBeforeSources: {
                    NSLog(@"Runloop即将处理Source: kCFRunLoopBeforeSources");
                    break;
                }
                case kCFRunLoopBeforeWaiting: {
                    NSLog(@"Runloop即将进入休眠: kCFRunLoopBeforeWaiting");
                    break;
                }
                case kCFRunLoopAfterWaiting: {
                    NSLog(@"Runloop从休眠中唤醒: kCFRunLoopAfterWaiting");
                    break;
                }
                case kCFRunLoopExit: {
                    NSLog(@"Runloop即将退出: kCFRunLoopExit");
                }
            default:
                break;
        }
    });
    ///为主线程的Runloop添加Observer
    CFRunLoopAddObserver(CFRunLoopGetMain(), CFObserver, kCFRunLoopCommonModes);
    ///CF框架下Create或者Copy的对象要进行释放
    CFRelease(CFObserver);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    
}

 
@end
