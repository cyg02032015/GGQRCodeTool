//
//  GGGenerateTool.h
//  GGScanCode
//
//  Created by C on 2017/2/20.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGGenerateTool : NSObject

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content;

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg;

+ (UIImage *)generrateQRCodeWithContent:(NSString *)content centerImg:(UIImage *)centerImg centerSize:(CGSize)centerSize;

@end
