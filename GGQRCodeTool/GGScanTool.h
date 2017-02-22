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

@property (nonatomic, weak)UIView *backView;

@property (nonatomic, copy)GGScanResult result;

+ (instancetype)sharedInstance;

/**
 创建扫描二维码的视图

 @param inView 控制器view
 @param result 扫码结果
 */
- (void)ggScanView:(UIView *)inView result:(GGScanResult)result;

/**
 创建扫描二维码的视图

 @param inView 控制器view
 @param rect 可扫描区域
 @param result 扫码结果
 */
- (void)ggScanView:(UIView *)inView rect:(CGRect)rect result:(GGScanResult)result;

/**
 创建扫描二维码的视图

 @param inView 控制器view
 @param rect 可扫描区域 默认宽高230 距上高度100 居中
 @param result 扫码结果
 */
- (void)ggScanView:(UIView *)inView scanRect:(CGRect)rect result:(GGScanResult)result;

/**
 开始扫描
 */
- (void)startRunning;

/**
 结束扫描
 */
- (void)stopRunning;

@end
