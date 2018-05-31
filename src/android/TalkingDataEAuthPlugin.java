package com.talkingdata.analytics;

import android.content.Context;

import com.tendcloud.tenddata.TalkingDataEAuth;
import com.tendcloud.tenddata.TalkingDataEAuthCallback;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class TalkingDataEAuthPlugin extends CordovaPlugin implements TalkingDataEAuthCallback {
	Context ctx;
	CallbackContext callback;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		this.ctx = cordova.getActivity().getApplicationContext();
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("init")) {
			String appId = args.getString(0);
			String secretId = args.getString(1);
			TalkingDataEAuth.initEAuth(ctx, appId, secretId);
			return true;
		} else if (action.equals("applyAuthCode")) {
			String countryCode = args.getString(0);
            String mobile = args.getString(1);
            TalkingDataEAuth.TDAuthCodeType type = this.intToAuthCodeType(args.getInt(2));
            String accountName = args.getString(3);
            callback = callbackContext;
			TalkingDataEAuth.applyAuthCode(countryCode, mobile, this, accountName, type);
			return true;
		} else if (action.equals("reapplyAuthCode")) {
            String countryCode = args.getString(0);
            String mobile = args.getString(1);
            TalkingDataEAuth.TDAuthCodeType type = this.intToAuthCodeType(args.getInt(2));
            String accountName = args.getString(3);
            String requestId = args.getString(4);
            callback = callbackContext;
            TalkingDataEAuth.reapplyAuthCode(countryCode, mobile, requestId, this, accountName, type);
			return true;
		} else if (action.equals("isVerifyAccount")) {
			String accountName = args.getString(0);
			callback = callbackContext;
			TalkingDataEAuth.isVerifyAccount(accountName, this);
			return true;
    	} else if (action.equals("isMobileMatchAccount")) {
    		String accountName = args.getString(0);
    		String countryCode = args.getString(1);
    		String mobile = args.getString(2);
    		callback = callbackContext;
    		TalkingDataEAuth.isMobileMatchAccount(countryCode, mobile, accountName, this);
    		return true;
    	} else if (action.equals("bind")) {
    		String countryCode = args.getString(0);
    		String mobile = args.getString(1);
    		String authCode = args.getString(2);
    		String accountName = args.getString(3);
    		callback = callbackContext;
    		TalkingDataEAuth.bindEAuth(countryCode, mobile, authCode, this, accountName);
    		return true;
    	} else if (action.equals("unbind")) {
    		String countryCode = args.getString(0);
    		String mobile = args.getString(1);
    		String accountName = args.getString(2);
    		callback = callbackContext;
    		TalkingDataEAuth.unbindEAuth(countryCode, mobile, accountName, this);
			return true;
		}
		return false;
	}

    private TalkingDataEAuth.TDAuthCodeType intToAuthCodeType(final int type) {
        if (type == 1) {
            return TalkingDataEAuth.TDAuthCodeType.voiceCallAuth;
        } else {
            return TalkingDataEAuth.TDAuthCodeType.smsAuth;
        }
    }


	@Override
	public void onRequestSuccess(TalkingDataEAuth.TDEAuthType type, String requestId, String phoneNumber, JSONArray phoneNumSeg) {
		try {
			List<PluginResult> params = new ArrayList<>();
			params.add(new PluginResult(PluginResult.Status.OK, type.toString()));
			params.add(new PluginResult(PluginResult.Status.OK, requestId));
			params.add(new PluginResult(PluginResult.Status.OK, phoneNumber));
            phoneNumSeg = phoneNumSeg == null ? new JSONArray() : phoneNumSeg;
			params.add(new PluginResult(PluginResult.Status.OK, phoneNumSeg));
			callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, params));
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void onRequestFailed(TalkingDataEAuth.TDEAuthType type, int errorCode, String errorMessage) {
		try {
			List<PluginResult> params = new ArrayList<>();
			params.add(new PluginResult(PluginResult.Status.ERROR, type.toString()));
			params.add(new PluginResult(PluginResult.Status.ERROR, errorCode));
			params.add(new PluginResult(PluginResult.Status.ERROR, errorMessage));
			callback.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, params));
		}catch (Exception e) {
			e.printStackTrace();
		}
    }
}
