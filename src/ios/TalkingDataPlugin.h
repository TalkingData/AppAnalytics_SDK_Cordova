//
//  TalkingDataPlugin.h
//  TalkingData_PhoneGap
//
//  Created by liweiqiang on 13-12-2.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface TalkingDataPlugin : CDVPlugin

// 初始化 TalkingData Analytics SDK
// command 中的值：
// appKey    : TalkingData appid, https://www.talkingdata.com/app/document_web/index.jsp?statistics
// channelId : 渠道号
- (void)init:(CDVInvokedUrlCommand*)command;

// 获取 TalkingData Device Id，并将其作为参数传入 JS 的回调函数
// command 中的值：
// callBack  : 处理 deviceId 的回调函数
- (void)getDeviceId:(CDVInvokedUrlCommand*)command;

// 设置是否记录并上报程序异常信息
// command 中的值：
// enabled   : true or false
- (void)setExceptionReportEnability:(CDVInvokedUrlCommand*)command;

// 设置是否记录并上传 iOS 平台的 signal
// command 中的值：
// enabled   : true or false
- (void)setSignalReportEnability:(CDVInvokedUrlCommand*)command;

// 设置位置经纬度
// command 中的值：
// latitude  : 纬度
// longitude : 经度  
- (void)setLocation:(CDVInvokedUrlCommand*)command;  

// 设置是否在控制台（iOS）/LogCat（Android）中打印运行时日志
// command 中的值：
// enabled   : true or false
- (void)setLogEnability:(CDVInvokedUrlCommand*)command;

// 注册事件
// command 中的值：
// accountId : 帐号ID
// type      : 帐号类型
// name      : 帐号昵称
- (void)onRegister:(CDVInvokedUrlCommand*)command;

// 登录事件
// command 中的值：
// accountId : 帐号ID
// type      : 帐号类型
// name      : 帐号昵称
- (void)onLogin:(CDVInvokedUrlCommand*)command;

// 触发自定义事件
// command 中的值：
// eventId   : 自定义事件的 eventId
- (void)onEvent:(CDVInvokedUrlCommand*)command;
    
// 触发自定义事件
// command 中的值：
// eventId:    自定义事件的 eventId
// eventLabel: 自定义事件的事件标签
- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command;

// 触发自定义事件
// command 中的值：
// eventId:    自定义事件的 eventId
// eventLabel: 自定义事件的事件标签
// eventData : 自定义事件的数据，Json 对象格式
- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command;

// 下单
// command 中的值：
// accountId : 帐户ID
// order     : 订单详情
- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command;

// 支付订单
// command 中的值：
// accountId : 帐户ID
// payType   : 支付类型
// order     : 订单详情
- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command;

// 查看商品
// command 中的值：
// itemId    : 商品ID
// category  : 商品类别
// name      : 商品名称
// unitPrice : 商品单价
- (void)onViewItem:(CDVInvokedUrlCommand*)command;

// 添加商品到购物车
// command 中的值：
// itemId    : 商品ID
// category  : 商品类别
// name      : 商品名称
// unitPrice : 商品单价
// amount    : 商品数量
- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand*)command;

// 查看购物车
// shoppingCart : 购物车详情
- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 trackPageBegin 和 trackPageEnd 接口了
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPage:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageEnd 配合使用
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPageBegin:(CDVInvokedUrlCommand*)command;

// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageBegin 配合使用
// command 中的值：
// pageName  : 页面自定义名称
- (void)onPageEnd:(CDVInvokedUrlCommand*)command;

@end
