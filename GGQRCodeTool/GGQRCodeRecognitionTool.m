//
//  GGQRCodeRecognitionTool.m
//  GGScanCode
//
//  Created by C on 2017/2/21.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGQRCodeRecognitionTool.h"

@implementation GGQRCodeRecognitionTool

+ (NSMutableArray *)recognitionWithQRCode:(UIImage *)qrImage {
    // 创建二维码探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    // 探测图片特征
    CIImage *imageCI = [CIImage imageWithData:UIImagePNGRepresentation(qrImage)];
    NSArray *features = [detector featuresInImage:imageCI];
    // 遍历特征, 打印结果
    NSMutableArray *strs = [NSMutableArray array];
    for (CIQRCodeFeature *feature in features) {
        [strs addObject:feature.messageString];
    }
    return strs;
}

@end
