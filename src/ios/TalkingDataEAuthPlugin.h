//
//  TalkingDataEAuthPlugin.h
//  TalkingData
//
//  Created by liweiqiang on 15-12-2.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface TalkingDataEAuthPlugin : CDVPlugin
- (void)init:(CDVInvokedUrlCommand*)command;
- (void)applyAuthCode:(CDVInvokedUrlCommand*)command;
- (void)reapplyAuthCode:(CDVInvokedUrlCommand*)command;
- (void)isVerifyAccount:(CDVInvokedUrlCommand*)command;
- (void)isMobileMatchAccount:(CDVInvokedUrlCommand*)command;
- (void)bind:(CDVInvokedUrlCommand*)command;
- (void)unbind:(CDVInvokedUrlCommand*)command;
@end
