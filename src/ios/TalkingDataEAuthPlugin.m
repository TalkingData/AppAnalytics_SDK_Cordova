//
//  TalkingDataEAuthPlugin.m
//  TalkingData
//
//  Created by liweiqiang on 15-12-2.
//
//

#import "TalkingDataEAuthPlugin.h"
#import "TalkingDataEAuth.h"

@interface TalkingDataEAuthPlugin () <TalkingDataEAuthDelegate>

@property (nonatomic, strong) NSString *callbackId;

@end

@implementation TalkingDataEAuthPlugin

- (void)init:(CDVInvokedUrlCommand*)command {
    NSString *appId = [command.arguments objectAtIndex:0];
    if (![appId isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *secretId = [command.arguments objectAtIndex:1];
    if (![secretId isKindOfClass:[NSString class]]) {
        return;
    }
    [TalkingDataEAuth initEAuth:appId secretId:secretId];
}

- (void)applyAuthCode:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (![countryCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if (![mobile isKindOfClass:[NSString class]]) {
        return;
    }
    NSNumber *typeNum = [command.arguments objectAtIndex:2];
    if (![typeNum isKindOfClass:[NSNumber class]]) {
        return;
    }
    TDAuthCodeType type = [typeNum integerValue];
    NSString *accountName = [command.arguments objectAtIndex:3];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth applyAuthCode:countryCode mobile:mobile authCodeType:type accountName:accountName delegate:self];
}

- (void)reapplyAuthCode:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (![countryCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if (![mobile isKindOfClass:[NSString class]]) {
        return;
    }
    NSNumber *typeNum = [command.arguments objectAtIndex:2];
    if (![typeNum isKindOfClass:[NSNumber class]]) {
        return;
    }
    TDAuthCodeType type = [typeNum integerValue];
    NSString *accountName = [command.arguments objectAtIndex:3];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *requestId = [command.arguments objectAtIndex:4];
    if (![requestId isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth reapplyAuthCode:countryCode mobile:mobile authCodeType:type accountName:accountName requestId:requestId delegate:self];
}

- (void)isVerifyAccount:(CDVInvokedUrlCommand*)command {
    NSString *accountName = [command.arguments objectAtIndex:0];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth isVerifyAccount:accountName delegate:self];
}

- (void)isMobileMatchAccount:(CDVInvokedUrlCommand*)command {
    NSString *accountName = [command.arguments objectAtIndex:0];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *countryCode = [command.arguments objectAtIndex:1];
    if (![countryCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:2];
    if (![mobile isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth isMobileMatchAccount:accountName countryCode:countryCode mobile:mobile delegate:self];
}

- (void)bind:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (![countryCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if (![mobile isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *authCode = [command.arguments objectAtIndex:2];
    if (![authCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *accountName = [command.arguments objectAtIndex:3];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth bindEAuth:countryCode mobile:mobile authCode:authCode accountName:accountName delegate:self];
}

- (void)unbind:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (![countryCode isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if (![mobile isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *accountName = [command.arguments objectAtIndex:2];
    if (![accountName isKindOfClass:[NSString class]]) {
        return;
    }
    self.callbackId = command.callbackId;
    [TalkingDataEAuth unbindEAuth:countryCode mobile:mobile accountName:accountName delegate:self];
}

- (void)onRequestSuccess:(TDEAuthType)type requestId:(NSString *)requestId phoneNumber:(NSString *)phoneNumber phoneNumSeg:(NSArray *)phoneNumSeg {
    NSMutableArray *args = [NSMutableArray array];
    [args addObject:[NSNumber numberWithInteger:type]];
    [args addObject:requestId ?: @""];
    [args addObject:phoneNumber ?: @""];
    [args addObject:phoneNumSeg ?: @[]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:args];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toSuccessCallbackString:self.callbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
#endif
}

- (void)onRequestFailed:(TDEAuthType)type errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage {
    NSMutableArray *args = [NSMutableArray array];
    [args addObject:[NSNumber numberWithInteger:type]];
    [args addObject:[NSNumber numberWithInteger:errorCode]];
    [args addObject:errorMessage ?: @""];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsMultipart:args];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toErrorCallbackString:self.callbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
#endif
}

@end
