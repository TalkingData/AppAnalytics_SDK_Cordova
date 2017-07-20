package com.talkingdata.analytics;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Context;
import android.util.Log;

import com.tendcloud.tenddata.TalkingDataSMS;
import com.tendcloud.tenddata.TalkingDataSMSApplyCallback;
import com.tendcloud.tenddata.TalkingDataSMSVerifyCallback;

public class TalkingDataSMSPlugin extends CordovaPlugin implements TalkingDataSMSApplyCallback, TalkingDataSMSVerifyCallback {
	Context ctx;
	CallbackContext applyCallback;
    CallbackContext verifyCallback;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		this.ctx = cordova.getActivity().getApplicationContext();
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("init")) {
			String appKey = args.getString(0);
			String secretId = args.getString(1);
			TalkingDataSMS.init(ctx, appKey, secretId);
			return true;
		} else if (action.equals("applyAuthCode")) {
			String countryCode = args.getString(0);
            String mobile = args.getString(1);
            applyCallback = callbackContext;
			TalkingDataSMS.applyAuthCode(countryCode, mobile, this);
			return true;
		} else if (action.equals("reapplyAuthCode")) {
            String countryCode = args.getString(0);
            String mobile = args.getString(1);
            String requestId = args.getString(2);
            applyCallback = callbackContext;
            TalkingDataSMS.reapplyAuthCode(countryCode, mobile, requestId, this);
			return true;
		} else if (action.equals("verifyAuthCode")) {
            String countryCode = args.getString(0);
            String mobile = args.getString(1);
            String authCode = args.getString(2);
            verifyCallback = callbackContext;
            TalkingDataSMS.verifyAuthCode(countryCode, mobile, authCode, this);
			return true;
		}
		return false;
	}

    public void onApplySucc(String requestId) {
        applyCallback.success(requestId);
    }

    public void onApplyFailed(int errorCode, String errorMessage) {
    	Log.d("TDLog", "error message = " + errorMessage);
        applyCallback.error(errorCode);
    }

    public void onVerifySucc(String requestId) {
        verifyCallback.success(requestId);
    }

    public void onVerifyFailed(int errorCode, String errorMessage) {
    	Log.d("TDLog", "error message = " + errorMessage);
        verifyCallback.error(errorCode);
    }
}
