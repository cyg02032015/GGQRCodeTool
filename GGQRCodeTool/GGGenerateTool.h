//
//  GGGenerateTool.h
//  GGScanCode
//
//  Created by C on 2017/2/20.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGGenerateTool : NSObject

/**
 生成二维码

 @param content 内容
 @return 二维码图片
 */
+ (UIImage *)generrateQRCodeWithContent:(NSString *)content;

/**
 生成二维码

 @param content 内容
 @param centerImg 中间头像图片
 @return 合成后的二维码图片
 */
+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg;

/**
 生成二维码
 
 @param content 内容
 @param centerImg 中间头像图片
 @param centerSize 中间头像尺寸
 @return 合成后的二维码图片
 */
+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg centerSize:(CGSize)centerSize;

@end
