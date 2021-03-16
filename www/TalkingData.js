var exec = require('cordova/exec');

var TalkingData = {

    /**
     * 初始化 TalkingData App Analytics SDK
     * @param {String}  appId           : TalkingData AppID
     * @param {String}  channelId       : 渠道号
     */
    init:function(appId, channelId) {
        exec(null, null, "TalkingData", "init", [appId, channelId]);
    },

    /**
     * 设置是否打印日志
     * @param {Boolean} enabled         : true or false
     */
    setLogEnability:function(enabled) {
        exec(null, null, "TalkingData", "setLogEnability", [enabled]);
    },

    /**
     * 获取 TDID，并将其作为参数传入 JS 的回调函数
     * @param {Object}  callBack        : 处理 TDID 的回调函数
     */
    getDeviceId:function(callBack) {
        exec(callBack, null, "TalkingData", "getDeviceId", []);
    },

    /**
     * 获取 OAID，并将其作为参数传入 JS 的回调函数
     * @param {Object}  callBack        : 处理 OAID 的回调函数
     */
    getOAID: function(callBack) {
        exec(callBack, null, "TalkingData", "getOAID", []);
    },

    /**
     * 设置是否记录并上报程序异常信息
     * @param {Boolean} enabled         : true or false
     */
    setExceptionReportEnability:function(enabled) {
        exec(null, null, "TalkingData", "setExceptionReportEnability", [enabled]);
    },

    /**
     * 设置是否记录并上传 iOS 平台的 signal
     * @param {Boolean} enabled         : true or false
     */
    setSignalReportEnability:function(enabled) {
        exec(null, null, "TalkingData", "setSignalReportEnability", [enabled]);
    },

    /**
     * 设置位置经纬度
     * @param {Number}  latitude        : 纬度
     * @param {Number}  longitude       : 经度
     */
    setLocation:function(latitude, longitude) {
        exec(null, null, "TalkingData", "setLocation", [latitude, longitude]);
    },

    /**
     * 账户类型
     */
    ProfileType: {
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

    /**
     * 注册事件
     * @param {String}  profileId       : 帐户ID
     * @param {Number}  type            : 帐户类型
     * @param {String}  name            : 帐户昵称
     */
    onRegister:function(profileId, type, name) {
        exec(null, null, "TalkingData", "onRegister", [profileId, type, name]);
    },

    /**
     登录事件
     * @param {String}  profileId       : 帐户ID
     * @param {Number}  type            : 帐户类型
     * @param {String}  name            : 帐户昵称
     */
    onLogin:function(profileId, type, name) {
        exec(null, null, "TalkingData", "onLogin", [profileId, type, name]);
    },

    /**
     * 下单
     * @param {String}  orderId         : 订单ID
     * @param {Number}  amount          : 金额
     * @param {String}  currencyType    : 货币类型
     */
    onPlaceOrder:function(orderId, amount, currencyType) {
        exec(null, null, "TalkingData", "onPlaceOrder", [orderId, amount, currencyType]);
    },

    /**
     * 支付订单
     * @param {String}  orderId         : 订单ID
     * @param {Number}  amount          : 金额
     * @param {String}  currencyType    : 货币类型
     * @param {String}  paymentType     : 支付类型
     */
    onOrderPaySucc:function(orderId, amount, currencyType, paymentType) {
        exec(null, null, "TalkingData", "onOrderPaySucc", [orderId, amount, currencyType, paymentType]);
    },

    /**
     * 取消订单
     * @param {String}  orderId         : 订单ID
     * @param {Number}  amount          : 金额
     * @param {String}  currencyType    : 货币类型
     */
    onCancelOrder:function(orderId, amount, currencyType) {
        exec(null, null, "TalkingData", "onCancelOrder", [orderId, amount, currencyType]);
    },

    /**
     * 查看商品
     * @param {String}  itemId          : 商品ID
     * @param {String}  category        : 商品类别
     * @param {String}  name            : 商品名称
     * @param {Number}  unitPrice       : 商品单价
     */
    onViewItem:function(itemId, category, name, unitPrice) {
        exec(null, null, "TalkingData", "onViewItem", [itemId, category, name, unitPrice]);
    },

    /**
     * 添加商品到购物车
     * @param {String}  itemId          : 商品ID
     * @param {String}  category        : 商品类别
     * @param {String}  name            : 商品名称
     * @param {Number}  unitPrice       : 商品单价
     * @param {Number}  amount          : 商品数量
     */
    onAddItemToShoppingCart:function(itemId, category, name, unitPrice, amount) {
        exec(null, null, "TalkingData", "onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
    },

    /**
     * 查看购物车
     * @param {Object}  shoppingCart    : 购物车详情
     */
    onViewShoppingCart:function(shoppingCart) {
        var shoppingCartJson = JSON.stringify(shoppingCart);
        exec(null, null, "TalkingData", "onViewShoppingCart", [shoppingCartJson]);
    },

    /**
     * 触发自定义事件
     * @param {String}  eventId         : 自定义事件的ID
     */
    onEvent:function(eventId) {
        exec(null, null, "TalkingData", "onEvent", [eventId]);
    },

    /**
     * 触发自定义事件
     * @param {String}  eventId         : 自定义事件的ID
     * @param {String}  eventLabel      : 自定义事件的标签
     */
    onEventWithLabel:function(eventId, eventLabel) {
        exec(null, null, "TalkingData", "onEventWithLabel", [eventId, eventLabel]);
    },

    /**
     * 触发自定义事件
     * @param {String}  eventId         : 自定义事件的ID
     * @param {String}  eventLabel      : 自定义事件的标签
     * @param {Object}  eventData       : 自定义事件的数据，Json格式
     */
    onEventWithParameters:function(eventId, eventLabel, eventData) {
        var eventDataJson = JSON.stringify(eventData);
        exec(null, null, "TalkingData", "onEventWithParameters", [eventId, eventLabel, eventDataJson]);
    },

    /**
     * 触发自定义事件
     * @param {String}  eventId         : 自定义事件的ID
     * @param {String}  eventLabel      : 自定义事件的标签
     * @param {Object}  eventData       : 自定义事件的数据，Json格式
     * @param {Number}  eventValue      : 自定义事件的数值
     */
    onEventWithValue:function(eventId, eventLabel, eventData, eventValue) {
        var eventDataJson = JSON.stringify(eventData);
        exec(null, null, "TalkingData", "onEventWithValue", [eventId, eventLabel, eventDataJson, eventValue]);
    },

    /**
     * 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageBegin 和 onPageEnd 接口了
     * @param {String}  pageName        : 页面自定义名称
     */
    onPage:function(pageName) {
        exec(null, null, "TalkingData", "onPage", [pageName]);
    },

    /**
     * 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageEnd 配合使用
     * @param {String}  pageName        : 页面自定义名称
     */
    onPageBegin:function(pageName) {
        exec(null, null, "TalkingData", "onPageBegin", [pageName]);
    },

    /**
     * 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageBegin 配合使用
     * @param {String}  pageName        : 页面自定义名称
     */
    onPageEnd:function(pageName) {
        exec(null, null, "TalkingData", "onPageEnd", [pageName]);
    },
};

module.exports = TalkingData;
