//
//  ViewController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/12.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "LoginDataController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *gotoHomeButton;
@property (nonatomic, strong) LoginDataController  *loginDataController;

@end

@implementation ViewController


#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.gotoHomeButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.gotoHomeButton.frame = CGRectMake(100, 200, 100, 100);
}

#pragma mark --event response
- (void)buttonClick
{
    [self.loginDataController requestToLoginWithParams:@{@"mobile":@"13111111111",@"password":[self md5:@"123456"]} callBack:^(NSError * _Nullable error, NSDictionary * _Nullable errorMessage, RTAPIManagerErrorType errorType) {
        if (error == nil) {
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
                [self presentViewController:nav animated:YES completion:nil];
        }else
        {
            
        }
    }];
    

}

#pragma mark --getter&setter
- (UIButton *)gotoHomeButton
{
    if (_gotoHomeButton == nil) {
        _gotoHomeButton = [[UIButton alloc] init];
        [_gotoHomeButton setTitle:@"登录去主页" forState:UIControlStateNormal];
        _gotoHomeButton.backgroundColor = [UIColor blueColor];
        [_gotoHomeButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoHomeButton;
}

- (LoginDataController *)loginDataController
{
    if (_loginDataController == nil) {
        _loginDataController = [[LoginDataController alloc] init];
    }
    return _loginDataController;
}

- (NSString *)md5:(NSString *)password
{
    const char *cStr = [password UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
