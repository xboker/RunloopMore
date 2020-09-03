//
//  ViewController3.m
//  RunloopMore1
//
//  Created by xiekunpeng on 2020/7/14.
//  Copyright © 2020 xboker. All rights reserved.
//

#import "ViewController3.h"
#import "XThread.h"


@interface ViewController3 ()

@property (nonatomic, strong) XThread *thread2;
@property (nonatomic, strong) XThread *thread3;
@property (nonatomic, strong) XThread *thread4;
@property (nonatomic, assign) BOOL runloopStop;



@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak ViewController3 *weakSelf = self;
    
    /*
     线程的保活, 每次打开一种 case 进行测试;
     */
    
    
    
    
    /*
     case1  执行完毕后线程就会立即销毁
     */
//    XThread *thread1 = [[XThread alloc] initWithTarget:self selector:@selector(thread1Excute) object:nil];
//    [thread1 start];

    /*
     case2:
     子线程中默认没有开启runloop, 所以即使是被controller强引用, 线程内任务执行完毕后也不能再次执行其他任务, 类似僵尸对象跟着controller的销毁一起销毁;
     */
//    self.thread2 = [[XThread alloc] initWithBlock:^{
//        NSLog(@"Thread2 执行");
//    }];
//    [self.thread2 start];
//
    
    
    
    /*
     case3:
     子线程中开启runloop, 为其添加任意的souce0/souce1/timer/observer, 并让其run, 则此线程由于runloop的关系就不会被销毁;
     */
//    self.thread3 = [[XThread alloc] initWithBlock:^{
//            /*
//         我们知道runloop中如果没有任何source0/souce1/timer/observer 则runloop会立即退出;
//         所以为runloop添加source1, 然后让runloop执行run;
//         */
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init ] forMode:NSDefaultRunLoopMode];
//        /*
//         注意run的释义:If no input sources or timers are attached to the run loop, this method exits immediately; otherwise, it runs the receiver in the NSDefaultRunLoopMode by repeatedly invoking runMode:beforeDate:. In other words, this method effectively begins an infinite loop that processes data from the run loop’s input sources and timers.
//         大致翻译:  如果没有souces或者timers添加到runloop中则方法理解退出; 如果有,将在NSDefaultRunLoopMode模式下无限次执行runMode:beforeDate:来处理添加的souces和timers;
//         注意: 调用 runloop 的 run 方法则不再能取消 runloop 即使是调用了CFRunLoopStop(CFRunLoopGetCurrent()); 也只是停了其中一次循环;
//
//         */
//        [[NSRunLoop currentRunLoop] run];
//    }];
//    [self.thread3 start];
    
    
    
    /*
     case4:
     不使用 runloop 的 run 方法;  自己通过runMode:beforeDate:方法来控制 runloop 进而达到控制线程生命周期的目的;
     */
    self.runloopStop = NO;
    self.thread4 = [[XThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
        while (!weakSelf.runloopStop) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    [self.thread4 start];
    
}


/*******************************************thread1******************************************************/

- (void)thread1Excute {
    ///执行完毕后线程就销毁了
    NSLog(@"thread1执行 线程: %@", [NSThread currentThread]);
}


/*******************************************thread2******************************************************/
- (void)thread2Excute {
    NSLog(@"thread2执行 线程: %@", [NSThread currentThread]);
}

- (IBAction)thread2Run:(id)sender {
    ///即使再次调用也没用, 因为子线程内没有开启runloop
    [self performSelector:@selector(thread2Excute) onThread:self.thread2 withObject:nil waitUntilDone:NO];
}

- (IBAction)thread2Kill:(id)sender {
}


/*******************************************thread3******************************************************/

- (void)thread3Excute {
    NSLog(@"thread3执行 线程: %@", [NSThread currentThread]);
}

- (void)thread3Dealloc{
    NSLog(@"thread3 即将销毁?");
    CFRunLoopStop(CFRunLoopGetCurrent());
}
- (IBAction)thread3Run:(id)sender {
    [self performSelector:@selector(thread3Excute) onThread:self.thread3 withObject:nil waitUntilDone:NO];
}
- (IBAction)thread3Kill:(id)sender {
    [self performSelector:@selector(thread3Dealloc) onThread:self.thread3 withObject:nil waitUntilDone:NO];
    NSLog(@"如果上面waitUntilDone = YES, 则线程内方法执行完毕才能执行这里, waitUntilDone = NO, 则是并行执行;");

}


/*******************************************thread4******************************************************/
- (void)thread4Excute {
    NSLog(@"thread4执行 线程: %@", [NSThread currentThread]);
}

- (void)thread4Dealloc{
    NSLog(@"thread4执行销毁, 当前 controller 销毁时线程销毁");
    CFRunLoopStop(CFRunLoopGetCurrent());
}
- (IBAction)thread4Run:(id)sender {
    [self performSelector:@selector(thread4Excute) onThread:self.thread4 withObject:nil waitUntilDone:NO];

}
- (IBAction)thread4Kill:(id)sender {
    self.runloopStop = YES;
    [self performSelector:@selector(thread4Dealloc) onThread:self.thread4 withObject:nil waitUntilDone:YES];
    NSLog(@"如果上面waitUntilDone = YES, 则线程内方法执行完毕才能执行这里, waitUntilDone = NO, 则是并行执行;");
}



- (void)dealloc {
    NSLog(@"ControllerDealloc: %s", __func__);
}


@end
