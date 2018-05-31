var TalkingDataEAuth = {
    init:function(appId, secretId) {
        Cordova.exec(null, null, "TalkingDataEAuth", "init", [appId, secretId]);
    },
    EAuthType: {
        TDEAuthTypeApplyCode    : 0,    // 申请认证码
        TDEAuthTypeChecker      : 1,    // 检查账号是否已认证
        TDEAuthTypePhoneMatch   : 2,    // 检查账号与手机号是否匹配
        TDEAuthTypeBind         : 3,    // 账号认证绑定
        TDEAuthTypeUnBind       : 4     // 账号认证解绑定
    },
    AuthCodeType: {
        TDAuthCodeTypeSMS       : 0,    // 短信认证
        TDAuthCodeTypeVoice     : 1     // 语音认证
    },
    applyAuthCode:function(countryCode, mobile, type, accountName, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "applyAuthCode", [countryCode, mobile, type, accountName]);
    },
    reapplyAuthCode:function(countryCode, mobile, type, accountName, requestId, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "reapplyAuthCode", [countryCode, mobile, type, accountName, requestId]);
    },
    isVerifyAccount:function(accountName, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "isVerifyAccount", [accountName]);
    },
    isMobileMatchAccount:function(accountName, countryCode, mobile, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "isMobileMatchAccount", [accountName, countryCode, mobile]);
    },
    bind:function(countryCode, mobile, authCode, accountName, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "bind", [countryCode, mobile, authCode, accountName]);
    },
    unbind:function(countryCode, mobile, accountName, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataEAuth", "unbind", [countryCode, mobile, accountName]);
    }
};

module.exports = TalkingDataEAuth;
