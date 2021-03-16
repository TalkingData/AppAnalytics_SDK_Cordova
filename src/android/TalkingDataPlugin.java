package com.talkingdata.analytics;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.content.Context;

import com.tendcloud.tenddata.TCAgent;
import com.tendcloud.tenddata.TDProfile;
import com.tendcloud.tenddata.ShoppingCart;


public class TalkingDataPlugin extends CordovaPlugin {
    Activity act;
    Context ctx;
    String currPageName;
    
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.act = cordova.getActivity();
        this.ctx = cordova.getActivity().getApplicationContext();
    }
    
    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        TCAgent.onResume(act);
    }
    
    @Override
    public void onPause(boolean multitasking) {
        super.onPause(multitasking);
        TCAgent.onPause(act);
    }
    
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("init")) {
            String appId = args.getString(0);
            String channelId = args.getString(1);
            TCAgent.init(ctx, appId, channelId);
            return true;
        } else if (action.equals("getDeviceId")) {
            String deviceId = TCAgent.getDeviceId(ctx);
            callbackContext.success(deviceId);
            return true;
        } else if (action.equals("getOAID")) {
            String oaid = TCAgent.getOAID(ctx);
            callbackContext.success(oaid);
            return true;
        } else if (action.equals("onRegister")) {
            String profileId = args.getString(0);
            TDProfile.ProfileType type = this.intToProfileType(args.getInt(1));
            String name = args.getString(2);
            TCAgent.onRegister(profileId, type, name);
            return true;
        } else if (action.equals("onLogin")) {
            String profileId = args.getString(0);
            TDProfile.ProfileType type = this.intToProfileType(args.getInt(1));
            String name = args.getString(2);
            TCAgent.onLogin(profileId, type, name);
            return true;
        } else if (action.equals("onPlaceOrder")) {
            String orderId = args.getString(0);
            int amount = args.getInt(1);
            String currencyType = args.getString(2);
            TCAgent.onPlaceOrder(orderId, amount, currencyType);
            return true;
        } else if (action.equals("onOrderPaySucc")) {
            String orderId = args.getString(0);
            int amount = args.getInt(1);
            String currencyType = args.getString(2);
            String paymentType = args.getString(3);
            TCAgent.onOrderPaySucc(orderId, amount, currencyType, paymentType);
            return true;
        } else if (action.equals("onCancelOrder")) {
            String orderId = args.getString(0);
            int amount = args.getInt(1);
            String currencyType = args.getString(2);
            TCAgent.onCancelOrder(orderId, amount, currencyType);
            return true;
        } else if (action.equals("onViewItem")) {
            String itemId = args.getString(0);
            String category = args.getString(1);
            String name = args.getString(2);
            int unitPrice = args.getInt(3);
            TCAgent.onViewItem(itemId, category, name, unitPrice);
            return true;
        } else if (action.equals("onAddItemToShoppingCart")) {
            String itemId = args.getString(0);
            String category = args.getString(1);
            String name = args.getString(2);
            int unitPrice = args.getInt(3);
            int amount = args.getInt(4);
            TCAgent.onAddItemToShoppingCart(itemId, category, name, unitPrice, amount);
            return true;
        } else if (action.equals("onViewShoppingCart")) {
            String shoppingCartStr = args.getString(0);
            ShoppingCart shoppingCart = this.stringToShoppingCart(shoppingCartStr);
            TCAgent.onViewShoppingCart(shoppingCart);
            return true;
        } else if (action.equals("onEvent")) {
            String eventId = args.getString(0);
            TCAgent.onEvent(ctx, eventId);
            return true;
        } else if (action.equals("onEventWithLabel")) {
            String eventId = args.getString(0);
            String eventLabel = args.getString(1);
            TCAgent.onEvent(ctx, eventId, eventLabel);
            return true;
        } else if (action.equals("onEventWithParameters")) {
            String eventId = args.getString(0);
            String eventLabel = args.getString(1);
            String eventDataJson = args.getString(2);
            if (eventDataJson != null) {
                Map<String, Object> eventData = this.toMap(eventDataJson);
                TCAgent.onEvent(ctx, eventId, eventLabel, eventData);
            }
            return true;
        } else if (action.equals("onEventWithValue")) {
            String eventId = args.getString(0);
            String eventLabel = args.getString(1);
            String eventDataJson = args.getString(2);
            double eventValue = args.getDouble(3);
            if (eventDataJson != null) {
                Map<String, Object> eventData = this.toMap(eventDataJson);
                TCAgent.onEvent(ctx, eventId, eventLabel, eventData, eventValue);
            }
            return true;
        } else if (action.equals("onPage")) {
            String pageName = args.getString(0);
            if (currPageName != null) {
                TCAgent.onPageEnd(act, currPageName);
            }
            currPageName = pageName;
            TCAgent.onPageStart(act, currPageName);
            return true;
        } else if (action.equals("onPageBegin")) {
            String pageName = args.getString(0);
            currPageName = pageName;
            TCAgent.onPageStart(act, currPageName);
            return true;
        } else if (action.equals("onPageEnd")) {
            String pageName = args.getString(0);
            TCAgent.onPageEnd(act, pageName);
            currPageName = null;
            return true;
        } 
        return false;
    }
    
    private TDProfile.ProfileType intToProfileType(final int type) {
        switch (type) {
            case 0:
                return TDProfile.ProfileType.ANONYMOUS;
            case 1:
                return TDProfile.ProfileType.REGISTERED;
            case 2:
                return TDProfile.ProfileType.SINA_WEIBO;
            case 3:
                return TDProfile.ProfileType.QQ;
            case 4:
                return TDProfile.ProfileType.QQ_WEIBO;
            case 5:
                return TDProfile.ProfileType.ND91;
            case 6:
                return TDProfile.ProfileType.WEIXIN;
            case 11:
                return TDProfile.ProfileType.TYPE1;
            case 12:
                return TDProfile.ProfileType.TYPE2;
            case 13:
                return TDProfile.ProfileType.TYPE3;
            case 14:
                return TDProfile.ProfileType.TYPE4;
            case 15:
                return TDProfile.ProfileType.TYPE5;
            case 16:
                return TDProfile.ProfileType.TYPE6;
            case 17:
                return TDProfile.ProfileType.TYPE7;
            case 18:
                return TDProfile.ProfileType.TYPE8;
            case 19:
                return TDProfile.ProfileType.TYPE9;
            case 20:
                return TDProfile.ProfileType.TYPE10;
            default:
                return TDProfile.ProfileType.ANONYMOUS;
        }
    }
    
    private Map<String, Object> toMap(String jsonStr)
    {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            JSONObject jsonObj = new JSONObject(jsonStr);
            Iterator<String> keys = jsonObj.keys();
            String key = null;
            Object value = null;
            while (keys.hasNext())
            {
                key = keys.next();
                value = jsonObj.get(key);
                result.put(key, value);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    private ShoppingCart stringToShoppingCart(String shoppingCartStr) {
        try {
            JSONObject shoppingCartJson = new JSONObject(shoppingCartStr);
            ShoppingCart shoppingCart = ShoppingCart.createShoppingCart();
            JSONArray items = shoppingCartJson.getJSONArray("items");
            for (int i=0; i<items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                shoppingCart.addItem(item.getString("itemId"), item.getString("category"), item.getString("name"), item.getInt("unitPrice"), item.getInt("amount"));
            }
            return shoppingCart;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}
