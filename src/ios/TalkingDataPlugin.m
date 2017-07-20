//
//  TalkingDataPlugin.m
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 13-12-2.
//
//

#import "TalkingDataPlugin.h"
#import "TalkingData.h"

@interface TalkingDataPlugin ()

#if __has_feature(objc_arc)
@property (nonatomic, strong) NSString *currPageName;
#else
@property (nonatomic, retain) NSString *currPageName;
#endif

@end

@implementation TalkingDataPlugin

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
    [self.currPageName release];
}
#endif

- (NSDictionary *)jsonToDictionary:(NSString *)jsonStr {
    if (jsonStr) {
        NSError* error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (error == nil && [object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
    }
    
    return nil;
}

- (void)init:(CDVInvokedUrlCommand*)command {
    NSString *appKey = [command.arguments objectAtIndex:0];
    if (appKey == nil || [appKey isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *channelId = [command.arguments objectAtIndex:1];
    if ([channelId isKindOfClass:[NSNull class]]) {
        channelId = nil;
    }
    [TalkingData sessionStarted:appKey withChannelId:channelId];
}

- (void)getDeviceId:(CDVInvokedUrlCommand*)command {
    NSString *deviceId = [TalkingData getDeviceID];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setExceptionReportEnability:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setExceptionReportEnabled:enabled];
}

- (void)setSignalReportEnability:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setSignalReportEnabled:enabled];
}

- (void)setLocation:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    NSString *arg1 = [command.arguments objectAtIndex:1];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]] || arg1 == nil || [arg1 isKindOfClass:[NSNull class]]) {
        return;
    }
    double latitude = [arg0 doubleValue];
    double longitude = [arg1 doubleValue];
    [TalkingData setLatitude:latitude longitude:longitude];
}

- (void)setLogEnability:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setLogEnabled:enabled];
}

- (void)onRegister:(CDVInvokedUrlCommand*)command {
    NSString *accountId = [command.arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId == nil;
    }
    NSUInteger type = [[command.arguments objectAtIndex:1] unsignedIntegerValue];
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    [TalkingData onRegister:accountId type:type name:name];
}

- (void)onLogin:(CDVInvokedUrlCommand*)command {
    NSString *accountId = [command.arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId == nil;
    }
    NSUInteger type = [[command.arguments objectAtIndex:1] unsignedIntegerValue];
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    [TalkingData onLogin:accountId type:type name:name];
}

- (void)onEvent:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingData trackEvent:eventId];
}

- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    [TalkingData trackEvent:eventId label:eventLabel];
}

- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    NSDictionary *parameters = nil;
    NSString *parametersJson = [command.arguments objectAtIndex:2];
    if (![parametersJson isKindOfClass:[NSNull class]]) {
        parameters = [self jsonToDictionary:parametersJson];
    }
    [TalkingData trackEvent:eventId label:eventLabel parameters:parameters];
}

- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command {
    NSString *accountId = [command.arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSString *orderStr = [command.arguments objectAtIndex:1];
    if (![orderStr isKindOfClass:[NSString class]]) {
        orderStr = nil;
    }
    TalkingDataOrder *order = [self stringToOrder:orderStr];
    [TalkingData onPlaceOrder:accountId order:order];
}

- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command {
    NSString *accountId = [command.arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSString *payType = [command.arguments objectAtIndex:1];
    if (![payType isKindOfClass:[NSString class]]) {
        payType = nil;
    }
    NSString *orderStr = [command.arguments objectAtIndex:2];
    if (![orderStr isKindOfClass:[NSString class]]) {
        orderStr = nil;
    }
    TalkingDataOrder *order = [self stringToOrder:orderStr];
    [TalkingData onOrderPaySucc:accountId payType:payType order:order];
}

- (void)onViewItem:(CDVInvokedUrlCommand*)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = [[command.arguments objectAtIndex:3] intValue];
    [TalkingData onViewItem:itemId category:category name:name unitPrice:unitPrice];
}

- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand*)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = [[command.arguments objectAtIndex:3] intValue];
    int amount = [[command.arguments objectAtIndex:4] intValue];
    [TalkingData onAddItemToShoppingCart:itemId category:category name:name unitPrice:unitPrice amount:amount];
}

- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command {
    NSString *shoppingCartStr = [command.arguments objectAtIndex:0];
    if (!shoppingCartStr || ![shoppingCartStr isKindOfClass:[NSString class]]) {
        return;
    }
    TalkingDataShoppingCart *shoppingCart = [self stringToShoppingCart:shoppingCartStr];
    [TalkingData onViewShoppingCart:shoppingCart];
}

- (void)onPage:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (self.currPageName) {
        [TalkingData trackPageEnd:self.currPageName];
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:self.currPageName];
}

- (void)onPageBegin:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:self.currPageName];
}

- (void)onPageEnd:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingData trackPageEnd:pageName];
    self.currPageName = nil;
}

- (TalkingDataOrder *)stringToOrder:(NSString *)orderStr {
    NSDictionary *orderDic = [self jsonToDictionary:orderStr];
    TalkingDataOrder *order = [TalkingDataOrder createOrder:orderDic[@"orderId"] total:[orderDic[@"total"] intValue] currencyType:orderDic[@"currencyType"]];
    NSArray *items = orderDic[@"items"];
    for (NSDictionary *item in items) {
        [order addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return order;
}

- (TalkingDataShoppingCart *)stringToShoppingCart:(NSString *)shoppingCartStr {
    NSDictionary *shoppingCartDic = [self jsonToDictionary:shoppingCartStr];
    TalkingDataShoppingCart *shoppingCart = [TalkingDataShoppingCart createShoppingCart];
    NSArray *items = shoppingCartDic[@"items"];
    for (NSDictionary *item in items) {
        [shoppingCart addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return shoppingCart;
}

@end
