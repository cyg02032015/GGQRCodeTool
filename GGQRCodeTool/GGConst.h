//
//  GGConst.h
//  GGScanCode
//
//  Created by C on 2017/2/17.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define GGLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define GGLog(format, ...)
#endif

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
