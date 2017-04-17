//
//  ViewController.m
//  OauthLogin
//
//  Created by GaoFei on 2017/4/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "InstagramOauthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginWithInstagram:(UIButton *)sender {
    
    InstagramOauthViewController *vc = [[InstagramOauthViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}





@end
