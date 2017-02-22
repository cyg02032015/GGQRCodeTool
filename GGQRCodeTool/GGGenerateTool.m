//
//  GGGenerateTool.m
//  GGScanCode
//
//  Created by C on 2017/2/20.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGGenerateTool.h"

@implementation GGGenerateTool

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content {
    return [self generrateQRCodeWithContent:content centerImg:nil centerSize:CGSizeMake(80, 80)];
}

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg {
    return [self generrateQRCodeWithContent:content centerImg:centerImg centerSize:CGSizeMake(80, 80)];
}

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg centerSize:(CGSize)centerSize {
    // 创建一个二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *inputStr = content;
    // 设置输入的内容  输入的内容必须是NSData
    NSData *data = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    // 设置滤镜的纠错率
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 取出生成的图片
    CIImage *outputImg = filter.outputImage;
    // 去除的图片很小所以会显示模糊 所以要放大
    CGAffineTransform transform = CGAffineTransformMakeScale(20, 20);
    outputImg = [outputImg imageByApplyingTransform:transform];
    UIImage *img = [UIImage imageWithCIImage:outputImg];
    if (centerImg) {
        img = [self createCenterImgWithImg:img centerImg:centerImg centerSize:centerSize];
    }
    return img;
}

+ (UIImage *)createCenterImgWithImg:(UIImage *)sourceImg centerImg:(UIImage *)centerImg centerSize:(CGSize)centerSize {
    CGSize size = sourceImg.size;
    UIGraphicsBeginImageContext(size);
    // 绘制大图片
    [sourceImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGFloat w = centerSize.width;
    CGFloat h = centerSize.height;
    CGFloat x = (size.width - w) * 0.5;
    CGFloat y = (size.height - h) * 0.5;
    // 绘制小图片
    [centerImg drawInRect:CGRectMake(x, y, w, h)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

@end
