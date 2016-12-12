//
//  AppDelegate.m
//  Demo-WXShare
//
//  Created by goulela on 16/8/25.
//  Copyright © 2016年 bububa. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册微信
    [WXApi registerApp:@"wxbbf0646591e4a6d0" withDescription:@"测试"];
    return YES;
}

#pragma mark 跳转处理
//被废弃的方法. 但是在低版本中会用到.建议写上
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}
//被废弃的方法. 但是在低版本中会用到.建议写上

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

//新的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark 微信回调方法

- (void)onResp:(BaseResp *)resp
{
    
    /*
     WXSuccess           = 0,   成功
    WXErrCodeCommon     = -1,   普通错误类型
    WXErrCodeUserCancel = -2,   用户点击取消并返回
    WXErrCodeSentFail   = -3,    发送失败
    WXErrCodeAuthDeny   = -4,   授权失败
    WXErrCodeUnsupport  = -5,    微信不支持
     */
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        // 判断errCode 进行回调处理
        if (resp.errCode == 0)
        {
            strTitle = [NSString stringWithFormat:@"分享成功"];
        }
    }
    
    //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
    NSNotification * notification = [NSNotification notificationWithName:@"WXShare" object:resp.errStr];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


@end
