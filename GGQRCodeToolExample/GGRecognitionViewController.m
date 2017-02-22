//
//  GGRecognitionViewController.m
//  GGScanCode
//
//  Created by C on 2017/2/21.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGRecognitionViewController.h"
#import "GGQRCodeTool.h"

@interface GGRecognitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GGRecognitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)]];
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)recognizer {
    NSArray *strs = [GGQRCodeRecognitionTool recognitionWithQRCode:_imageView.image];
    GGLog(@"strs = %@", strs);
}


@end
