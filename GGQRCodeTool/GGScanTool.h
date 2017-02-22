//
//  GGScanTool.h
//  GGScanCode
//
//  Created by C on 2017/2/17.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GGScanResult)(NSArray *);

@interface GGScanTool : NSObject

@property (nonatomic, copy)GGScanResult result;

+ (instancetype)sharedInstance;

- (void)ggScanView:(UIView *)inView result:(GGScanResult)result;

- (void)ggScanView:(UIView *)inView rect:(CGRect)rect result:(GGScanResult)result;

- (void)ggScanView:(UIView *)inView canAnimation:(BOOL)canAnimation result:(GGScanResult)result;

- (void)ggScanView:(UIView *)inView scanRect:(CGRect)rect canAnimation:(BOOL)canAnimation result:(GGScanResult)result;

- (void)startRunning;

- (void)stopRunning;

@end
