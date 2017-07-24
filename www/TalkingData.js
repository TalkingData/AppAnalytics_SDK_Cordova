/*  
    Javascript interface of Cordova plugin for TalkingData Analytics SDK 
*/

var TalkingData = {

    // 初始化 TalkingData Analytics SDK
    // appKey    : TalkingData appid, https://www.talkingdata.com/app/document_web/index.jsp?statistics
    // channelId : 渠道号
    init:function(appKey, channelId) {
        cordova.exec(null, null, "TalkingData", "init", [appKey, channelId]);
    },

    setAntiCheatingEnabled:function(enabled) {
        cordova.exec(null, null, "TalkingData", "setAntiCheatingEnabled", [enabled]);
    },

    AccountType: {
        ANONYMOUS   : 0,
        REGISTERED  : 1,
        SINA_WEIBO  : 2,
        QQ          : 3,
        QQ_WEIBO    : 4,
        ND91        : 5,
        WEIXIN      : 6,
        TYPE1       : 11,
        TYPE2       : 12,
        TYPE3       : 13,
        TYPE4       : 14,
        TYPE5       : 15,
        TYPE6       : 16,
        TYPE7       : 17,
        TYPE8       : 18,
        TYPE9       : 19,
        TYPE10      : 20
    },

    // 注册事件
    // accountId : 帐户ID
    // type      : 帐户类型
    // name      : 帐户昵称
    onRegister:function(accountId, type, name) {
        cordova.exec(null, null, "TalkingData", "onRegister", [accountId, type, name]);
    },

    // 登录事件
    // accountId : 帐户ID
    // type      : 帐户类型
    // name      : 帐户昵称
    onLogin:function(accountId, type, name) {
        cordova.exec(null, null, "TalkingData", "onLogin", [accountId, type, name]);
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    onEvent:function(eventId) {
        cordova.exec(null, null, "TalkingData", "onEvent", [eventId]);
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    onEventWithLabel:function(eventId, eventLabel) {
        cordova.exec(null, null, "TalkingData", "onEventWithLabel", [eventId, eventLabel]);
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    // eventData : 自定义事件的数据，Json 对象格式
    onEventWithParameters:function(eventId, eventLabel, eventData) {
        var eventDataJson = JSON.stringify(eventData);
        cordova.exec(null, null, "TalkingData", "onEventWithParameters", [eventId, eventLabel, eventDataJson]);
    },

    // 下单
    // accountId : 帐户ID
    // order     : 订单详情
    onPlaceOrder:function(accountId, order) {
        var orderJson = JSON.stringify(order);
        cordova.exec(null, null, "TalkingData", "onPlaceOrder", [accountId, orderJson]);
    },

    // 支付订单
    // accountId : 帐户ID
    // payType   : 支付类型
    // order     : 订单详情
    onOrderPaySucc:function(accountId, payType, order) {
        var orderJson = JSON.stringify(order);
        cordova.exec(null, null, "TalkingData", "onOrderPaySucc", [accountId, payType, orderJson]);
    },

    // 查看商品
    // itemId    : 商品ID
    // category  : 商品类别
    // name      : 商品名称
    // unitPrice : 商品单价
    onViewItem:function(itemId, category, name, unitPrice) {
        cordova.exec(null, null, "TalkingData", "onViewItem", [itemId, category, name, unitPrice]);
    },

    // 添加商品到购物车
    // itemId    : 商品ID
    // category  : 商品类别
    // name      : 商品名称
    // unitPrice : 商品单价
    // amount    : 商品数量
    onAddItemToShoppingCart:function(itemId, category, name, unitPrice, amount) {
        cordova.exec(null, null, "TalkingData", "onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
    },

    // 查看购物车
    // shoppingCart : 购物车详情
    onViewShoppingCart:function(shoppingCart) {
        var shoppingCartJson = JSON.stringify(shoppingCart);
        cordova.exec(null, null, "TalkingData", "onViewShoppingCart", [shoppingCartJson]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageBegin 和 onPageEnd 接口了
    // pageName  : 页面自定义名称
    onPage:function(pageName) {
        cordova.exec(null, null, "TalkingData", "onPage", [pageName]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageEnd 配合使用
    // pageName  : 页面自定义名称
    onPageBegin:function(pageName) {
        cordova.exec(null, null, "TalkingData", "onPageBegin", [pageName]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageBegin 配合使用
    // pageName  : 页面自定义名称
    onPageEnd:function(pageName) {
        cordova.exec(null, null, "TalkingData", "onPageEnd", [pageName]);
    },

    // 设置位置经纬度
    // latitude  : 纬度
    // longitude : 经度
    setLocation:function(latitude, longitude) {
        cordova.exec(null, null, "TalkingData", "setLocation", [latitude, longitude]);
    },

    // 获取 TalkingData Device Id，并将其作为参数传入 JS 的回调函数
    // callBack  : 处理 deviceId 的回调函数
    getDeviceId:function(callBack) {
        cordova.exec(callBack, null, "TalkingData", "getDeviceId", []);
    },

    // 设置是否记录并上报程序异常信息
    // enabled   : true or false
    setExceptionReportEnability:function(enabled) {
        cordova.exec(null, null, "TalkingData", "setExceptionReportEnability", [enabled]);
    },

    // 设置是否记录并上传 iOS 平台的 signal
    // enabled   : true or false
    setSignalReportEnability:function(enabled) {
        cordova.exec(null, null, "TalkingData", "setSignalReportEnability", [enabled]);
    },

    // 设置是否在控制台（iOS）/LogCat（Android）中打印运行时日志
    // enabled   : true or false
    setLogEnability:function(enabled) {
        cordova.exec(null, null, "TalkingData", "setLogEnability", [enabled]);
    }
};

module.exports = TalkingData;
