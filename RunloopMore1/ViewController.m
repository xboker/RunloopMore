//
//  ViewController.m
//  RunloopMore1
//
//  Created by xiekunpeng on 2020/7/14.
//  Copyright © 2020 xboker. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
}


- (IBAction)case1:(id)sender {
    ViewController1 *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController1"];
    [self.navigationController pushViewController:c animated:YES];
}


- (IBAction)case2:(id)sender {
    ViewController2 *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)case3:(id)sender {
    ViewController3 *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController3"];
    [self.navigationController pushViewController:c animated:YES];
}


@end
