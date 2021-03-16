#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface TalkingDataPlugin : CDVPlugin

- (void)init:(CDVInvokedUrlCommand*)command;
- (void)setLogEnability:(CDVInvokedUrlCommand*)command;
- (void)getDeviceId:(CDVInvokedUrlCommand*)command;
- (void)setExceptionReportEnability:(CDVInvokedUrlCommand*)command;
- (void)setSignalReportEnability:(CDVInvokedUrlCommand*)command;
- (void)setLocation:(CDVInvokedUrlCommand*)command;
- (void)onRegister:(CDVInvokedUrlCommand*)command;
- (void)onLogin:(CDVInvokedUrlCommand*)command;
- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command;
- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command;
- (void)onCancelOrder:(CDVInvokedUrlCommand*)command;
- (void)onViewItem:(CDVInvokedUrlCommand*)command;
- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand*)command;
- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command;
- (void)onEvent:(CDVInvokedUrlCommand*)command;
- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command;
- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command;
- (void)onEventWithValue:(CDVInvokedUrlCommand*)command;
- (void)onPage:(CDVInvokedUrlCommand*)command;
- (void)onPageBegin:(CDVInvokedUrlCommand*)command;
- (void)onPageEnd:(CDVInvokedUrlCommand*)command;

@end
