//
//  GGGenerateViewController.m
//  GGScanCode
//
//  Created by C on 2017/2/21.
//  Copyright © 2017年 YoungKook. All rights reserved.
//

#import "GGGenerateViewController.h"
#import "GGQRCodeTool.h"

@interface GGGenerateViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, copy)NSString *content;

@end

@implementation GGGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _content = @"";
    [_textField addTarget:self action:@selector(getText:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)generate:(id)sender {
    UIImage *img = [GGGenerateTool generateQRCodeWithContent:_content centerImg:[UIImage imageNamed:@"WechatIMG25.jpeg"]];
    _imgView.image = img;
}
- (void)getText:(UITextField *)sender {
    _content = sender.text;
    GGLog(@"%@", sender.text);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

@end
