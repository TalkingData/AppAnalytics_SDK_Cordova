//
//  TalkingDataSMSPlugin.m
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 15-12-2.
//
//

#import "TalkingDataSMSPlugin.h"
#import "TalkingDataSMS.h"

@interface TalkingDataSMSPlugin () <TalkingDataSMSDelegate>

#if __has_feature(objc_arc)
@property (nonatomic, strong) NSString *applyCallbackId;
@property (nonatomic, strong) NSString *verifyCallbackId;
#else
@property (nonatomic, retain) NSString *applyCallbackId;
@property (nonatomic, retain) NSString *verifyCallbackId;
#endif

@end

@implementation TalkingDataSMSPlugin

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
    [self.applyCallbackId release];
    [self.verifyCallbackId release];
}
#endif

- (void)init:(CDVInvokedUrlCommand*)command {
    NSString *appKey = [command.arguments objectAtIndex:0];
    if (appKey == nil || [appKey isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *secretId = [command.arguments objectAtIndex:1];
    if ([secretId isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingDataSMS init:appKey withSecretId:secretId];
}

- (void)applyAuthCode:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (countryCode == nil || [countryCode isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if ([mobile isKindOfClass:[NSNull class]]) {
        return;
    }
    self.applyCallbackId = command.callbackId;
    [TalkingDataSMS applyAuthCode:countryCode mobile:mobile delegate:self];
}

- (void)reapplyAuthCode:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (countryCode == nil || [countryCode isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if ([mobile isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *requestId = [command.arguments objectAtIndex:2];
    if ([requestId isKindOfClass:[NSNull class]]) {
        return;
    }
    self.applyCallbackId = command.callbackId;
    [TalkingDataSMS reapplyAuthCode:countryCode mobile:mobile requestId:requestId delegate:self];
}

- (void)verifyAuthCode:(CDVInvokedUrlCommand*)command {
    NSString *countryCode = [command.arguments objectAtIndex:0];
    if (countryCode == nil || [countryCode isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *mobile = [command.arguments objectAtIndex:1];
    if ([mobile isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *authCode = [command.arguments objectAtIndex:2];
    if ([authCode isKindOfClass:[NSNull class]]) {
        return;
    }
    self.verifyCallbackId = command.callbackId;
    [TalkingDataSMS verifyAuthCode:countryCode mobile:mobile authCode:authCode delegate:self];
}

- (void)onApplySucc:(NSString *)requestId {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:requestId];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toSuccessCallbackString:_applyCallbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:_applyCallbackId];
#endif
}

- (void)onApplyFailed:(int)errorCode errorMessage:(NSString *)errorMessage {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:errorCode];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toErrorCallbackString:_applyCallbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:_applyCallbackId];
#endif
}

- (void)onVerifySucc:(NSString *)requestId {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:requestId];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toSuccessCallbackString:_verifyCallbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:_verifyCallbackId];
#endif
}

- (void)onVerifyFailed:(int)errorCode errorMessage:(NSString *)errorMessage {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:errorCode];
#if CORDOVA_VERSION_MIN_REQUIRED < __CORDOVA_3_6_0
    [self writeJavascript:[pluginResult toErrorCallbackString:_verifyCallbackId]];
#else
    [self.commandDelegate sendPluginResult:pluginResult callbackId:_verifyCallbackId];
#endif
}

@end
