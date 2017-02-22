//
//  GGScanTool.m
//  GGScanCode
//
//  Created by C on 2017/2/17.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGScanTool.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GGConst.h"

@interface GGScanTool () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong)AVCaptureDeviceInput *input; //创建输入流
@property (nonatomic, strong)AVCaptureMetadataOutput *output; //创建输出流
@property (nonatomic, strong)AVCaptureSession *session;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong)UIView *inView;
@property (nonatomic, assign)CGRect rect;

@end

@implementation GGScanTool

+ (instancetype)sharedInstance {
    static GGScanTool *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GGScanTool alloc] init];
    });
    return sharedInstance;
}

- (void)ggScanView:(UIView *)inView result:(GGScanResult)result {
    [self ggScanView:inView scanRect:CGRectMake(ScreenWidth/2 - 230/2, 100, 230, 230) result:result];
}

- (void)ggScanView:(UIView *)inView rect:(CGRect)rect result:(GGScanResult)result {
    [self ggScanView:inView scanRect:rect result:result];
}

- (void)ggScanView:(UIView *)inView scanRect:(CGRect)rect result:(GGScanResult)result {
    self.inView = inView;
    if ([self.session canAddInput:self.input] && [self.session canAddOutput:self.output]) {
        [self.session addInput:_input];
        [self.session addOutput:_output];
    }
    self.rect = rect;
    self.result = result;
    
    _output.metadataObjectTypes = _output.availableMetadataObjectTypes; // //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // rectOfInterest 不可以直接在设置 output 直接设置，而需要在这个 AVCaptureInputPortFormatDescriptionDidChangeNotification 通知里设置，否则 metadataOutputRectOfInterestForRect: 转换方法会返回 (0, 0, 0, 0)。
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
        // 限制可扫描区域
        _output.rectOfInterest = [_previewLayer metadataOutputRectOfInterestForRect:rect];
    }];
    
    if (!self.backView) {
        [self addBack:rect inView:inView];
    }
    if (inView.layer.sublayers == nil || ![inView.layer.sublayers containsObject:_previewLayer]) {
        self.previewLayer.frame = inView.bounds;
        [inView.layer insertSublayer:self.previewLayer atIndex:0];
    }
    [inView addSubview:[self drawBlackShadow:rect inView:inView]]; // 添加半透明黑色阴影
    [_session startRunning];
}

/**
 添加可扫描区域透明视图用来添加类似微信的四角布局
 */
- (void)addBack:(CGRect)rect inView:(UIView *)inView {
    UIView *backView = [[UIView alloc] init];
    backView.clipsToBounds = YES;
    backView.backgroundColor = [UIColor clearColor];
    [inView addSubview:backView];
    self.backView = backView;
    backView.translatesAutoresizingMaskIntoConstraints = NO;
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:inView attribute:NSLayoutAttributeTop multiplier:1.f constant:rect.origin.y]];
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:inView attribute:NSLayoutAttributeLeft multiplier:1.f constant:rect.origin.x]];
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:rect.size.width]];
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:rect.size.height]];
}

/**
 设置半透明黑色阴影
 @param rect 可扫描区域镂空
 @param inView 父视图
 @return imgView
 */
- (UIImageView *)drawBlackShadow:(CGRect)rect inView:(UIView *)inView {
    UIImageView *referenceImage = [[UIImageView alloc] initWithFrame:inView.bounds];
    UIGraphicsBeginImageContext(referenceImage.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef black = [[UIColor colorWithRed:.0f green:.8f blue:.0f alpha:0.8f] CGColor]; // what fuck?
    CGContextSetFillColor(context, CGColorGetComponents(black));
    CGContextFillRect(context, referenceImage.bounds);
    CGContextClearRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    referenceImage.image = img;
    return referenceImage;
}

- (void)startRunning {
    if (![_session isRunning]) {
        [_session startRunning];
    }
}

- (void)stopRunning {
    if ([_session isRunning]) {
        [_session stopRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [_session stopRunning];
    if (self.result) {
        self.result(metadataObjects);
    }
}

#pragma mark - 懒加载属性
- (nullable AVCaptureDeviceInput *)input {
    if (!_input) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];//代表了物理捕获设备如:摄像机。用于配置等底层硬件设置相机的自动对焦模式。
        NSError *error;
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
        if (error) {
            return nil;
        }
    }
    return _input;
}

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];// 设置代理 在主线程里刷新
    }
    return _output;
}

- (AVCaptureSession *)session { //输入输出的中间桥梁 会话
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh; //高质量采集率
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    }
    return _previewLayer;
}

@end
