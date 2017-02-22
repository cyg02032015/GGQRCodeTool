//
//  GGScanViewController.m
//  GGScanCode
//
//  Created by C on 2017/2/17.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GGScanViewController ()

@end

@implementation GGScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GGScanTool sharedInstance] startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[GGScanTool sharedInstance] stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[GGScanTool sharedInstance] ggScanView:self.view result:^(NSArray *arr) {
        for (AVMetadataMachineReadableCodeObject *obj in arr) {
            GGLog(@"%@", obj.stringValue);
        }
    }];
}

- (void)dealloc {
    GGLog(@"GGScanViewController 释放");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[GGScanTool sharedInstance] startRunning];
}

@end
