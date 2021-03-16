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

- (void)init:(CDVInvokedUrlCommand*)command {
    NSString *appId = [command.arguments objectAtIndex:0];
    if (![appId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSString *channelId = [command.arguments objectAtIndex:1];
    if (![channelId isKindOfClass:[NSString class]]) {
        channelId = nil;
    }
    
    [TalkingData sessionStarted:appId withChannelId:channelId];
}

- (void)setLogEnability:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    if (![arg0 isKindOfClass:[NSNumber class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    
    [TalkingData setLogEnabled:enabled];
}

- (void)getDeviceId:(CDVInvokedUrlCommand*)command {
    NSString *deviceId = [TalkingData getDeviceID];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setExceptionReportEnability:(CDVInvokedUrlCommand*)command {
    NSNumber *arg0 = [command.arguments objectAtIndex:0];
    if (![arg0 isKindOfClass:[NSNumber class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    
    [TalkingData setExceptionReportEnabled:enabled];
}

- (void)setSignalReportEnability:(CDVInvokedUrlCommand*)command {
    NSNumber *arg0 = [command.arguments objectAtIndex:0];
    if (![arg0 isKindOfClass:[NSNumber class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    
    [TalkingData setSignalReportEnabled:enabled];
}

- (void)setLocation:(CDVInvokedUrlCommand*)command {
    NSNumber *arg0 = [command.arguments objectAtIndex:0];
    if (![arg0 isKindOfClass:[NSNumber class]]) {
        return;
    }
    double latitude = [arg0 doubleValue];
    
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if (![arg1 isKindOfClass:[NSNumber class]]) {
        return;
    }
    double longitude = [arg1 doubleValue];
    
    [TalkingData setLatitude:latitude longitude:longitude];
}

- (void)onRegister:(CDVInvokedUrlCommand*)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSUInteger type = 0;
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if ([arg1 isKindOfClass:[NSNumber class]]) {
        type = [arg1 unsignedIntegerValue];
    }
    
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    
    [TalkingData onRegister:profileId type:type name:name];
}

- (void)onLogin:(CDVInvokedUrlCommand*)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSUInteger type = 0;
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if ([arg1 isKindOfClass:[NSNumber class]]) {
        type = [arg1 unsignedIntegerValue];
    }
    
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    
    [TalkingData onLogin:profileId type:type name:name];
}

- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command {
    NSString *orderId = [command.arguments objectAtIndex:0];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    
    int amount = 0;
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if ([arg1 isKindOfClass:[NSNumber class]]) {
        amount = [arg1 intValue];
    }
    
    NSString *currencyType = [command.arguments objectAtIndex:2];
    if (![currencyType isKindOfClass:[NSString class]]) {
        currencyType = nil;
    }
    
    [TalkingData onPlaceOrder:orderId amount:amount currencyType:currencyType];
}

- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command {
    NSString *orderId = [command.arguments objectAtIndex:0];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    
    int amount = 0;
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if ([arg1 isKindOfClass:[NSNumber class]]) {
        amount = [arg1 intValue];
    }
    
    NSString *currencyType = [command.arguments objectAtIndex:2];
    if (![currencyType isKindOfClass:[NSString class]]) {
        currencyType = nil;
    }
    
    NSString *paymentType = [command.arguments objectAtIndex:3];
    if (![paymentType isKindOfClass:[NSString class]]) {
        paymentType = nil;
    }
    
    [TalkingData onOrderPaySucc:orderId amount:amount currencyType:currencyType paymentType:paymentType];
}

- (void)onCancelOrder:(CDVInvokedUrlCommand*)command {
    NSString *orderId = [command.arguments objectAtIndex:0];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    
    int amount = 0;
    NSNumber *arg1 = [command.arguments objectAtIndex:1];
    if ([arg1 isKindOfClass:[NSNumber class]]) {
        amount = [arg1 intValue];
    }
    
    NSString *currencyType = [command.arguments objectAtIndex:2];
    if (![currencyType isKindOfClass:[NSString class]]) {
        currencyType = nil;
    }
    
    [TalkingData onCancelOrder:orderId amount:amount currencyType:currencyType];
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
    
    int unitPrice = 0;
    NSNumber *arg3 = [command.arguments objectAtIndex:3];
    if ([arg3 isKindOfClass:[NSNumber class]]) {
        unitPrice = [arg3 intValue];
    }
    
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
    
    int unitPrice = 0;
    NSNumber *arg3 = [command.arguments objectAtIndex:3];
    if ([arg3 isKindOfClass:[NSNumber class]]) {
        unitPrice = [arg3 intValue];
    }
    
    int amount = 0;
    NSNumber *arg4 = [command.arguments objectAtIndex:4];
    if ([arg4 isKindOfClass:[NSNumber class]]) {
        amount = [arg4 intValue];
    }
    
    [TalkingData onAddItemToShoppingCart:itemId category:category name:name unitPrice:unitPrice amount:amount];
}

- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command {
    NSString *arg0 = [command.arguments objectAtIndex:0];
    TalkingDataShoppingCart *shoppingCart = [self stringToShoppingCart:arg0];
    if (shoppingCart == nil) {
        return;
    }
    
    [TalkingData onViewShoppingCart:shoppingCart];
}

- (void)onEvent:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (![eventId isKindOfClass:[NSString class]]) {
        return;
    }
    
    [TalkingData trackEvent:eventId];
}

- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (![eventId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if (![eventLabel isKindOfClass:[NSString class]]) {
        eventLabel = nil;
    }
    
    [TalkingData trackEvent:eventId label:eventLabel];
}

- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (![eventId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if (![eventLabel isKindOfClass:[NSString class]]) {
        eventLabel = nil;
    }
    
    NSString *arg2 = [command.arguments objectAtIndex:2];
    NSDictionary *parameters = [self jsonToDictionary:arg2];
    
    [TalkingData trackEvent:eventId label:eventLabel parameters:parameters];
}

- (void)onEventWithValue:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (![eventId isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if (![eventLabel isKindOfClass:[NSString class]]) {
        eventLabel = nil;
    }
    
    NSString *arg2 = [command.arguments objectAtIndex:2];
    NSDictionary *parameters = [self jsonToDictionary:arg2];
    
    double value = 0.0;
    NSNumber *arg3 = [command.arguments objectAtIndex:3];
    if ([arg3 isKindOfClass:[NSNumber class]]) {
        value = [arg3 doubleValue];
    }
    
    [TalkingData trackEvent:eventId label:eventLabel parameters:parameters value:value];
}

- (void)onPage:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (![pageName isKindOfClass:[NSString class]]) {
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
    if (![pageName isKindOfClass:[NSString class]]) {
        return;
    }
    
    self.currPageName = pageName;
    [TalkingData trackPageBegin:self.currPageName];
}

- (void)onPageEnd:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (![pageName isKindOfClass:[NSString class]]) {
        return;
    }
    
    [TalkingData trackPageEnd:pageName];
    self.currPageName = nil;
}

- (NSDictionary *)jsonToDictionary:(NSString *)jsonStr {
    if (![jsonStr isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSError* error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (error || ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return object;
}

- (TalkingDataOrder *)stringToOrder:(NSString *)orderStr {
    NSDictionary *orderDic = [self jsonToDictionary:orderStr];
    if (orderDic == nil) {
        return nil;
    }
    
    TalkingDataOrder *order = [TalkingDataOrder createOrder:orderDic[@"orderId"] total:[orderDic[@"total"] intValue] currencyType:orderDic[@"currencyType"]];
    NSArray *items = orderDic[@"items"];
    for (NSDictionary *item in items) {
        [order addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return order;
}

- (TalkingDataShoppingCart *)stringToShoppingCart:(NSString *)shoppingCartStr {
    NSDictionary *shoppingCartDic = [self jsonToDictionary:shoppingCartStr];
    if (shoppingCartDic == nil) {
        return nil;
    }
    
    TalkingDataShoppingCart *shoppingCart = [TalkingDataShoppingCart createShoppingCart];
    NSArray *items = shoppingCartDic[@"items"];
    for (NSDictionary *item in items) {
        [shoppingCart addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return shoppingCart;
}

@end
