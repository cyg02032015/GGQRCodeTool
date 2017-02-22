//
//  GGQRCodeRecognitionTool.h
//  GGScanCode
//
//  Created by C on 2017/2/21.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGQRCodeRecognitionTool : NSObject


/**
 二维码识别

 @param qrImage 二维码图片
 @return 识别出来的string数组
 */
+ (NSMutableArray<NSString *> *)recognitionWithQRCode:(UIImage *)qrImage;

@end
