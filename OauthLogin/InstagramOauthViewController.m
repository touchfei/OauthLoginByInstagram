//
//  InstagramOauthViewController.m
//  OauthLogin
//
//  Created by GaoFei on 2017/4/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "InstagramOauthViewController.h"
#import <WebKit/WebKit.h>

#define ClientID @""
#define RedirectUrl @""



@interface  InstagramOauthViewController()<WKNavigationDelegate>
//@property (nonatomic,strong)WKWebView *webView;

@end

@implementation InstagramOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


/**
 服务器端的Oauth授权属于2.0版本，先获取code，根据code获取access_token
 客户端的Oauth授权还是属于1.0版本的
 @"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token"
 
 */
- (void)initView{
    
    if (ClientID.length == 0 || RedirectUrl.length == 0) {
        return;
    }
    
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token",ClientID, RedirectUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlStr = [navigationAction.request URL].absoluteString;
    NSRange rang = [urlStr rangeOfString:@"access_token="];
    if (rang.length != 0) {
        
       NSString *access_token = [urlStr substringFromIndex:(rang.location + rang.length)];
        NSLog(@"url = %@,access_token = %@",urlStr,access_token);
        // 根据获取的access_token就可以请求用户的信息了
        // 此处省略一万字
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStart");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinish");
}

@end
