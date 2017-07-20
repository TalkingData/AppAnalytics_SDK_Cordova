//
//  TalkingDataSMSPlugin.h
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 15-12-2.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface TalkingDataSMSPlugin : CDVPlugin
- (void)init:(CDVInvokedUrlCommand*)command;
- (void)applyAuthCode:(CDVInvokedUrlCommand*)command;
- (void)reapplyAuthCode:(CDVInvokedUrlCommand*)command;
- (void)verifyAuthCode:(CDVInvokedUrlCommand*)command;
@end
