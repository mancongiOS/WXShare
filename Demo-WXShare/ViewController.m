//
//  ViewController.m
//  Demo-WXShare
//
//  Created by goulela on 16/8/25.
//  Copyright © 2016年 bububa. All rights reserved.
//

#import "ViewController.h"

#import "WXApi.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 接收分享回调通知
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];
    [self basicSetting];
    
    // AppID：wxbbf0646591e4a6d0
    
    
    // 检查是否装了微信
    if ([WXApi isWXAppInstalled])
    {
        
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonClciked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(100, 210, 100, 100);
    [button1 addTarget:self action:@selector(ButtonOneClciked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor redColor];
    button2.frame = CGRectMake(100, 320, 100, 100);
    [button2 addTarget:self action:@selector(buttonTwoClciked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)getOrderPayResult:(NSNotification *)notification
{
    // 注意通知内容类型的匹配
    if (notification.object == 0)
    {
        NSLog(@"分享成功");
    }
}


/**
 scene: 发送的目标场景,可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline),默认发送到会话.
        1.分享或收藏的目标场景，通过修改scene场景值实现。
        2.发送到聊天界面——WXSceneSession
        3.发送到朋友圈——WXSceneTimeline
        4.添加到微信收藏——WXSceneFavorite
 */


/** bText:
 发送消息的类型.包括文本消息和多媒体消息两种.两者只能选择其一.不能同时发送文本和多媒体消息.
 
 */

#pragma mark - 系统代理

#pragma mark - 点击事件

#pragma mark 文字类型分享
- (void)buttonClciked
{
    
    /**  SendMessageToWXReq 文字分享内容的类
     1. text 文字分享的内容
     2. bText 发送消息的类型
     3. scene 发送的目标场景
     */
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
    req.text = @"分享的内容";
    req.bText = YES;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

#pragma mark 图片类型分享
- (void)ButtonOneClciked
{
    /**  WXMediaMessage 多媒体分享的类
     1. setThumbImage 设置缩略图
     */
    WXMediaMessage * message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"black"]];
    
    WXImageObject * imageObject = [WXImageObject object];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"seeall@1x" ofType:@"png"];
    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

#pragma mark 网页类型分享
- (void)buttonTwoClciked
{
    WXMediaMessage * message = [WXMediaMessage message];
    message.title = @"标题";
    message.description = @"副标题";
    [message setThumbImage:[UIImage imageNamed:@"seeall@1x"]];
    
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"www.baidu.com";
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting
{
    self.title = @"";
}

#pragma mark - setter & getter
@end
