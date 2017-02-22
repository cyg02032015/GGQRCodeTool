//
//  ViewController.m
//  GGScanCode
//
//  Created by C on 2017/2/17.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "ViewController.h"
#import "GGScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)scanQRCode:(id)sender {
    GGScanViewController *vc = [[GGScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
