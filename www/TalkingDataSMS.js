var TalkingDataSMS = {
    init:function(appKey, secretId) {
        Cordova.exec(null, null, "TalkingDataSMS", "init", [appKey, secretId]);
    },
    applyAuthCode:function(countryCode, mobile, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataSMS", "applyAuthCode", [countryCode, mobile]);
    },
    reapplyAuthCode:function(countryCode, mobile, requestId, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataSMS", "reapplyAuthCode", [countryCode, mobile, requestId]);
     },
    verifyAuthCode:function(countryCode, mobile, authCode, succCallback, failedCallback) {
        Cordova.exec(succCallback, failedCallback, "TalkingDataSMS", "verifyAuthCode", [countryCode, mobile, authCode]);
   }
};

module.exports = TalkingDataSMS;
